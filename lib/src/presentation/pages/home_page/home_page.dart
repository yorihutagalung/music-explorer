import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:music_explorer/config/injection.dart';
import 'package:music_explorer/src/application/music_player/music_player_cubit.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/presentation/pages/const/state_resolver.dart';
import 'package:music_explorer/src/presentation/utils/ui_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_explorer/src/presentation/widgets/music_player_container.dart';

import 'bloc/home_page_bloc.dart';

part 'widgets/search_field.dart';
part 'widgets/music_list.dart';
part 'widgets/empty_body.dart';
part 'widgets/failure_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomePageBloc>(),
      child: const _HomeBodyPage(),
    );
  }
}

class _HomeBodyPage extends StatelessWidget {
  const _HomeBodyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: const _SearchField(),
      ),
      body: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          state.failureOption.fold(
            () => null,
            (failure) => UiHelper.handleFailure(failure),
          );
        },
        builder: (context, state) {
          switch (state.resolver) {
            case StateResolver.loading:
              return const Center(child: CircularProgressIndicator());
            case StateResolver.failure:
              return _FailureBody(failure: state.failureOption.toNullable());
            case StateResolver.empty:
              return const _EmptyBody();
            case StateResolver.success:
              return _MusicList(list: state.musicList);
          }
        },
      ),
      bottomNavigationBar: const MusicPlayerContainer(),
    );
  }
}
