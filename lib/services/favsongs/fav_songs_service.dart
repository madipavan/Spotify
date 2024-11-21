import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavSongsService {
  Future addOrremoveSongs(String songId) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firsestore = FirebaseFirestore.instance;

      String uid = auth.currentUser!.uid;

      QuerySnapshot favsong = await firsestore
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .where("songId", isEqualTo: songId)
          .get();

      //check whether it is in playlist or not
      if (favsong.docs.isNotEmpty) {
        await favsong.docs.first.reference.delete();
      } else {
        await firsestore
            .collection("users")
            .doc(uid)
            .collection("favorites")
            .add({
          "songId": songId,
          "addedDate": Timestamp.now(),
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> isFavSong(String songId) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firsestore = FirebaseFirestore.instance;

      String uid = auth.currentUser!.uid;

      QuerySnapshot favsong = await firsestore
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .where("songId", isEqualTo: songId)
          .get();

      //check whether it is in playlist or not
      if (favsong.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("isfavsong==$e");
      throw e.toString();
    }
  }
}
