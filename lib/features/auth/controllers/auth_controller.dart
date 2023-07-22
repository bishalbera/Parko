import 'package:flutter/material.dart';

import '../models/user.dart';
import '../repositories/auth_repository.dart';

class AuthController {
  AuthRepository _repository = AuthRepository();

  //signup
  void signUp(BuildContext context, UserModel model) {
    _repository.signUp(context, model);
  }

  void logIn(BuildContext context, String email, String pass) {
    _repository.logIn(context, email, pass);
  }
}