import 'package:equatable/equatable.dart';

class AppFailure extends Equatable {
  final String error;
  const AppFailure(this.error);
  @override
  List<Object?> get props => [error];
}
