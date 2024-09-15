import 'package:pixabay_dummy/core/data/api_endpoints.dart';
import 'package:pixabay_dummy/core/data/network/network_api_service.dart';
import 'package:pixabay_dummy/core/environment/enviroment.dart';
import 'package:pixabay_dummy/data/models/pixa_images_model.dart';

abstract interface class PixaImageRemoteDataSource {
  Future<List<PixaImageData>> getAllImages({int perPage});
  Future<List<PixaImageData>> searchImages(String query);
}

class PixaImageRemoteDataSourceImpl implements PixaImageRemoteDataSource {
  final NetworkApiService networkApiService;

  PixaImageRemoteDataSourceImpl({required this.networkApiService});

  Map<String, dynamic> queryParameter = {
    'key': Environment.apiKey,
  };

  @override
  Future<List<PixaImageData>> getAllImages({int perPage = 10}) async {
    List<PixaImageData> pixaImageData = [];
    try {
      queryParameter['per_page'] = perPage.toString();
      final response = await networkApiService.getGetApiResponse(
        ApiEndPoint.baseApi,
        queryParameter,
      );
      PixaImagesModel pixaImagesModel = PixaImagesModel.fromJson(response);
      pixaImageData = pixaImagesModel.pixaImageData;
    } on Exception {
      rethrow;
    }
    return pixaImageData;
  }

  @override
  Future<List<PixaImageData>> searchImages(String query) async {
    List<PixaImageData> pixaImageData = [];
    try {
      final response = await networkApiService.getGetApiResponse(
        ApiEndPoint.baseApi,
        {
          'key': Environment.apiKey,
          'q': query,
        },
      );
      PixaImagesModel pixaImagesModel = PixaImagesModel.fromJson(response);
      pixaImageData = pixaImagesModel.pixaImageData;
    } on Exception {
      rethrow;
    }
    return pixaImageData;
  }
}
