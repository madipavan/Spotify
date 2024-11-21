import 'package:flutter/foundation.dart';
import 'package:spotify/models/song_model.dart';
import 'package:spotify/services/songs/getsongs.dart';

class SongsList extends ChangeNotifier {
  final _songservice = SongsFirebaseServiceimpl();
  List<SongModel> songslist = [];
  List<SongModel> playlist = [];

  bool _isloading = true;
  String? _errormsg;

  bool? get isloading => _isloading;
  String? get errormsg => _errormsg;

  Future<void> getNewRelesedsongslist() async {
    try {
      songslist = await _songservice.getNewSongs();
      _isloading = false;
    } catch (e) {
      _isloading = false;
      _errormsg = e.toString();
    }
    notifyListeners();
  }

  Future<void> getPlaylist() async {
    try {
      playlist = await _songservice.getPlaylist();
      _isloading = false;
    } catch (e) {
      _isloading = false;
      _errormsg = e.toString();
    }
    notifyListeners();
  }
}
