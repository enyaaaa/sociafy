import 'package:flutter/widgets.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  final AuthService authService = AuthService();

  UserModel get getUser => userModel!;

  Future<void> refreshUser() async {
    UserModel user = await authService.getUserDetails();
    userModel = user;
    notifyListeners();
  }
}