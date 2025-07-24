part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent{
  final String name;
  final String email;
  final String password;

  AuthSignUp({
   required this.name,
   required this.email,
   required this.password
  });
}

// Login with Email Password event taking email and password from login_page.dart

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({
    required this.email,
    required this.password});

}

final class AuthIsUserLoggedIn extends AuthEvent{}
