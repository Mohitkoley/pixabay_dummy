part of 'pixa_image_bloc.dart';

sealed class PixaImageBlocState {}

final class ImageBlocInitial extends PixaImageBlocState {}

final class ImageBlocLoading extends PixaImageBlocState {}

final class ImageBlocLoaded extends PixaImageBlocState {
  final List<PixaImageData> images;
  final int perPage;
  final bool hasMoreData;
  ImageBlocLoaded(this.images, {this.perPage = 10, this.hasMoreData = true});

  //copyWith method
  ImageBlocLoaded copyWith({
    List<PixaImageData>? images,
    int? perPage,
    bool? hasMoreData,
  }) {
    return ImageBlocLoaded(
      images ?? this.images,
      perPage: perPage ?? this.perPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

final class ImageBlocError extends PixaImageBlocState {
  final String message;
  ImageBlocError(this.message);
}
