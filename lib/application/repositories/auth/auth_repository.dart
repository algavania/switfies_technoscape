import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/user/user_model.dart';
import '../../common/db_constants.dart';
import '../user/user_repository.dart';
import 'base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {

  String _handleAuthErrorCodes(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email sudah dipakai";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Password salah";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "User tidak ditemukan";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User tidak tersedia";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Terlalu banyak percobaan yang dilakukan, coba lagi nanti";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Terjadi kesalahan, coba lagi nanti";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email tidak valid";
      default:
        return "Login gagal. Silakan coba lagi";
    }
  }

  @override
  Future<void> register({required String email, required String password, required UserModel userModel}) async {
    bool isUsernameExist = await UserRepository().checkIfUsernameExist(userModel.username);
    if (isUsernameExist) throw 'Username sudah dipakai';
    try {
      UserCredential credential = await DbConstants.auth.createUserWithEmailAndPassword(email: email, password: password);
      await UserRepository().addOrUpdateUser(credential.user!.uid, userModel);
      await DbConstants.auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthErrorCodes(e.code);
    }
  }

  @override
  Future<UserCredential> login({required String email, required String password, bool isReauthenticate = false}) async {
    try {
      UserCredential credential = await DbConstants.auth.signInWithEmailAndPassword(email: email, password: password);
      if (!isReauthenticate) {
        await UserRepository().setCurrentUserInfo();
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthErrorCodes(e.code);
    }
  }

  @override
  Future<void> logout() async {
    await DbConstants.auth.signOut();
  }

  @override
  Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    await login(email: DbConstants.auth.currentUser?.email ?? '', password: oldPassword);
    await DbConstants.auth.currentUser?.updatePassword(newPassword);
  }

  @override
  Future<void> changeEmail({required String password, required String newEmail}) async {
    await login(email: DbConstants.auth.currentUser?.email ?? '', password: password);
    await DbConstants.auth.currentUser?.updateEmail(newEmail);
    await DbConstants.db.collection(DbConstants.users).doc(DbConstants.auth.currentUser!.uid).update({
      'email': newEmail
    });
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await DbConstants.auth.sendPasswordResetEmail(email: email);
  }
}