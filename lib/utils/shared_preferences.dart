import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SharedPreferences {
  final platform = const MethodChannel('shared_pref');

  Future<void> setString(String key, String value) async {
    try {
      await platform.invokeMethod(
        'putString',
        {'key': key, 'value': value},
      );
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
    }
  }

  Future<String?> getString(String key) async {
    try {
      final result = await platform.invokeMethod('getString', {'key': key});
      return result as String?;
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
    }

    return null;
  }

  Future<void> remove(String key) async {
    try {
      await platform.invokeMethod('remove', {'key': key});
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
    }
  }

  void clear() {
    // Code to clear all preferences
  }
}
