import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:hackniche/secrets/secrets.dart';

class AuthServices {
  Future<void> signInWithGithub(BuildContext context) async {
    try {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: Secrets.clientID,
        clientSecret: Secrets.clientSecret,
        redirectUrl: Secrets.redirectUrl,
      );
      var result = await gitHubSignIn.signIn(context);
      switch (result.status) {
        case GitHubSignInResultStatus.ok:
          // Handle successful sign-in
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign in successful')),
          );
          break;
        case GitHubSignInResultStatus.cancelled:
          // Handle sign-in cancellation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign in cancelled')),
          );
          break;
        case GitHubSignInResultStatus.failed:
          // Handle sign-in failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign in failed: ${result.errorMessage}')),
          );
          break;
      }
    } catch (e) {
      // Handle other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
