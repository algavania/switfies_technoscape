import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/user/user_model.dart';

abstract class BaseAuthRepository {
  Future<void> register({required String email, required String password, required UserModel userModel});
  Future<UserCredential> login({required String email, required String password, bool isReauthenticate = false});
  Future<void> changePassword({required String oldPassword, required String newPassword});
  Future<void> changeEmail({required String password, required String newEmail});
  Future<void> forgotPassword({required String email});
  Future<void> logout();
}
