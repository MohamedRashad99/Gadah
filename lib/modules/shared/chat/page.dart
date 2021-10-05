import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/enums.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/modules/shared/chat/order_options.dart';
import 'package:gadha/widgets/items/chat_bubble_new.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

import 'cubit/chat_room_cubit.dart';
import 'data/chat_repo.dart';
import 'models/message.dart';

class ChatPage extends StatefulWidget {
  final OrderEntity order;
  const ChatPage(this.order, {Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textEditingController = TextEditingController();
  late final cubit = ChatWithDriverCubit(widget.order);

  Future<void> _sendTextMsg() async {
    final _msg = _textEditingController.text.trim();
    if (_msg.isEmpty) return;
    try {
      await ChatRepo(widget.order).sendTextMsg(_msg);
      _textEditingController.clear();
    } catch (e) {
      Q.alertWithErr(e);
    }
  }

  Future<void> _attachMedia(Attachment attachment) async {
    switch (attachment) {
      case Attachment.image:
        return cubit.sendImage();
      case Attachment.voiceNote:
        // Q.dialog(AudioSender(order.driver!));
        break;
    }
  }

  Widget _buildInputTextField() {
    final borderRadius = BorderRadius.circular(40);
    return Material(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: Container(
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: borderRadius),
        child: Theme(
          data: ThemeData(
            primaryColor: AppColors.lightBlack,
            primaryColorDark: AppColors.lightBlueAccent,
            backgroundColor: Colors.white,
          ),
          child: TextField(
            controller: _textEditingController,
            autocorrect: false,
            cursorColor: AppColors.darkGreen,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            minLines: 1,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              prefixIcon: IconButton(
                onPressed: _sendTextMsg,
                icon: const Icon(FontAwesomeIcons.paperPlane,
                    size: 18, color: AppColors.lightBlue),
              ),
              focusColor: AppColors.transparent,
              border: OutlineInputBorder(borderRadius: borderRadius),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return StanderedAppBar(
      appBarType: AppBarType.navigator,
      centerChild: ShowMoreText(
        widget.order.driver!.name,
        maxLength: 33,
        showMoreText: '',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailingActions: [
        IconButton(
          onPressed: () => _attachMedia(Attachment.image),
          iconSize: 18,
          icon: const Icon(FontAwesomeIcons.paperclip, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (_) => cubit,
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: const StanderedAppBar(),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  _buildAppBar(),
                  ChatPopupOrderOptions(widget.order),
                  Expanded(
                    child:
                        BlocBuilder<ChatWithDriverCubit, ChatWithDriverState>(
                      builder: (_, state) {
                        if (state is ChatRoomLoading) {
                          return const CenterLoading();
                        } else if (state is ChatRoomEmpty) {
                          return CenterError(
                              icon: Icons.chat,
                              message: 'no_chat_write_your_first_message'.tr);
                        } else if (state is ChatRoomError) {
                          return CenterError.err(state.message);
                        } else if (state is ChatRoomLoaded) {
                          return buildBody(state.messages, context);
                        }

                        throw UnimplementedError();
                      },
                    ),
                  ),
                  Container(
                    width: width,
                    color: AppColors.darkWhite,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .03, vertical: height * .01),
                    child: Center(
                      child: _buildInputTextField(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(
    List<ChatMessageEntity> messages,
    BuildContext context, {
    bool isLoadingMore = false,
  }) {
    return ListView.builder(
      controller: cubit.controller,
      itemCount: messages.length,
      itemBuilder: (_, index) {
        final item = messages[index];
        return GadhaChatBubble(item);
      },
    );
  }
}
