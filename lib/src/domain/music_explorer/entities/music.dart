import 'package:equatable/equatable.dart';

class Music extends Equatable {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String? previewUrl;
  final String? imageUrl;

  const Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    this.previewUrl,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, artist, album, previewUrl, imageUrl];
}
