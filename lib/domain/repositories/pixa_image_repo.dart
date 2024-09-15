import 'package:pixabay_dummy/data/models/pixa_images_model.dart';

abstract interface class PixaImageRepo {
  Future<List<PixaImageData>> getAllImages({int perPage});
  Future<List<PixaImageData>> searchImages(String query);
}
