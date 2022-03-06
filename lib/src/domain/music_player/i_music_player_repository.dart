import 'package:dartz/dartz.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/music_player/entities/music_player_playback.dart';

abstract class IMusicPlayerRepository {
  Stream<Either<AppFailure, MusicPlayerPlayBack>> get musicPlayerStream;
  void play(Music music);
  void togglePauseOrPlay();
  void toggleDuration(Duration duration);
}
