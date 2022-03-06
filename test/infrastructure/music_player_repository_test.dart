import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/music_player/entities/music_player_playback.dart';
import 'package:music_explorer/src/infrastructure/music_player/music_player_repository.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

const dummyMusic =
    Music(id: 1, title: '', artist: '', album: '', previewUrl: '');
void main() {
  final MockAudioPlayer player = MockAudioPlayer();
  late MusicPlayerRepository repository;

  setUpAll(() {
    when(() => player.playerStateStream).thenAnswer((invocation) async* {
      yield PlayerState(false, ProcessingState.idle);
    });
    when(() => player.positionStream).thenAnswer((invocation) async* {
      yield const Duration();
    });
    repository = MusicPlayerRepository(player);
  });

  test(
    'Play music emit [Music Playback, Music Playback] when setUrl return (Duration)',
    () async {
      when(() => player.setUrl('')).thenAnswer((_) async => const Duration());
      when(() => player.play()).thenAnswer((_) async {});
      repository.play(dummyMusic);
      expect(
        repository.musicPlayerStream,
        emitsInOrder([
          Right<AppFailure, MusicPlayerPlayBack>(
              MusicPlayerPlayBack.init(dummyMusic)),
          Right<AppFailure, MusicPlayerPlayBack>(
              MusicPlayerPlayBack.init(dummyMusic)),
        ]),
      );
    },
  );

  test(
    'Play music emit [Music Playback, AppFailure] when setUrl return (null)',
    () async {
      when(() => player.setUrl('')).thenAnswer((_) async => null);
      when(() => player.play()).thenAnswer((_) async {});
      repository.play(dummyMusic);
      expect(
        repository.musicPlayerStream,
        emitsInOrder([
          Right<AppFailure, MusicPlayerPlayBack>(
              MusicPlayerPlayBack.init(dummyMusic)),
          Left<AppFailure, MusicPlayerPlayBack>(
              AppFailure(Exception("Music cannot be played").toString()))
        ]),
      );
    },
  );
}
