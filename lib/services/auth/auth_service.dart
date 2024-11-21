import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/models/user_model.dart';
import 'package:spotify/models/user_profile.dart';
import 'package:spotify/utils/constant/app_url.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign up
  Future<UserModel?> signupWithEmail(email, password, name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'email': user.email,
          'name': name, // Storing the user's name
          'createdAt': DateTime.now(),
        });
      }
      return UserModel(email: user!.email, uid: user.uid);
    } on FirebaseAuthException catch (e) {
      //for firebase
      throw e.message!;
    } catch (e) {
      throw 'An error occurred';
    }
  }

  Future<UserModel?> signinWithEmail(email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;

      return UserModel(email: user!.email, uid: user.uid);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = e.message!;
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserProfile?> getProfile() async {
    try {
      var userUid = _auth.currentUser?.uid;

      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(userUid)
          .get();

      String? imgurl = _auth.currentUser?.photoURL ?? AppUrl.defaultImage;

      return UserProfile(
          email: data["email"], name: data["name"], imageurl: imgurl);
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
