import 'package:flutter/material.dart';
import 'app_regex.dart';

class ValidationHelper {
  ValidationHelper._();

  static bool isValidEmail(String email) => AppRegex.isEmailValid(email);

  static bool isValidPassword(String password) {
    return AppRegex.hasMinLength(password) &&
        AppRegex.hasLowerCase(password) &&
        AppRegex.hasUpperCase(password) &&
        AppRegex.hasNumber(password) &&
        AppRegex.hasSpecialCharacter(password);
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (!isValidPassword(value)) {
      return 'Password is too weak';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, {
        required TextEditingController passwordController,
      }) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
