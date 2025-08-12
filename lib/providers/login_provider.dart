import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/utils/shared_preferences.dart';

@injectable
class LoginProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LoginProvider({required this.sharedPreferences});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(String username) async {
    _isLoading = true;
    notifyListeners();

    await sharedPreferences.setString('username', username);

    _isLoading = false;
    notifyListeners();
  }
}
