import 'package:doc_talk/models/otp_verification.dart';

class AuthProvider {
  User? usermodel;

  User? get user => usermodel;
  set user(User? value) {
    usermodel = value;
  }
}
