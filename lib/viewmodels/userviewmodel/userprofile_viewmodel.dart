import 'package:flutter/material.dart';
import 'package:spotify/models/user_profile.dart';
import 'package:spotify/services/auth/auth_service.dart';

class UserprofileViewmodel extends ChangeNotifier {
  final _authservice = AuthService();
  bool _isloading = true;
  String? _errormsg;

  bool get isloading => _isloading;
  String? get errormsg => _errormsg;

  UserProfile? _user;
  UserProfile? get user => _user;

  Future<void> getUser() async {
    try {
      _user = await _authservice.getProfile();
      _isloading = false;
    } catch (e) {
      _isloading = false;
      _errormsg = e.toString();
    }
    notifyListeners();
  }
}
