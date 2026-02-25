// ignore_for_file: unchecked_use_of_nullable_value, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysterybag/core/services/firebase_auth_services.dart';

import '../../../../../generated/l10n.dart';

class ProfileViewLogout {
  static Future<bool> showLogoutDialog(BuildContext context) async {
    final shouldLogout =
        await showDialog<bool>(
          animationStyle: const AnimationStyle(
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.easeIn,
            duration: Duration(milliseconds: 250),
          ),
          context: context,
          builder: (context) => _buildLogoutDialog(context),
        ) ??
        false;

    if (shouldLogout) {
      return await _performLogout(context);
    }
    return false;
  }

  static Widget _buildLogoutDialog(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context)!.profileViewLogout),
      content: Text(S.of(context)!.profileViewLogoutText),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(S.of(context)!.profileViewLogoutText3),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(S.of(context)!.profileViewLogoutText2),
        ),
      ],
    );
  }

  static Future<bool> _performLogout(BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;
      final currentUser = auth.currentUser;

      // First sign out the user
      if (currentUser != null) {
        await auth.signOut();
      }

      // Then delete the user account if needed
      final isLoggedIn = FirebaseAuthServices().isUserLoggedIn();
      if (isLoggedIn) {
        await FirebaseAuthServices().deleteUser();
      }

      // Clear any local storage or state if needed
      // For example: await YourLocalStorage().clearUserData();

      if (context.mounted) {
        // Navigate to sign-in page and remove all previous routes
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        return true;
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred during logout')),
        );
      }
      return false;
    }
  }
}
