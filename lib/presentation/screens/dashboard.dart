import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_dummy/core/extensions/context_ext.dart';
import 'package:pixabay_dummy/core/utils/debouncing.dart';
import 'package:pixabay_dummy/data/models/pixa_images_model.dart';
import 'package:pixabay_dummy/presentation/bloc/pixa_image_bloc.dart';
import 'package:pixabay_dummy/presentation/screens/full_image_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();

  int perPage = 10;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        perPage += 10;
        context.read<PixaImageBloc>().add(FetchImagesAtBottom(perPage));
      }
    });
  }

  final ScrollController _scrollController = ScrollController();

  Debouncing debouncing = Debouncing(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<PixaImageBloc, PixaImageBlocState>(
        listener: (context, state) {
          if (state is ImageBlocError) {
            context.showSnackBar(state.message);
          }
        },
        buildWhen: (previous, current) {
          if (current is ImageBlocLoaded) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is ImageBlocLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ImageBlocError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is ImageBlocLoaded) {
            return LayoutBuilder(builder: (context, constrains) {
              int maxItemsPerRow =
                  _calculateMaxItemsPerRow(constrains.maxWidth);
              final loadedState = state;
              return SafeArea(
                child: Column(
                  children: [
                    //search bar
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          debouncing.run(() {
                            context
                                .read<PixaImageBloc>()
                                .add(SearchImagesEvent(_searchController.text));
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search for images',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Scrollbar(
                      thickness: 8,
                      controller: _scrollController,
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: maxItemsPerRow,
                          childAspectRatio: 1,
                        ),
                        // if the hasMoreData is true add a circular progress indicator
                        itemCount: loadedState.images.length +
                            (state.hasMoreData ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= loadedState.images.length) {
                            return SizedBox(
                              height: 100,
                              width: context.width,
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: context.width,
                                  child: const Text(
                                    'Loading...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          final PixaImageData pixaImageData =
                              loadedState.images[index];
                          return InkWell(
                            onTap: () {
                              //open
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  settings: const RouteSettings(name: '/full_image'),
                                  builder: (context) => FullImageScreen(
                                    imageData: pixaImageData,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: pixaImageData.id,
                              child: Container(
                                key: ValueKey(pixaImageData.id),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.images[index].webformatUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // show likes and views
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                pixaImageData.likes.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                pixaImageData.views.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                  ],
                ),
              );
            });
          }
          return const SizedBox();
        },
      ),
      // show floating action button to scroll to top if user scrolls down
      floatingActionButton: _scrollController.position.pixels > 0
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  int _calculateMaxItemsPerRow(double maxWidth) {
    // Adjust this value based on your desired layout
    if (maxWidth > 1200) {
      return 4;
    } else if (maxWidth > 900) {
      return 3;
    } else if (maxWidth > 600) {
      return 2;
    } else if (maxWidth > 300) {
      return 2;
    } else {
      return 1;
    }
  }
}
