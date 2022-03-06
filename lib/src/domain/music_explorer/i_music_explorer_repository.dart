import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';

abstract class IMusicExplorerRepository {
  Future<Either<AppFailure, BuiltList<Music>>> findAllMusic(
      {String query = ''});
}
