import 'package:equatable/equatable.dart';

class MusicPlayerDisposition extends Equatable {
  final Duration duration;
  final Duration currentPosition;

  const MusicPlayerDisposition({
    required this.duration,
    required this.currentPosition,
  });

  factory MusicPlayerDisposition.init([Duration? duration]) =>
      MusicPlayerDisposition(
        duration: duration ?? const Duration(),
        currentPosition: const Duration(),
      );

  MusicPlayerDisposition copyWith({
    Duration? duration,
    Duration? currentPosition,
  }) =>
      MusicPlayerDisposition(
        duration: duration ?? this.duration,
        currentPosition: currentPosition ?? this.currentPosition,
      );

  double get maxValue {
    if (currentPosition > duration) {
      return currentPosition.inMilliseconds.toDouble();
    }
    return duration.inMilliseconds.toDouble();
  }

  double get value {
    return currentPosition.inMilliseconds.toDouble();
  }

  @override
  List<Object?> get props => [duration, currentPosition];
}
