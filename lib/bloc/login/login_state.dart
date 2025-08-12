class LoginState {
  final bool isLoading;
  final bool isLogin;
  final String? errorMessage;

  const LoginState({
    required this.isLoading,
    this.isLogin = false,
    this.errorMessage,
  });

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      errorMessage: null,
    );
  }

  LoginState copyWith({
    bool? isLoading,
    bool? isLogin,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLogin: isLogin ?? this.isLogin,
      errorMessage: errorMessage,
    );
  }
}
