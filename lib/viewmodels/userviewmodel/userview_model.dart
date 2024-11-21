import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify/models/user_model.dart';
import 'package:spotify/services/auth/auth_service.dart';

class UserviewModel extends ChangeNotifier {
  final _authservice = AuthService();

  bool _isloading = false;
  String? _errormsgsignin;
  String? _errormsgsignup;

  bool get isloading => _isloading;
  String? get errormsgsignin => _errormsgsignin;
  String? get errormsgsignup => _errormsgsignup;

  UserModel? _user;
  UserModel? get user => _user;

  Future<void> signup(email, password, name) async {
    _isloading = true;
    try {
      _user = await _authservice.signupWithEmail(email, password, name);
      _isloading = false;
    } on FirebaseAuthException catch (e) {
      _errormsgsignup = e.toString();
      _isloading = false;
    } catch (e) {
      _errormsgsignup = e.toString();
      _isloading = false;
    }
    notifyListeners();
  }

  Future<void> signin(email, password) async {
    _isloading = true;
    try {
      _user = await _authservice.signinWithEmail(email, password);
      _isloading = false;
    } catch (e) {
      _errormsgsignin = e.toString();
      _isloading = false;
    }

    notifyListeners();
  }
}
