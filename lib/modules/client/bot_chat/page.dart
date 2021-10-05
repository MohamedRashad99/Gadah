import 'package:flutter/material.dart';

import 'package:gadha/widgets/signle/center_error.dart';
import 'package:gadha/widgets/small_logo.dart';
import 'package:queen/queen.dart';

import 'cubit/actions_cubit.dart';
import 'widgets/bubble.dart';

class BotChatPage extends StatelessWidget {
  const BotChatPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => ActionsCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(onTap: Q.back, child: const Icon(Icons.arrow_back)),
                    const Expanded(child: Center(child: SmallLogo())),
                  ],
                ),
                BlocBuilder<ActionsCubit, ActionsState>(
                  builder: (context, state) {
                    if (state is ActionsLoading) {
                      return const SizedBox();
                    } else if (state is MessagesError) {
                      return CenterError(
                        message: state.message,
                      );
                    } else if (state is MessagesLoaded) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.messages.length,
                          itemBuilder: (_, i) {
                            final msg = state.messages[i];
                            final msgWidget = BotChatBubble(msg);
                            return msgWidget;
                          },
                        ),
                      );
                    }
                    throw state.runtimeType.toString();
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
