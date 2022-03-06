part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final bool isLoading;
  final BuiltList<Music> musicList;
  final Option<AppFailure> failureOption;
  final String query;

  const HomePageState({
    required this.isLoading,
    required this.musicList,
    required this.failureOption,
    required this.query,
  });

  factory HomePageState.init() => HomePageState(
        failureOption: none(),
        musicList: BuiltList(),
        isLoading: false,
        query: '',
      );

  HomePageState copyWith({
    bool? isLoading,
    BuiltList<Music>? musicList,
    AppFailure? failure,
    String? query,
  }) =>
      HomePageState(
        isLoading: isLoading ?? false,
        musicList: musicList ?? this.musicList,
        failureOption: optionOf(failure),
        query: query ?? this.query,
      );

  StateResolver get resolver {
    if (isLoading) return StateResolver.loading;
    if (failureOption.isSome()) return StateResolver.failure;
    if (musicList.isNotEmpty) return StateResolver.success;
    return StateResolver.empty;
  }

  @override
  List<Object> get props => [isLoading, musicList, failureOption, query];
}
