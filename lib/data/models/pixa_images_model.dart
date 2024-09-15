// To parse this JSON data, do
//
//     final pixaImagesModel = pixaImagesModelFromJson(jsonString);

import 'dart:convert';

PixaImagesModel pixaImagesModelFromJson(String str) =>
    PixaImagesModel.fromJson(json.decode(str));

String pixaImagesModelToJson(PixaImagesModel data) =>
    json.encode(data.toJson());

class PixaImagesModel {
  int total;
  int totalHits;
  List<PixaImageData> pixaImageData;

  PixaImagesModel({
    required this.total,
    required this.totalHits,
    required this.pixaImageData,
  });

  PixaImagesModel copyWith({
    int? total,
    int? totalHits,
    List<PixaImageData>? hits,
  }) =>
      PixaImagesModel(
        total: total ?? this.total,
        totalHits: totalHits ?? this.totalHits,
        pixaImageData: hits ?? pixaImageData,
      );

  factory PixaImagesModel.fromJson(Map<String, dynamic> json) =>
      PixaImagesModel(
        total: json["total"],
        totalHits: json["totalHits"],
        pixaImageData: List<PixaImageData>.from(
            json["hits"].map((x) => PixaImageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits": List<dynamic>.from(pixaImageData.map((x) => x.toJson())),
      };
}

class PixaImageData {
  int id;
  String pageUrl;
  Type? type;
  String tags;
  String previewUrl;
  int previewWidth;
  int previewHeight;
  String webformatUrl;
  int webformatWidth;
  int webformatHeight;
  String largeImageUrl;
  int imageWidth;
  int imageHeight;
  int imageSize;
  int views;
  int downloads;
  int collections;
  int likes;
  int comments;
  int userId;

  String userImageUrl;

  PixaImageData({
    required this.id,
    required this.pageUrl,
    this.type,
    required this.tags,
    required this.previewUrl,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatUrl,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.userImageUrl,
  });

  PixaImageData copyWith({
    int? id,
    String? pageUrl,
    Type? type,
    String? tags,
    String? previewUrl,
    int? previewWidth,
    int? previewHeight,
    String? webformatUrl,
    int? webformatWidth,
    int? webformatHeight,
    String? largeImageUrl,
    int? imageWidth,
    int? imageHeight,
    int? imageSize,
    int? views,
    int? downloads,
    int? collections,
    int? likes,
    int? comments,
    int? userId,
    String? userImageUrl,
  }) =>
      PixaImageData(
        id: id ?? this.id,
        pageUrl: pageUrl ?? this.pageUrl,
        type: type ?? this.type,
        tags: tags ?? this.tags,
        previewUrl: previewUrl ?? this.previewUrl,
        previewWidth: previewWidth ?? this.previewWidth,
        previewHeight: previewHeight ?? this.previewHeight,
        webformatUrl: webformatUrl ?? this.webformatUrl,
        webformatWidth: webformatWidth ?? this.webformatWidth,
        webformatHeight: webformatHeight ?? this.webformatHeight,
        largeImageUrl: largeImageUrl ?? this.largeImageUrl,
        imageWidth: imageWidth ?? this.imageWidth,
        imageHeight: imageHeight ?? this.imageHeight,
        imageSize: imageSize ?? this.imageSize,
        views: views ?? this.views,
        downloads: downloads ?? this.downloads,
        collections: collections ?? this.collections,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        userId: userId ?? this.userId,
        userImageUrl: userImageUrl ?? this.userImageUrl,
      );

  factory PixaImageData.fromJson(Map<String, dynamic> json) => PixaImageData(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: typeValues.map[json["type"]],
        tags: json["tags"],
        previewUrl: json["previewURL"],
        previewWidth: json["previewWidth"],
        previewHeight: json["previewHeight"],
        webformatUrl: json["webformatURL"],
        webformatWidth: json["webformatWidth"],
        webformatHeight: json["webformatHeight"],
        largeImageUrl: json["largeImageURL"],
        imageWidth: json["imageWidth"],
        imageHeight: json["imageHeight"],
        imageSize: json["imageSize"],
        views: json["views"],
        downloads: json["downloads"],
        collections: json["collections"],
        likes: json["likes"],
        comments: json["comments"],
        userId: json["user_id"],
        userImageUrl: json["userImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "type": typeValues.reverse[type],
        "tags": tags,
        "previewURL": previewUrl,
        "previewWidth": previewWidth,
        "previewHeight": previewHeight,
        "webformatURL": webformatUrl,
        "webformatWidth": webformatWidth,
        "webformatHeight": webformatHeight,
        "largeImageURL": largeImageUrl,
        "imageWidth": imageWidth,
        "imageHeight": imageHeight,
        "imageSize": imageSize,
        "views": views,
        "downloads": downloads,
        "collections": collections,
        "likes": likes,
        "comments": comments,
        "user_id": userId,
        "userImageURL": userImageUrl,
      };
}

enum Type { ILLUSTRATION }

final typeValues = EnumValues({"illustration": Type.ILLUSTRATION});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
