abstract class LoginEvent {}

class Login extends LoginEvent {
  final String username;

  Login({required this.username});
}
