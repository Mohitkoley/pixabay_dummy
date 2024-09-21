import 'package:pixabay_dummy/core/usecase/usecase.dart';
import 'package:pixabay_dummy/data/models/pixa_images_model.dart';
import 'package:pixabay_dummy/domain/repositories/pixa_image_repo.dart';

class SearchImages implements UseCase<List<PixaImageData>, SearchParam> {
  final PixaImageRepo _imageRepository;

  SearchImages(this._imageRepository);

  @override
  Future<List<PixaImageData>> call(params) async {
    return await _imageRepository.searchImages(params.query);
  }
}

class SearchParam {
  final String query;

  SearchParam({required this.query});
}
