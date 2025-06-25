import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travenor_app/core/services/auth_service.dart'; // Your AuthService

part 'auth_event.dart';
part 'auth_state.dart';

import 'package:travenor_app/core/services/notification_service.dart'; // Import NotificationService

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final NotificationService _notificationService; // Add NotificationService

  AuthBloc({required AuthService authService, required NotificationService notificationService})
      : _authService = authService,
        _notificationService = notificationService, // Initialize NotificationService
        super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isSignedIn = await _authService.isSignedIn();
      if (isSignedIn) {
        final user = await _authService.getCurrentUser();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          // User was marked signed in, but user data is missing/corrupt
          await _authService.signOut(); // Clean up
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: "Error checking auth status: ${e.toString()}"));
      // Optionally, fall back to unauthenticated state
      // emit(AuthUnauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) {
    emit(AuthAuthenticated(user: event.user));
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(message: "Error signing out: ${e.toString()}"));
      // Optionally, keep the user authenticated if sign out fails critically
      // For a mock service, this is less likely to be an issue.
    }
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signIn(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthFailure(message: "Sign-in failed. Please check your credentials."));
        // Ensure we transition back to unauthenticated if it was a failure from initial or other states
        await Future.delayed(const Duration(milliseconds: 100)); // Brief delay to allow UI to show loading
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: "Error during sign-in: ${e.toString()}"));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUp(event.email, event.password, event.name);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
        // Show welcome notification
        _notificationService.showWelcomeNotification(user.name ?? 'User');
      } else {
        emit(const AuthFailure(message: "Sign-up failed. Please try again."));
        await Future.delayed(const Duration(milliseconds: 100));
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: "Error during sign-up: ${e.toString()}"));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Or a more specific state like PasswordResetInProgress
    try {
      final success = await _authService.forgotPassword(event.email);
      if (success) {
        // Optionally, emit a state like PasswordResetEmailSent
        // For now, just return to unauthenticated as no immediate login happens
        emit(AuthUnauthenticated());
        // Consider emitting a temporary success message state if UI needs to show it
      } else {
        emit(const AuthFailure(message: "Password reset request failed."));
        await Future.delayed(const Duration(milliseconds: 100));
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: "Error during password reset: ${e.toString()}"));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(AuthUnauthenticated());
    }
  }
}
