import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/repositories/repos.dart';
import 'package:personal_project/features/home/screens/home_screen.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

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

  Future<User?> createAuth({
    required String email,
    required String name,
    required BuildContext context,
    required String password,
  }) async {
    final res = await _authRepo.signUp(
      email: email,
      name: name,
      password: password,
    );
    var val = res.fold(
      (l) {
        showSnackBar(context, l.message);
        return null;
      },
      (user) => user,
    );
    return val;
  }

  void signIn({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    username = username;
    final res = await _authRepo.signIn(username: username, password: password);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Navigator.pushReplacement(
        context,
        HomePage.route(),
      ),
    );
  }

  Future<User?> currentUser() => _authRepo.currentUser();
}
