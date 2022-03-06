import 'package:get_it/get_it.dart';
import 'package:music_explorer/src/infrastructure/mocks/mock_music_explorer_repository.dart';
import 'package:music_explorer/src/presentation/pages/home_page/bloc/home_page_bloc.dart';

final getIt = GetIt.instance;

void configureInjection() {
  //BLoC
  getIt.registerFactory<HomePageBloc>(
      () => HomePageBloc(MockMusicExplorerRepository()));
}
