import 'dart:async';
//package
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//services
import '../services/database_services.dart';
//provider
import '../providers/authentication_provider.dart';
// models
import '../models/chat.dart';
import '../models/chat_message.dart';
import '../models/chat_user.dart';

class ChatsPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;

  late DatabaseService _db;
  List<Chat>? chats;

  late StreamSubscription _chatsStream;

  ChatsPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }
  @override
  void dispose() {
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {}
}
