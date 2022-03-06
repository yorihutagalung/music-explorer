import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/music_explorer/i_music_explorer_repository.dart';
import 'package:music_explorer/src/presentation/pages/home_page/bloc/home_page_bloc.dart';

class MockMusicRepository extends Mock implements IMusicExplorerRepository {}

final mockMusicListData = BuiltList<Music>(const [
  Music(
    id: 1,
    title: "Migraine",
    artist: "Twenty One Pilots",
    album: "Unititled",
  ),
  Music(
    id: 2,
    title: "Heathens",
    artist: "Twenty One Pilots",
    album: "Unititled",
  )
]);

void main() {
  blocTest(
    'emits [] when nothing is added',
    build: () => HomePageBloc(MockMusicRepository()),
    expect: () => [],
  );
  group('HomePageQueryChanged', () {
    late MockMusicRepository repository;

    setUp(() {
      repository = MockMusicRepository();
      when(() => repository.findAllMusic()).thenAnswer(
          (_) async => Right<AppFailure, BuiltList<Music>>(mockMusicListData));
    });
    blocTest(
      'emits loading in state [true, false] when findAllMusic returns (mockMusicListData)',
      build: () => HomePageBloc(repository),
      act: (HomePageBloc bloc) => bloc.add(const HomePageQueryChanged('test')),
      expect: () => [
        isA<HomePageState>().having((s) => s.isLoading, 'isLoading', true),
        isA<HomePageState>().having((s) => s.isLoading, 'isLoading', false),
      ],
    );

    blocTest(
      'emits musicList in state [[], mockMusicListData] when findAllMusic returns (mockMusicListData)',
      build: () => HomePageBloc(repository),
      act: (HomePageBloc bloc) {
        bloc.add(const HomePageQueryChanged('test'));
      },
      expect: () => [
        isA<HomePageState>().having((s) => s.musicList, 'musicList', isEmpty),
        isA<HomePageState>()
            .having((s) => s.musicList, 'musicList', mockMusicListData),
      ],
    );

    blocTest(
      'emits failure in state [none(), some(AppFailure)] when findAllMusic return (AppFailure)',
      build: () => HomePageBloc(repository),
      setUp: () {
        when(() => repository.findAllMusic()).thenAnswer((_) async =>
            const Left<AppFailure, BuiltList<Music>>(AppFailure("")));
      },
      act: (HomePageBloc bloc) => bloc.add(const HomePageQueryChanged('test')),
      expect: () => [
        isA<HomePageState>()
            .having((s) => s.failureOption, 'failureOption', none()),
        isA<HomePageState>().having((s) => s.failureOption, 'failureOption',
            some(const AppFailure(""))),
      ],
    );

    blocTest(
      'emits [] when query is empty',
      build: () => HomePageBloc(repository),
      act: (HomePageBloc bloc) => bloc.add(const HomePageQueryChanged('')),
      expect: () => [],
    );

    blocTest(
      'emits query in state ["", "test", "test"]',
      build: () => HomePageBloc(repository),
      act: (HomePageBloc bloc) => bloc.add(const HomePageQueryChanged('test')),
      expect: () => [
        isA<HomePageState>().having((s) => s.query, 'query', 'test'),
        isA<HomePageState>().having((s) => s.query, 'query', 'test'),
      ],
    );

    blocTest(
      'emits [] when query not changed',
      build: () => HomePageBloc(repository),
      act: (HomePageBloc bloc) => bloc.add(const HomePageQueryChanged('test')),
      seed: () => HomePageState.init().copyWith(query: 'test'),
      expect: () => [],
    );

    blocTest(
      'emits some states when query changed',
      build: () => HomePageBloc(repository),
      act: (HomePageBloc bloc) =>
          bloc.add(const HomePageQueryChanged('test 2')),
      seed: () => HomePageState.init().copyWith(query: 'test'),
      expect: () => isNotEmpty,
    );
  });
}
