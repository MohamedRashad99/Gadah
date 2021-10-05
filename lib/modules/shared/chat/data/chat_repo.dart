import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:gadha/comman/config/network_constents.dart';

import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:gadha/modules/shared/chat/models/message.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:queen/queen.dart';

import '../enums.dart';

class ChatRepo {
  final OrderEntity order;

  ChatRepo(this.order);
  CollectionReference _currentChatCollection() {
    final _db = FirebaseFirestore.instance;
    final collection =
        _db.collection('chat').doc(order.convId).collection('messages');
    return collection;
  }

  DocumentReference _newMsgDoc() {
    return _currentChatCollection().doc();
  }

  Future<void> sendTextMsg(String content) async {
    final _doc = _newMsgDoc();
    final _msg = ChatMessageEntity(
      id: _doc.id,
      sender: AuthService.currentUser!.id,
      content: content,
      type: MessageType.text,
      createdAt: Timestamp.now(),
    );
    return _doc.set(_msg.toMap());
  }

  Future<String> uploadMediaFile(File file) async {
    final res = await Api.post(kMediaFile,
        body: FormData.fromMap(
            {'image': await MultipartFile.fromFile(file.path)}));
    if (res.statusCode != HttpStatus.created) {
      throw LaravelException.parse(res.data);
    }
    return res.data['path'];
  }

  Future<void> sendImage(File file) async {
    final content = await uploadMediaFile(file);
    final _doc = _newMsgDoc();

    final _msg = ChatMessageEntity(
      id: _doc.id,
      sender: AuthService.currentUser!.id,
      content: content,
      type: MessageType.image,
      createdAt: Timestamp.now(),
    );
    return _doc.set(_msg.toMap());
  }

  Stream<List<ChatMessageEntity>> findConversationMessages(
    OrderEntity order,
  ) {
    final _collection = _currentChatCollection();
    return _collection
        .orderBy('createdAt')
        .snapshots()
        .asyncMap<List<ChatMessageEntity>>(
      (event) async {
        final _messages = event.docs;
        return _messages
            .map(
              (e) =>
                  ChatMessageEntity.fromMap(e.data()! as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }
}
