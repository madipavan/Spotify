import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SongPlayerProvider extends ChangeNotifier {
  AudioPlayer audioplayer = AudioPlayer();

  Duration songduration = Duration.zero;
  Duration songposition = Duration.zero;

  bool _isloading = true;
  bool _isplaying = false;

  bool get isPlaying => _isplaying;

  String? _errormsg;
  bool? get isloading => _isloading;
  String? get errormsg => _errormsg;

  int index = 0;

  Future<void> songloading(String url) async {
    //songpositions and duration

    //session
    await musicSession();
    //session

    try {
      await audioplayer.setSource(UrlSource(url));

      _isloading = false;
    } on SocketException {
      _errormsg = 'Network error: Could not connect to the server';
    } on TimeoutException {
      _errormsg = 'Connection timed out';
    } catch (e) {
      _errormsg = e.toString();

      _isloading = false;
    }
    notifyListeners();
  }

  //play or pause
  Future songplayorpause() async {
    if (_isplaying) {
      await audioplayer.pause();

      _isplaying = false;
      notifyListeners();
    } else {
      await audioplayer.resume();
      _isplaying = true;
      notifyListeners();
    }
  }

  //for closing

  Future<void> close() async {
    audioplayer.dispose();

    return super.dispose();
  }

  void setCurrentIndex(int currentIndex) {
    index = currentIndex;
  }

  void setForwardIndex(int length) {
    index == length - 1 ? index = 0 : index++;
    notifyListeners();
  }

  void setBackwardIndex(int length) {
    index == 0 ? index = length - 1 : index--;

    notifyListeners();
  }

  Future musicSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    session.becomingNoisyEventStream.listen((_) {
      audioplayer.pause();

      _isplaying = false;
    });

    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        audioplayer.pause();
        _isplaying = false;
      } else {
        audioplayer.resume();
        _isplaying = true;
      }
    });
  }

  Future seekmusic() async {
    audioplayer.onDurationChanged.listen((Duration duration) {
      songduration = duration;
    });
    audioplayer.onPositionChanged.listen((Duration position) {
      songposition = position;
    });
    Future.delayed(const Duration(seconds: 1));
  }
}
