import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/router/app_router.gr.dart';
import 'package:starter/utils/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var username = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUsername();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 52,
              child: Icon(
                Icons.person,
                size: 52,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadUsername() async {
    final prefs = getIt<SharedPreferences>();
    final username = await prefs.getString('username') ?? '';
    setState(() => this.username = username);
  }

  _logout() async {
    getIt<SharedPreferences>().remove('username');
    context.replaceRoute(const LoginRoute());
  }
}
