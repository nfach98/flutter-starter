import 'package:flutter/material.dart';
import 'package:starter/presentation/router/app_router.dart';
import 'package:starter/presentation/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starter',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppRouter.list,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
