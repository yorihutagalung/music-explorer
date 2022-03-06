import 'package:equatable/equatable.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';

class MusicDto extends Equatable {
  const MusicDto({
    required this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.previewUrl,
    this.artworkUrl60,
  });

  final int trackId;
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? previewUrl;
  final String? artworkUrl60;

  factory MusicDto.fromJson(Map<String, dynamic> json) => MusicDto(
        trackId: json["trackId"],
        artistName: json["artistName"],
        collectionName: json["collectionName"],
        trackName: json["trackName"],
        previewUrl: json["previewUrl"],
        artworkUrl60: json["artworkUrl60"],
      );

  @override
  List<Object?> get props => [
        trackId,
        artistName,
        collectionName,
        trackName,
        previewUrl,
        artworkUrl60,
      ];

  Music toEntity() => Music(
        id: trackId,
        title: trackName ?? '-',
        artist: artistName ?? '-',
        album: collectionName ?? '-',
        previewUrl: previewUrl,
        imageUrl: artworkUrl60,
      );
}
