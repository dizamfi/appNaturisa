// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    try {
      bool canAuthenticate = await auth.canCheckBiometrics;
      if (!canAuthenticate) return false;

      return await auth.authenticate(
        localizedReason: 'GPS Biometric Sign On',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'GPS Biometric Sign On',
            cancelButton: 'No thanks',
            biometricHint: '',
          ),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint('Error usando biometric: $e');
      return false;
    }
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } catch (e) {
      debugPrint('Error usando biometric: $e');
      return false;
    }
  }
}
