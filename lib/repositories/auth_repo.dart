import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/core/core.dart';

abstract class IAuthRepo {
  FutureEither<Session> signIn({
    required String username,
    required String password,
  });


  Future<User?> currentUser();
  // FutureEither<User> signUp({
  //   required String username,
  //   required String password,
  // });
}

final authRepoProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthRepo(account: account);
});

class AuthRepo implements IAuthRepo {
  final Account _account;
  AuthRepo({required Account account}) : _account = account;

  @override
  FutureEither<Session> signIn({
    required String username,
    required String password,
  }) async {

    try {
      final user = await _account.createEmailSession(
          email: username, password: password);
      return right(user);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  Future<User?> currentUser() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  // @override
  // FutureEither<User> signUp({required String username, required String password}) {

  // }
}
