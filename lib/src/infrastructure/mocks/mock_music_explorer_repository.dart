import 'package:built_collection/built_collection.dart';
import 'package:music_explorer/src/domain/music_explorer/entities/music.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_explorer/src/domain/music_explorer/i_music_explorer_repository.dart';

class MockMusicExplorerRepository implements IMusicExplorerRepository {
  @override
  Future<Either<AppFailure, BuiltList<Music>>> findAllMusic(
      {String query = ''}) async {
    await Future.delayed(const Duration(seconds: 2));
    return right(
      BuiltList(
        const [
          Music(
            id: 1,
            title: "Migraine",
            artist: "Twenty One Pilots",
            album: "Unititled",
            imageUrl:
                "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg",
          ),
          Music(
            id: 2,
            title: "Heathens",
            artist: "Twenty One Pilots",
            album: "Unititled",
            imageUrl:
                "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg",
          ),
          Music(
            id: 3,
            title: "Stressed Out",
            artist: "Twenty One Pilots",
            album: "Unititled",
            imageUrl:
                "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg",
          ),
          Music(
            id: 4,
            title: "Ride",
            artist: "Twenty One Pilots",
            album: "Unititled",
            imageUrl:
                "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg",
          ),
          Music(
            id: 5,
            title: "Chlorine",
            artist: "Twenty One Pilots",
            album: "Unititled",
            imageUrl:
                "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg",
          )
        ],
      ),
    );
  }
}
