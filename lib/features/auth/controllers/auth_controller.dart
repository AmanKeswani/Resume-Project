import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/features/auth/home/screens/home_screen.dart';
import 'package:personal_project/repositories/auth_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.currentUser();
});

class AuthController {
  final AuthRepo _authRepo;

  const AuthController({
    required AuthRepo authRepo,
  }) : _authRepo = authRepo;

  void signIn({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    username = "$username@example.com";
    final res = await _authRepo.signIn(username: username, password: password);
    print('reached');
    res.fold(
      (l) {
        print("reached 2");
        print(l.message);
      },
      (r) => Navigator.push(context, HomePage.route()),
    );
  }

  Future<User?> currentUser() => _authRepo.currentUser();
}
