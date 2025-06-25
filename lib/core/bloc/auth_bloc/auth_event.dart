part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Event to check current auth status when app starts
class AppStarted extends AuthEvent {}

// Event when user successfully logs in
class LoggedIn extends AuthEvent {
  final UserModel user;

  const LoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

// Event when user logs out
class LoggedOut extends AuthEvent {}

// Event to request sign-in
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Event to request sign-up
class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpRequested({required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}

// Event to request password reset
class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}
