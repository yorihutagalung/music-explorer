import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/music_player/entities/music_player_playback.dart';
import 'package:music_explorer/src/domain/music_player/i_music_player_repository.dart';

part 'music_player_state.dart';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final IMusicPlayerRepository _musicPlayerRepository;
  late StreamSubscription _streamSubscription;
  MusicPlayerCubit(this._musicPlayerRepository)
      : super(MusicPlayerState.init()) {
    _streamSubscription =
        _musicPlayerRepository.musicPlayerStream.listen(_playBackListener);
  }

  void play(Music music) => _musicPlayerRepository.play(music);

  void togglePauseOrPlay() => _musicPlayerRepository.togglePauseOrPlay();

  void togglePosition(double position) {
    final duration = Duration(milliseconds: position.floor());
    _musicPlayerRepository.toggleDuration(duration);
  }

  void _playBackListener(
    Either<AppFailure, MusicPlayerPlayBack> failureOrPlayBack,
  ) {
    emit(
      failureOrPlayBack.fold(
        (failure) => state.copyWith(failureOption: some(failure)),
        (playBack) => state.copyWith(playBackOption: some(playBack)),
      ),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
