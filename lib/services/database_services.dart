import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = "Users";
const String CHAT_COLLECTION = "Chats";
const String MESSAGES_COLLECTION = "Messages";

class DatabaseServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseServices();

  Future<void> createUser(
      String uid, String email, String name, String imageURL) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).set({
        "email": email,
        "image": imageURL,
        "last_active": DateTime.now().toUtc(),
        "name": name,
      });
    } catch (e) {
      print("Error creating user: $e");
    }
  }

  Future<void> updateUserLastSeenTime(String uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).update({
        "last_active": DateTime.now().toUtc(),
      });
    } catch (e) {
      print("Error updating user last seen time: $e");
    }
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    try {
      return await _db.collection(USER_COLLECTION).doc(uid).get();
    } catch (e) {
      print("Error getting user: $e");
      rethrow;
    }
  }
}
