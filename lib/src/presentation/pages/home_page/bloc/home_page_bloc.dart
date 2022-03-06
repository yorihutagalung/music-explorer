import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/music_explorer/i_music_explorer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:music_explorer/src/presentation/pages/const/state_resolver.dart';
import 'package:rxdart/rxdart.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final IMusicExplorerRepository _musicExplorerRepository;
  HomePageBloc(this._musicExplorerRepository) : super(HomePageState.init()) {
    on<HomePageQueryChanged>(
      _onQueryChanged,
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(seconds: 1)).switchMap(mapper),
    );

    on<HomePageRefreshCalled>(_onRefreshCalled);
  }

  FutureOr<void> _onQueryChanged(
    HomePageQueryChanged event,
    Emitter<HomePageState> emit,
  ) async {
    if (event.query.isEmpty) return;
    if (event.query == state.query) return;
    emit(state.copyWith(isLoading: true, query: event.query));
    final failureOrMusicList =
        await _musicExplorerRepository.findAllMusic(query: event.query);
    emit(failureOrMusicList.fold(
      (failure) => state.copyWith(failure: failure),
      (musicList) => state.copyWith(musicList: musicList),
    ));
  }

  FutureOr<void> _onRefreshCalled(
    HomePageRefreshCalled event,
    Emitter<HomePageState> emit,
  ) async {
    if (state.query.isEmpty) return;
    emit(state.copyWith(isLoading: true, query: state.query));
    final failureOrMusicList =
        await _musicExplorerRepository.findAllMusic(query: state.query);
    emit(failureOrMusicList.fold(
      (failure) => state.copyWith(failure: failure),
      (musicList) => state.copyWith(musicList: musicList),
    ));
  }
}
