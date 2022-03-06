import 'package:get_it/get_it.dart';
import 'package:music_explorer/src/domain/music_explorer/i_music_explorer_repository.dart';
import 'package:music_explorer/src/infrastructure/mocks/mock_music_explorer_repository.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/music_explorer_data_source.dart';
import 'package:music_explorer/src/infrastructure/music_explorer/music_explorer_repository.dart';
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

  // BLoC
  getIt.registerFactory<HomePageBloc>(
      () => HomePageBloc(getIt<IMusicExplorerRepository>()));
}
