import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:hackniche/secrets/secrets.dart';

class AuthServices {
  Future<void> signInWithGithub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: Secrets.clientID,
        clientSecret: Secrets.clientSecret,
        redirectUrl: Secrets.redirectUrl);
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.token!)));
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.errorMessage)));
        break;
    }
  }
}
