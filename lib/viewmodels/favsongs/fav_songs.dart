import 'package:flutter/material.dart';
import 'package:spotify/services/favsongs/fav_songs_service.dart';

class FavSongsProvider extends ChangeNotifier {
  String? _errormsg;

  String? get errormsg => _errormsg;
  Future addOrremovefavSongs(String songId) async {
    try {
      await FavSongsService().addOrremoveSongs(songId);
    } catch (e) {
      _errormsg = e.toString();
    }
    notifyListeners();
  }
}
