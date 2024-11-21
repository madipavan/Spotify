import 'package:flutter/material.dart';

import '../../models/song_model.dart';
import '../../services/songs/getsongs.dart';

class FavsonglistViewmodel extends ChangeNotifier {
  final _songservice = SongsFirebaseServiceimpl();
  List<SongModel> favsongslist = [];

  bool _isloading = true;
  String? _errormsg;

  bool get isloading => _isloading;
  String? get errormsg => _errormsg;

  Future<void> getFavsongslist() async {
    try {
      favsongslist = await _songservice.getFavlist();
      _isloading = false;
    } catch (e) {
      _isloading = false;
      _errormsg = e.toString();
    }

    notifyListeners();
  }
}
