import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_explorer/src/application/music_player/music_player_cubit.dart';
import 'package:music_explorer/src/domain/music_player/entities/music_player_playback.dart';

class MusicPlayerContainer extends StatelessWidget {
  const MusicPlayerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) {
        return state.playBackOption.fold(
          () => const SizedBox.shrink(),
          (playBack) => Container(
            color: Colors.black12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _PlayBackActionButton(),
                Slider(
                  value: playBack.disposition.value,
                  min: 0,
                  max: playBack.disposition.maxValue,
                  onChanged:
                      BlocProvider.of<MusicPlayerCubit>(context).togglePosition,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlayBackActionButton extends StatelessWidget {
  const _PlayBackActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) => state.playBackOption.fold(
        () => const SizedBox.shrink(),
        (playBack) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.skip_previous),
              ),
              getPlayOrPauseIcon(context, playBack.status),
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.skip_next),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getPlayOrPauseIcon(BuildContext context, MusicPlayerStatus status) {
    final bool isPlaying = status == MusicPlayerStatus.playing;
    final bool isLoading = status == MusicPlayerStatus.loading;

    return IndexedStack(
      index: isLoading ? 0 : 1,
      alignment: Alignment.center,
      children: [
        const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        IconButton(
          splashRadius: 18,
          onPressed:
              BlocProvider.of<MusicPlayerCubit>(context).togglePauseOrPlay,
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        )
      ],
    );
  }
}
