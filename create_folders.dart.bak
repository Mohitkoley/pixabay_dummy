// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  final projectPath = "${Directory.current.path}/lib";
  final directories = [
    '$projectPath/core/utils',
    '$projectPath/core/constants',
    '$projectPath/core/exceptions',
    '$projectPath/core/extensions',
    '$projectPath/core/services',
    '$projectPath/core/usecases',
    '$projectPath/core/data',
    '$projectPath/core/environment',
    '$projectPath/data/models',
    '$projectPath/data/repositories_impl',
    '$projectPath/data/datasources',
    '$projectPath/data/datasources/remote',
    '$projectPath/data/datasources/local',
    '$projectPath/domain/entities',
    '$projectPath/domain/repositories',
    '$projectPath/domain/usecases',
    '$projectPath/presentation/screens',
    '$projectPath/presentation/widgets',
  ];

  for (var dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('Created: $dir v');
    } else {
      print('Directory already exists: $dir ');
    }
  }
  print(' creating files Successfully V');
}
