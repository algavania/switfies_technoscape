import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbConstants {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static String users = 'users';
  static String ratings = 'ratings';
  static String posts = 'posts';
  static String thumbnails = 'thumbnails';
  static String replies = 'replies';
  static String subReplies = 'subReplies';
  static String contacts = 'contacts';
  static String chats = 'chats';
  static String chatRooms = 'chatRooms';
  static String reports = 'reports';
  static String replyTemplates = 'replyTemplates';
  static String bannedWords = 'bannedWords';

  static String userRole = 'user';
  static String adminRole = 'admin';

  static String defaultPhotoProfileUrl = 'https://firebasestorage.googleapis.com/v0/b/lare-jatim.appspot.com/o/profile.png?alt=media&token=def1b9fc-2b7e-4d9d-9faa-40317ee4a1b9';
}