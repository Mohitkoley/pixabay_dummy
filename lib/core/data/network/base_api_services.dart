import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(
      String path, Map<String, dynamic> queryParameter,
      [String baseUrl]);

  Future<dynamic> getPostApiResponse(String url, dynamic data);

  Future<dynamic> getPutApiResponse(
    String url,
    dynamic data,
  );

  Future<dynamic> getDeleteApiResponse(
    String url,
    dynamic data,
  );

  Future<dynamic> getPostMultiPartApiResponse(
      String url, Map<String, String> data, File image);

  // Future<void> connectSocketIO(String email);

  // Stream<dynamic> listenToSocketIO(String event);

  // Future<void> closeSocketIO();

  // Future<dynamic> computeGetApiResponse(
  //     String path, Map<String, dynamic> queryParameter,
  //     [String baseUrl]);
}
