import 'package:pixabay_dummy/core/usecase/usecase.dart';
import 'package:pixabay_dummy/data/models/pixa_images_model.dart';
import 'package:pixabay_dummy/domain/repositories/pixa_image_repo.dart';

class GetImages implements UseCase<List<PixaImageData>, PerPageParam> {
  final PixaImageRepo repository;

  GetImages(this.repository);

  @override
  Future<List<PixaImageData>> call(params) async {
    return await repository.getAllImages(perPage: params.perPage);
  }
}

class PerPageParam {
  final int perPage;

  PerPageParam({this.perPage = 10});
}
