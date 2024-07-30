import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum MessageType {
  TEXT,
  IMAGE,
  UNKNOWN,
}

class ChatMessage {
  final String senderID;
  final MessageType type;
  final String content;
  final DateTime sentTime;

  ChatMessage({
    required this.content,
    required this.senderID,
    required this.sentTime,
    required this.type,
  });

  factory ChatMessage.fromJSON(Map<String, dynamic> _json) {
    MessageType _messageType;
    switch (_json["type"]) {
      case "text":
        _messageType = MessageType.TEXT;
        break;
      case "image":
        _messageType = MessageType.IMAGE;
        break;
      default:
        _messageType = MessageType.UNKNOWN;
    }
    // Other logic for creating ChatMessage from JSON goes here
    return ChatMessage(
      content: _json["content"],
      senderID: _json["senderID"],
      sentTime: _json["send_time"].toDate(),
      type: _messageType,
    );
  }
  Map<String, dynamic> toJson() {
    String _messageType;
    switch (type) {
      case MessageType.TEXT:
        _messageType = "text";
        break;
      case MessageType.IMAGE:
        _messageType = "images";
        break;
      default:
        _messageType = "";
    }
    return {
      "content": content,
      "type": _messageType,
      "sender_id": senderID,
      "sent_time": Timestamp.fromDate(sentTime),
    };
  }
}
