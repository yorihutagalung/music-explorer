import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/music_player/entities/music_player_playback.dart';
import 'package:music_explorer/src/domain/music_player/i_music_player_repository.dart';
import 'package:rxdart/rxdart.dart';

class MusicPlayerRepository extends Disposable
    implements IMusicPlayerRepository {
  final AudioPlayer _player;
  final BehaviorSubject<MusicPlayerPlayBack> _playBackSubject =
      BehaviorSubject();
  late StreamSubscription<void> _playerStreamSubscription;

  @override
  Stream<Either<AppFailure, MusicPlayerPlayBack>> get musicPlayerStream =>
      _playBackSubject.stream
          .map<Either<AppFailure, MusicPlayerPlayBack>>((event) => right(event))
          .onErrorReturnWith((err, _) => left(AppFailure(err.toString())));

  MusicPlayerRepository(this._player) {
    _playerStreamSubscription = CombineLatestStream.combine2<PlayerState,
        Duration, MusicPlayerPlayBack?>(
      _player.playerStateStream,
      _player.positionStream,
      _stateAndPositionCombiner,
    ).listen(_combindedStreamListener);
  }

  MusicPlayerPlayBack? _stateAndPositionCombiner(
    PlayerState state,
    Duration position,
  ) {
    if (_playBackSubject.hasValue) {
      final newPlayBack = _playBackSubject.value
          .updateCurrentPosition(position)
          .copyWith(status: _parseStatusFromState(state));
      return newPlayBack;
    }
    return null;
  }

  void _combindedStreamListener(MusicPlayerPlayBack? playBack) {
    if (playBack != null) {
      _playBackSubject.add(playBack);
    }
  }

  MusicPlayerStatus _parseStatusFromState(PlayerState state) {
    final processingState = state.processingState;
    if (_checkIfStateIsLoading(state)) {
      return MusicPlayerStatus.loading;
    } else if (state.playing != true) {
      return MusicPlayerStatus.paused;
    } else if (processingState != ProcessingState.completed) {
      return MusicPlayerStatus.playing;
    } else {
      return MusicPlayerStatus.paused;
    }
  }

  static bool _checkIfStateIsLoading(PlayerState state) {
    return state.processingState == ProcessingState.loading ||
        state.processingState == ProcessingState.buffering;
  }

  @override
  FutureOr<void> play(Music music) async {
    try {
      if (music.previewUrl == null) throw Exception("Music cannot be played");
      final playBack = MusicPlayerPlayBack.init(music);
      _playBackSubject.add(playBack);

      final duration = await _player.setUrl(music.previewUrl!);
      if (duration == null) throw Exception("Music cannot be played");
      final disposition = MusicPlayerDisposition.init(duration);
      final playBackWithDuration = playBack.copyWith(disposition: disposition);
      _playBackSubject.add(playBackWithDuration);
      await _player.play();
    } on Exception catch (e) {
      _playBackSubject.addError(e);
    } catch (e) {
      _playBackSubject.addError(Exception(e));
    }
  }

  @override
  void togglePauseOrPlay() async {
    try {
      if (_checkIfStateIsLoading(_player.playerState)) {
        return;
      } else if (_player.playing) {
        _player.pause();
      } else {
        _player.play();
      }
    } on Exception catch (e) {
      _playBackSubject.addError(e);
    } catch (e) {
      _playBackSubject.addError(Exception(e));
    }
  }

  @override
  void toggleDuration(Duration duration) async {
    try {
      await _player.seek(duration);
    } on Exception catch (e) {
      _playBackSubject.addError(e);
    } catch (e) {
      _playBackSubject.addError(Exception(e));
    }
  }

  @override
  FutureOr onDispose() {
    _playBackSubject.close();
    _playerStreamSubscription.cancel();
    _player.stop();
  }
}
