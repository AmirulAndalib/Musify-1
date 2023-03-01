import 'package:on_audio_query/on_audio_query.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();

Future<List<SongModel>> getLocalMusic({searchQuery}) async {
  final allSongs = await _audioQuery.querySongs();
  if (searchQuery != null) {
    return allSongs
        .where(
          (song) =>
              song.isAlarm == false &&
              song.isNotification == false &&
              song.isRingtone == false &&
              song.displayName
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()),
        )
        .toList();
  } else {
    return allSongs
        .where(
          (song) =>
              song.isAlarm == false &&
              song.isNotification == false &&
              song.isRingtone == false,
        )
        .toList();
  }
}

Future<List<ArtistModel>> getArtists() async {
  final _artists = await _audioQuery.queryArtists();
  return _artists;
}
