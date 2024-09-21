import 'package:get_it/get_it.dart';
import 'package:pixabay_dummy/core/data/network/network_api_service.dart';
import 'package:pixabay_dummy/data/datasources/remote/image_remote_data_source.dart';
import 'package:pixabay_dummy/data/repositories_impl/pixa_image_repo_impl.dart';
import 'package:pixabay_dummy/domain/repositories/pixa_image_repo.dart';
import 'package:pixabay_dummy/domain/usecases/get_images.dart';
import 'package:pixabay_dummy/domain/usecases/search_images.dart';
import 'package:pixabay_dummy/presentation/bloc/pixa_image_bloc.dart';

part 'init_dependency.dart';
