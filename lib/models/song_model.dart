import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releseDate;
  final bool isfavourite;
  final String songId;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.isfavourite,
      required this.songId,
      required this.releseDate});
}
