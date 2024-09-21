part of 'pixa_image_bloc.dart';

sealed class PixaImageBlocEvent {}

final class FetchImagesEvent extends PixaImageBlocEvent {
  FetchImagesEvent();
}

final class FetchImagesAtBottom extends FetchImagesEvent {
  int perPage;

  FetchImagesAtBottom(this.perPage);
}

final class SearchImagesEvent extends PixaImageBlocEvent {
  final String query;
  SearchImagesEvent(this.query);
}
