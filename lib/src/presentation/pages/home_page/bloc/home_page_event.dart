part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class HomePageQueryChanged extends HomePageEvent {
  final String query;
  const HomePageQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class HomePageRefreshCalled extends HomePageEvent {
  const HomePageRefreshCalled();

  @override
  List<Object> get props => [];
}
