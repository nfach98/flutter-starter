import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/providers/login_provider.dart';
import 'package:starter/router/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => getIt<LoginProvider>(),
      builder: (_, __) => Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: const Text('Login'),
        ),
        body: _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm();

  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<LoginProvider>(
      builder: (_, provider, __) {
        final isLoading = provider.isLoading;

        return Stack(
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
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await context.read<LoginProvider>().login(
                                    _usernameController.text,
                                  );
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRouter.list,
                                );
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
