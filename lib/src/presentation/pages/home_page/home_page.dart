import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:music_explorer/config/injection.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/presentation/pages/const/state_resolver.dart';
import 'package:music_explorer/src/presentation/utils/ui_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_page_bloc.dart';

part 'widgets/search_field.dart';
part 'widgets/music_list.dart';

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
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          switch (state.resolver) {
            case StateResolver.loading:
              return const Center(child: CircularProgressIndicator());
            case StateResolver.failure:
              return const SizedBox.shrink();
            case StateResolver.empty:
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: UiGap.big.size),
                child: Text(
                  "No music found.\nTry to search musics by artist name \nin the field above",
                  textAlign: TextAlign.center,
                ),
              );
            case StateResolver.success:
              return _MusicList(list: state.musicList);
          }
        },
      ),
    );
  }
}
