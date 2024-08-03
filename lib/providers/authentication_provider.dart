import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:gee/models/chat_user.dart';

// Services
import '../services/database_services.dart';
import '../services/navigation_services.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.signOut();

    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        try {
          await _databaseService.updateUserLastSeenTime(user.uid);
          var snapshot = await _databaseService.getUser(user.uid);
          if (snapshot.exists) {
            Map<String, dynamic> userData =
                snapshot.data()! as Map<String, dynamic>;
            this.user = ChatUser.fromJSON({
              "uid": user.uid,
              "name": userData["name"],
              "email": userData["email"],
              "last_active": userData["last_active"],
              "image": userData["image"],
            });
            _navigationService.removeAndNavigateToRoute('/home');
          }
        } catch (e) {
          print("Error fetching user data: $e");
        }
      } else {
        if (_navigationService.getCurrentRoute() != '/login') {
          _navigationService.removeAndNavigateToRoute('/login');
        }
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Error logging user into Firebase: ${e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credentials.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("Error registering user: ${e.message}");
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error: $e");
    }
  }
}
