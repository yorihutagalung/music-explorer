import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/music_explorer/i_music_explorer_repository.dart';

import 'music_explorer_data_source.dart';

class MusicExplorerRepository implements IMusicExplorerRepository {
  final MusicExplorerDataSource _musicDataSource;
  const MusicExplorerRepository(this._musicDataSource);
  @override
  Future<Either<AppFailure, BuiltList<Music>>> findAllMusic(
      {String query = ''}) async {
    await Future.delayed(Duration(seconds: 1));
    return left(AppFailure("error"));
    try {
      final musicList = await _musicDataSource.findAllMusic(query: query);
      return right(musicList.results.map((e) => e.toEntity()).toBuiltList());
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
