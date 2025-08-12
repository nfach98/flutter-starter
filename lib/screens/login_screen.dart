import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/riverpod/login_notifier.dart';
import 'package:starter/router/app_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(loginNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: state.when(
          data: (_) => _LoginForm(),
          loading: () => Stack(
            children: [
              Positioned.fill(child: _LoginForm()),
              const Positioned.fill(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
          error: (_, __) => _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  _LoginForm();

  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
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
                    FocusScope.of(context).unfocus();
                    await ref.read(loginNotifierProvider.notifier).login(
                          _usernameController.text.trim(),
                        );
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, AppRouter.list);
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
