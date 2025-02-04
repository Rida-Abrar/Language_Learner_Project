import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userEmail;

  // Getter to access userEmail
  String? get userEmail => _userEmail;

  // Setter to update userEmail and notify listeners
  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();  // Notify listeners when the user email is updated
  }
}
