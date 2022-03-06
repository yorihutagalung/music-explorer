import 'package:equatable/equatable.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
export 'music_player_disposition.dart';

import 'music_player_disposition.dart';

enum MusicPlayerStatus {
  loading,
  paused,
  playing,
}

class MusicPlayerPlayBack extends Equatable {
  final Music music;
  final MusicPlayerDisposition disposition;
  final MusicPlayerStatus status;

  const MusicPlayerPlayBack({
    required this.music,
    required this.disposition,
    required this.status,
  });

  factory MusicPlayerPlayBack.init(Music music) => MusicPlayerPlayBack(
        music: music,
        disposition: MusicPlayerDisposition.init(),
        status: MusicPlayerStatus.loading,
      );

  MusicPlayerPlayBack updateCurrentPosition(Duration currentPosition) =>
      copyWith(
          disposition: disposition.copyWith(currentPosition: currentPosition));

  MusicPlayerPlayBack copyWith({
    Music? music,
    MusicPlayerDisposition? disposition,
    MusicPlayerStatus? status,
  }) =>
      MusicPlayerPlayBack(
          music: music ?? this.music,
          disposition: disposition ?? this.disposition,
          status: status ?? this.status);

  @override
  List<Object?> get props => [music, disposition, status];
}
