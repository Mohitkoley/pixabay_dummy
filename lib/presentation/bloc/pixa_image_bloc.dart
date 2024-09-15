import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_dummy/core/exceptions/exception.dart';
import 'package:pixabay_dummy/data/models/pixa_images_model.dart';
import 'package:pixabay_dummy/domain/usecases/get_images.dart';
import 'package:pixabay_dummy/domain/usecases/search_images.dart';

part 'pixa_image_bloc_event.dart';
part 'pixa_image_bloc_state.dart';

class PixaImageBloc extends Bloc<PixaImageBlocEvent, PixaImageBlocState> {
  PixaImageBloc({
    required GetImages getImages,
    required SearchImages searchImages,
  })  : _getImages = getImages,
        _searchImages = searchImages,
        super(ImageBlocInitial()) {
    on<PixaImageBlocEvent>((event, emit) {});
    on<FetchImagesEvent>(_onFetchImage);
    on<FetchImagesAtBottom>(_onFetchImagesAtBottom);
    on<SearchImagesEvent>(_onSearch);
  }

  final GetImages _getImages;
  final SearchImages _searchImages;

  int _perPage = 43;
  bool _hasMoreData = true;

  List<PixaImageData> imagesList = [];

  _onFetchImage(
    FetchImagesEvent event,
    Emitter<PixaImageBlocState> emit,
  ) async {
    emit(ImageBlocLoading());
    try {
      final images = await _getImages(PerPageParam(perPage: _perPage));
      imagesList = images;
      emit(ImageBlocLoaded(images));
    } on ServerException catch (e) {
      emit(ImageBlocError(e.message));
    }
  }

  void _onFetchImagesAtBottom(
      FetchImagesAtBottom event, Emitter<PixaImageBlocState> emit) async {
    if (_hasMoreData) {
      try {
        _perPage = event.perPage;
        final images = await _getImages(PerPageParam(perPage: event.perPage));

        //check if the data is less than 300
        _hasMoreData = _perPage < 300;
        if (state is ImageBlocLoaded) {
          var currentState = state as ImageBlocLoaded;
          // first compare the length of the images to the current state images then add the new images
          int lengthOfCurrentImage = imagesList.length;

          // Ensure the start index is within the bounds of the images list
          if (lengthOfCurrentImage < images.length) {
            // Add from [lengthOfCurrentImage] to the end of the images
            imagesList.addAll(images.sublist(lengthOfCurrentImage));
          } else {
            // Handle the case where lengthOfCurrentImage is out of bounds
            // For example, you might want to log an error or take some other action
            debugPrint('Error: lengthOfCurrentImage is out of bounds');
          }

          currentState = currentState.copyWith(
            images: imagesList,
            perPage: _perPage,
            hasMoreData: _hasMoreData,
          );
          debugPrint(
              'images length: ${currentState.images.length} perPage: $_perPage hasMoreData: $_hasMoreData currentState perPage ${currentState.perPage}');

          emit(currentState);
        }
      } on ServerException catch (e) {
        emit(ImageBlocError(e.message));
      }
    }
  }

  _onSearch(SearchImagesEvent event, Emitter<PixaImageBlocState> emit) async {
    emit(ImageBlocLoading());
    try {
      final images = await _searchImages(SearchParam(query: event.query));

      emit(ImageBlocLoaded(images));
    } on ServerException catch (e) {
      emit(ImageBlocError(e.message));
    }
  }
}
