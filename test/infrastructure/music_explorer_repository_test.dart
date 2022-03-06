import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/dto/music_dto.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/dto/search_music_result_dto.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/music_explorer_data_source.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/music_explorer_repository.dart';

class MockMusicExplorerDataSource extends Mock
    implements MusicExplorerDataSource {}

void main() {
  late MockMusicExplorerDataSource dataSource;
  late MusicExplorerRepository repository;
  setUp(() {
    dataSource = MockMusicExplorerDataSource();
    repository = MusicExplorerRepository(dataSource);
  });

  group('findAllSong return', () {
    test(
      'value should be empty built list',
      () async {
        final result = SearchMusicResultDto(resultCount: 0, results: []);
        when(() => dataSource.findAllMusic())
            .thenAnswer((invocation) => Future.value(result));
        final musicList = await repository.findAllMusic();
        expect(
            musicList, Right<AppFailure, BuiltList<Music>>(BuiltList<Music>()));
      },
    );

    test(
      'value should be non-empty built list',
      () async {
        final searchResult = SearchMusicResultDto(
            resultCount: 1, results: [const MusicDto(trackId: 1)]);

        final result =
            searchResult.results.map((e) => e.toEntity()).toBuiltList();

        when(() => dataSource.findAllMusic())
            .thenAnswer((invocation) => Future.value(searchResult));
        final musicList = await repository.findAllMusic();
        expect(musicList, Right<AppFailure, BuiltList<Music>>(result));
      },
    );

    test(
      'value should be AppFailure',
      () async {
        final exception = Exception();
        when(() => dataSource.findAllMusic()).thenThrow(exception);
        final musicList = await repository.findAllMusic();
        expect(
          musicList,
          Left<AppFailure, BuiltList<Music>>(AppFailure(exception.toString())),
        );
      },
    );
  });
}
