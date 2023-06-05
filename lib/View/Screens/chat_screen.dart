import 'package:badges/badges.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:talk_app/Controller/chat_controller.dart';
import 'package:talk_app/Model/Models/message.dart';
import 'package:talk_app/View/Widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Screen'),
        ),
        body: Column(
          children: [
            Text('from:${controller.email}'),
            TextField(
              decoration: const InputDecoration(hintText: 'to'),
              controller: controller.controller,
            ),
            Obx(() => Expanded(
                  child: StickyGroupedListView<Message, DateTime>(
                    groupBy: (message) => DateTime(message.date.year,
                        message.date.month, message.date.day),
                    groupSeparatorBuilder: (message) => DateChip(
                      date: message.date,
                      color: const Color.fromARGB(190, 0, 170, 255),
                    ),
                    floatingHeader: true,
                    itemScrollController: controller.scrollController,
                    // ignore: invalid_use_of_protected_member
                    elements: controller.messages.value,
                    itemPositionsListener: controller.itemPositionsListener,
                    itemBuilder: (context, message) {
                      return ChatBubble(
                        message: message,
                        fromMe: message.from == controller.email,
                      );
                      // return BubbleNormal(
                      //   text: message.text,
                      //   color: message.from == controller.email
                      //       ? Colors.blue
                      //       : Colors.grey.shade400,
                      //   tail: true,
                      //   textStyle: TextStyle(
                      //     color: message.from == controller.email
                      //         ? Colors.white
                      //         : null,
                      //   ),
                      //   seen: message.from == controller.email &&
                      //       message.type == MessageState.read,
                      //   isSender: message.from == controller.email,
                      // );
                    },
                  ),
                )),
            MessageBar(
              onSend: controller.send,
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Obx(
            () => AnimatedOpacity(
              opacity: controller.show.value ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                  scale: controller.show.value ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: SizedBox(
                      width: 30,
                      child: Badge(
                        showBadge: controller.newMessages > 0,
                        position: BadgePosition.topEnd(top: 4, end: -6),
                        badgeContent: Text(
                          '${controller.newMessages.value}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: FloatingActionButton(
                          onPressed: controller.animateToLast,
                          foregroundColor: Colors.blueAccent,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.arrow_downward_rounded),
                        ),
                      ))),
            ),
          ),
        ),
      );
    });
  }
}
