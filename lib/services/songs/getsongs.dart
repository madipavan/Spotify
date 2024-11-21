import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/models/song_model.dart';
import 'package:spotify/services/favsongs/fav_songs_service.dart';

abstract class SongsFirebaseService {
  Future<List<SongModel>> getNewSongs();
}

class SongsFirebaseServiceimpl extends SongsFirebaseService {
  @override
  Future<List<SongModel>> getNewSongs() async {
    try {
      List<SongModel> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy("releseDate", descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        bool isfavourite =
            await FavSongsService().isFavSong(element.reference.id);
        songs.add(SongModel(
          title: element["title"],
          artist: element["artist"],
          duration: element["duration"],
          releseDate: element["releseDate"],
          songId: element.reference.id,
          isfavourite: isfavourite,
        ));
      }

      return songs;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<SongModel>> getPlaylist() async {
    try {
      List<SongModel> songs = [];
      var data = await FirebaseFirestore.instance.collection("songs").get();

      for (var element in data.docs) {
        bool isfavourite =
            await FavSongsService().isFavSong(element.reference.id);
        songs.add(SongModel(
          title: element["title"],
          artist: element["artist"],
          duration: element["duration"],
          releseDate: element["releseDate"],
          songId: element.reference.id,
          isfavourite: isfavourite,
        ));
      }

      return songs;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<SongModel>> getFavlist() async {
    try {
      List<SongModel> favsongs = [];
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .get();

      for (var element in data.docs) {
        var song = await FirebaseFirestore.instance
            .collection("songs")
            .doc(element["songId"])
            .get();

        favsongs.add(SongModel(
          title: song["title"],
          artist: song["artist"],
          duration: song["duration"],
          releseDate: song["releseDate"],
          songId: song.reference.id,
          isfavourite: true,
        ));
      }

      return favsongs;
    } catch (e) {
      throw e.toString();
    }
  }
}
