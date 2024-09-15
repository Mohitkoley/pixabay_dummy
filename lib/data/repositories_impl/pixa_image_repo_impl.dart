import 'package:pixabay_dummy/data/datasources/remote/image_remote_data_source.dart';
import 'package:pixabay_dummy/data/models/pixa_images_model.dart';
import 'package:pixabay_dummy/domain/repositories/pixa_image_repo.dart';

class PixaImageRepoImpl implements PixaImageRepo {
  final PixaImageRemoteDataSource _pixaImageRemoteDataSource;

  PixaImageRepoImpl(
    this._pixaImageRemoteDataSource,
  );

  @override
  Future<List<PixaImageData>> getAllImages({int perPage = 10}) {
    try {
      return _pixaImageRemoteDataSource.getAllImages(perPage: perPage);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PixaImageData>> searchImages(String query) {
    try {
      return _pixaImageRemoteDataSource.searchImages(query);
    } catch (e) {
      rethrow;
    }
  }
}
