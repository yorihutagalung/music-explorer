import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_explorer/src/application/music_player/music_player_cubit.dart';
import 'package:music_explorer/src/domain/music_player/entities/music_player_playback.dart';
import 'package:music_explorer/src/presentation/utils/ui_helper.dart';

import '../../domain/music_explorer/entities/music.dart';

class MusicPlayerContainer extends StatelessWidget {
  const MusicPlayerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) {
        return state.playBackOption.fold(
          () => const SizedBox.shrink(),
          (playBack) => Container(
            padding: EdgeInsets.only(top: UiGap.medium.size),
            color: Colors.black12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: _MusicDetail(music: playBack.music)),
                    const _PlayBackActionButton(),
                  ],
                ),
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

class _MusicDetail extends StatelessWidget {
  final Music music;
  const _MusicDetail({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: UiGap.normal.size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            music.title,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          UiGap.small.verticalSpace,
          Text(
            music.artist,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
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
                visualDensity: VisualDensity.compact,
                onPressed: null,
                icon: Icon(Icons.skip_previous),
              ),
              getPlayOrPauseIcon(context, playBack.status),
              const IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: null,
                icon: Icon(Icons.skip_next),
              ),
              UiGap.medium.horizontalSpace,
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
