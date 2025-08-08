import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
