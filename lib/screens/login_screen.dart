import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bloc/login/login_bloc.dart';
import 'package:starter/bloc/login/login_event.dart';
import 'package:starter/bloc/login/login_state.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/router/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bloc = getIt<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => bloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final isLogin = state.isLogin;

          if (isLogin) {
            Navigator.pushReplacementNamed(context, AppRouter.list);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.inversePrimary,
            title: const Text('Login'),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final isLoading = state.isLoading;

                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: _buildForm(),
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
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
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
                onPressed: () {
                  bloc.add(Login(
                    username: _usernameController.text,
                  ));
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
