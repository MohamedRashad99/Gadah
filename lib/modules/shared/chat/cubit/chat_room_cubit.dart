import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/helpers/file_picker.dart';
import 'package:gadha/modules/shared/chat/data/chat_repo.dart';
import 'package:gadha/modules/shared/chat/models/message.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'chat_room_state.dart';

class ChatWithDriverCubit extends Cubit<ChatWithDriverState> {
  ChatWithDriverCubit(this.order)
      : _chatService = ChatRepo(order),
        super(ChatRoomLoading()) {
    final stream = _chatService.findConversationMessages(order);
    _sub = stream.listen((messages) async {
      emit(
        messages.isEmpty ? ChatRoomEmpty() : ChatRoomLoaded(messages),
      );
      try {
        controller.animateTo(
          controller.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      } catch (e) {
        if (e.runtimeType.toString() == '_AssertionError') {
          // After 1 second, it takes you to the bottom of the ListView
          await Future.delayed(const Duration(seconds: 1));
          controller.jumpTo(controller.position.maxScrollExtent);
        }
      }
    })
      ..onError((err) {
        emit(ChatRoomError(err.toString()));
      });
  }
  factory ChatWithDriverCubit.of(BuildContext context) =>
      BlocProvider.of<ChatWithDriverCubit>(context);

  @override
  Future<void> close() async {
    _sub?.cancel();
    return super.close();
  }

  final OrderEntity order;
  final ChatRepo _chatService;
  final controller = ScrollController();
  StreamSubscription<List<ChatMessageEntity>>? _sub;

  Future<void> sendImage() async {
    try {
      final _images = await FilePicker().pickMultiImage();
      if (_images.isEmpty) return;
      await ChatRepo(order).sendImage(_images.first);
    } catch (e) {
      log(e.toString());
      Q.alertWithErr(e);
    }
  }
}
