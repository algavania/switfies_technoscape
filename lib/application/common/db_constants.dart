import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbConstants {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static String users = 'users';
  static String children = 'children';

  static String parentRole = 'parent';
  static String childRole = 'admin';

  static String defaultPhotoProfileUrl = 'https://firebasestorage.googleapis.com/v0/b/lare-jatim.appspot.com/o/profile.png?alt=media&token=def1b9fc-2b7e-4d9d-9faa-40317ee4a1b9';
}