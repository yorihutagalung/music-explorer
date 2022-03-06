import 'dart:convert';

import 'music_dto.dart';

class SearchMusicResultDto {
  SearchMusicResultDto({
    required this.resultCount,
    required this.results,
  });

  final int resultCount;
  final List<MusicDto> results;

  factory SearchMusicResultDto.fromRawJson(String str) =>
      SearchMusicResultDto.fromJson(json.decode(str));

  factory SearchMusicResultDto.fromJson(Map<String, dynamic> json) =>
      SearchMusicResultDto(
        resultCount: json["resultCount"] ?? 0,
        results: json["results"] == null
            ? []
            : List<MusicDto>.from(
                json["results"].map((x) => MusicDto.fromJson(x))),
      );
}
