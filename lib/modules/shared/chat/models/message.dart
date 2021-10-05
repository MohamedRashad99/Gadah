import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:gadha/comman/services/auth_service.dart';
import 'package:queen/queen.dart';

import '../enums.dart';

MessageType _messageTypefromString(String type) {
  if (type == 'text') return MessageType.text;
  if (type == 'image') return MessageType.image;

  throw UnsupportedError('unknown message type => $type');
}

class ChatMessageEntity extends Equatable {
  final String id;
  final int sender;
  final String content;
  final MessageType type;
  final Timestamp createdAt;
  const ChatMessageEntity({
    required this.id,
    required this.sender,
    required this.content,
    required this.type,
    required this.createdAt,
  });

  bool get isFromCurrentUser => sender == AuthService.currentUser!.id;

  ChatMessageEntity copyWith({
    String? id,
    int? sender,
    String? content,
    MessageType? type,
    Timestamp? createdAt,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'content': content,
      'type': type == MessageType.text ? 'text' : 'image',
      'createdAt': createdAt,
    };
  }

  factory ChatMessageEntity.fromMap(Map<String, dynamic> map) {
    return ChatMessageEntity(
      id: map['id'],
      sender: map['sender'],
      content: map['content'],
      type: _messageTypefromString(map['type']),
      createdAt: map['createdAt'],
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      sender,
      content,
      type,
      createdAt,
    ];
  }
}
