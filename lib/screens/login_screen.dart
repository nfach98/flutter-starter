import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/router/app_router.dart';
import 'package:starter/utils/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your username';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: FilledButton(
                          onPressed: _login,
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await getIt<SharedPreferences>().setString(
        'username',
        _usernameController.text,
      );
      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRouter.list);
      }
    }
  }
}
