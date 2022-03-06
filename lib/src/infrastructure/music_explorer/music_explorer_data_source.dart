import 'dart:async';

import 'package:music_explorer/src/infrastructure/api_helper.dart';

import 'dto/search_music_result_dto.dart';

class MusicExplorerDataSource {
  final ApiHelper _helper;

  const MusicExplorerDataSource(this._helper);
  Future<SearchMusicResultDto> findAllMusic({String query = ''}) async {
    final response = await _helper.get(
      path: 'https://itunes.apple.com/search',
      queryParameters: {
        'term': query.replaceAll(RegExp('\\s+'), '+'),
        'entity': 'song',
      },
    );
    return SearchMusicResultDto.fromRawJson(response);
  }
}
