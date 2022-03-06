import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_explorer/src/application/music_player/music_player_cubit.dart';
import 'package:music_explorer/src/domain/music_explorer/i_music_explorer_repository.dart';
import 'package:music_explorer/src/domain/music_player/i_music_player_repository.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/music_explorer_data_source.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/music_explorer_repository.dart';
import 'package:music_explorer/src/infrastructure/music_player/music_player_repository.dart';
import 'package:music_explorer/src/presentation/pages/home_page/bloc/home_page_bloc.dart';

import '../src/infrastructure/api_helper.dart';

final getIt = GetIt.instance;

void configureInjection() {
  getIt.registerSingleton<ApiHelper>(ApiHelper());

  // Data Source
  getIt.registerFactory<MusicExplorerDataSource>(
      () => MusicExplorerDataSource(getIt<ApiHelper>()));

  // Repository
  getIt.registerSingleton<IMusicExplorerRepository>(
      MusicExplorerRepository(getIt<MusicExplorerDataSource>()));
  getIt.registerFactory<IMusicPlayerRepository>(
      () => MusicPlayerRepository(AudioPlayer()));

  // BLoC
  getIt.registerSingleton<MusicPlayerCubit>(
      MusicPlayerCubit(getIt<IMusicPlayerRepository>()));
  getIt.registerFactory<HomePageBloc>(
      () => HomePageBloc(getIt<IMusicExplorerRepository>()));
}
