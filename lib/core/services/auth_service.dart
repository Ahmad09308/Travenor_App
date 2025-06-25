import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding User object

// Mock User Model (can be expanded)
class UserModel {
  final String id;
  final String? email;
  final String? name;

  UserModel({required this.id, this.email, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}

class AuthService {
  static const String _userKey = 'currentUser';
  static const String _isLoggedInKey = 'isLoggedIn';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<UserModel?> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation: in a real app, this would call a backend
    if (email.isNotEmpty && password.isNotEmpty) {
      // For mock purposes, any non-empty email/password is valid
      // Let's create a mock user
      final user = UserModel(id: 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}', email: email, name: 'Mock User');

      final prefs = await _prefs;
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userKey, jsonEncode(user.toJson()));

      return user;
    }
    return null; // Sign-in failed
  }

  Future<UserModel?> signUp(String email, String password, String name) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation and user creation
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      final user = UserModel(id: 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}', email: email, name: name);

      final prefs = await _prefs;
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userKey, jsonEncode(user.toJson()));

      return user;
    }
    return null; // Sign-up failed
  }

  Future<void> signOut() async {
    final prefs = await _prefs;
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
    // In a real app, also clear any other session-related data
  }

  Future<bool> isSignedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await _prefs;
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      try {
        return UserModel.fromJson(jsonDecode(userJson));
      } catch (e) {
        // Handle potential parsing errors, e.g., by signing out
        await signOut();
        return null;
      }
    }
    return null;
  }

  // Mock password reset - in a real app, this would trigger an email or similar
  Future<bool> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && email.contains('@')) {
      // Simulate success
      print('Password reset link sent to $email (mock)');
      return true;
    }
    return false;
  }
}
