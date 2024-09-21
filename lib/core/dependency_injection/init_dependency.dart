part of 'init_dependency_import.dart';

final getIt = GetIt.instance;

Future<void> initDependency() async {
  //registering dependencies
  getIt.registerLazySingleton(() => NetworkApiService());
  getIt.registerLazySingleton<PixaImageRemoteDataSource>(
      () => PixaImageRemoteDataSourceImpl(networkApiService: getIt()));
  getIt.registerLazySingleton<PixaImageRepo>(() => PixaImageRepoImpl(getIt()));
  getIt.registerLazySingleton(() => GetImages(getIt()));
  getIt.registerLazySingleton(() => SearchImages(getIt()));

  getIt.registerLazySingleton(
      () => PixaImageBloc(getImages: getIt(), searchImages: getIt()));
}
