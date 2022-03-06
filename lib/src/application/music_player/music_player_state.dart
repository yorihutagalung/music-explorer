part of 'music_player_cubit.dart';

class MusicPlayerState extends Equatable {
  final Option<MusicPlayerPlayBack> playBackOption;
  final Option<AppFailure> failureOption;

  const MusicPlayerState({
    required this.playBackOption,
    required this.failureOption,
  });

  factory MusicPlayerState.init() =>
      MusicPlayerState(playBackOption: none(), failureOption: none());

  MusicPlayerState copyWith({
    Option<MusicPlayerPlayBack>? playBackOption,
    Option<AppFailure>? failureOption,
  }) =>
      MusicPlayerState(
          playBackOption: playBackOption ?? this.playBackOption,
          failureOption: failureOption ?? none());

  @override
  List<Object> get props => [playBackOption, failureOption];
}
