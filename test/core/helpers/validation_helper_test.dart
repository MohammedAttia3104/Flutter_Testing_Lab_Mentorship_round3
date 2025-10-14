import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/core/helpers/validation_helper.dart';

void main() {
  group("Test Name Validation", () {
    test("Invalid Names", () {
      expect(ValidationHelper.validateName(''), 'Please enter your full name');
      expect(
        ValidationHelper.validateName('A'),
        'Name must be at least 2 characters',
      );
    });

    test("Valid Name", () {
      expect(ValidationHelper.validateName('Mohamed Attia'), null);
    });
  });

  group("Test Email Validation", () {
    test("Invalid State", () {
      /// AAA (Arrange–Act–Assert)

      expect(ValidationHelper.validateEmail(''), 'Please enter your email');

      expect(
        ValidationHelper.validateEmail('@b'),
        'Please enter a valid email',
      );

      expect(
        ValidationHelper.validateEmail('invalidemail.com'),
        'Please enter a valid email',
      );
    });

    test("Valid State", () {
      const validEmail = "attia3104@gmail.com";

      final result = ValidationHelper.validateEmail(validEmail);

      expect(result, null);
    });
  });

  group("Test Password Validation", () {
    test("Invalid Password", () {
      expect(ValidationHelper.validatePassword(''), 'Please enter a password');

      expect(ValidationHelper.validatePassword('abc'), 'Password is too weak');
    });

    test("Valid Password", () {
      const validPassword = "StrongP@ssw0rd";
      final result = ValidationHelper.validatePassword(validPassword);
      expect(result, null);
    });
  });

  group('Confirm Password Validation', () {
    test('returns error when confirm password is empty', () {
      final result = ValidationHelper.validateConfirmPassword(
        '',
        passwordController: TextEditingController(text: '123456'),
      );
      expect(result, 'Please confirm your password');
    });

    test('returns error when passwords do not match', () {
      final result = ValidationHelper.validateConfirmPassword(
        '123456',
        passwordController: TextEditingController(text: '654321'),
      );
      expect(result, 'Passwords do not match');
    });

    test('returns null when passwords match', () {
      final result = ValidationHelper.validateConfirmPassword(
        'StrongP@ssw0rd',
        passwordController: TextEditingController(text: 'StrongP@ssw0rd'),
      );
      expect(result, null);
    });
  });
}
