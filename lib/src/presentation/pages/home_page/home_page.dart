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
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: UiGap.big.size),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.failureOption.toNullable()?.error ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 5,
                    ),
                    UiGap.big.verticalSpace,
                    OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<HomePageBloc>(context)
                            .add(const HomePageRefreshCalled());
                      },
                      child: const Text("Refresh"),
                    ),
                  ],
                ),
              );
            case StateResolver.empty:
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: UiGap.big.size),
                child: const Text(
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
