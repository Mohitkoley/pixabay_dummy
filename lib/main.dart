import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_dummy/core/dependency_injection/init_dependency_import.dart';
import 'package:pixabay_dummy/core/environment/enviroment.dart';
import 'package:pixabay_dummy/presentation/bloc/pixa_image_bloc.dart';
import 'package:pixabay_dummy/presentation/screens/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.init();
  await initDependency();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Error: ${details.exceptionAsString()}',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  };
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          lazy: true,
          create: (context) => getIt<PixaImageBloc>()..add(FetchImagesEvent())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixabay Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DashboardScreen(),
    );
  }
}
