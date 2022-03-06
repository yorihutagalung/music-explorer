import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_explorer/config/injection.dart';
import 'package:music_explorer/src/application/music_player/music_player_cubit.dart';
import 'package:music_explorer/src/presentation/router.dart';
import 'package:music_explorer/src/presentation/utils/ui_helper.dart';

class MusicExplorerApp extends StatelessWidget {
  const MusicExplorerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MusicPlayerCubit>(),
      child: _Configuration(
        child: MaterialApp(
          navigatorKey: AppRouter.navigatorKey,
          title: 'Music Explorer',
          theme: ThemeData(primarySwatch: Colors.brown),
          routes: AppRouter.routes,
          initialRoute: AppRouter.initialRoute,
        ),
      ),
    );
  }
}

class _Configuration extends StatelessWidget {
  final Widget child;

  const _Configuration({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MusicPlayerCubit, MusicPlayerState>(
      listener: (context, state) {
        state.failureOption.fold(
          () => null,
          (failure) => UiHelper.handleFailure(failure),
        );
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          navigatorKey: AppRouter.navigatorKey,
          title: 'Music Explorer',
          theme: ThemeData(primarySwatch: Colors.brown),
          routes: AppRouter.routes,
          initialRoute: AppRouter.initialRoute,
        ),
      ),
    );
  }
}
