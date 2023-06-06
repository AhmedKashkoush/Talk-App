import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:talk_app/Core/Constants/links.dart';
import 'package:talk_app/Core/Utils/Message/message_state.dart';
import 'package:talk_app/Core/Utils/Message/message_types.dart';
import 'package:talk_app/Core/Utils/Socket/socket_init.dart';
import 'package:talk_app/Model/Models/message.dart';

class ChatController extends GetxController {
  late SocketInit si;
  final RxList<Message> messages = <Message>[].obs;
  final String email = Get.arguments['email'];
  final String to = Get.arguments['to'];
  RxBool isOnline = false.obs;
  RxBool isTyping = false.obs;

  // final TextEditingController controller = TextEditingController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final GroupedItemScrollController scrollController =
      GroupedItemScrollController();

  final RxInt _newMessages = 0.obs;
  RxInt get newMessages => _newMessages;

  final RxBool _show = false.obs;
  RxBool get show => _show;

  Timer? timer;

  @override
  void onReady() {
    scrollController.jumpTo(index: messages.indexOf(messages.last));
    super.onReady();
  }

  @override
  void onInit() {
    _initConnection();
    final list = List.generate(
        20,
        (index) => Message(
              id: '',
              chatId: '',
              from: email,
              to: '',
              text:
                  'LOoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong text',
              type: MessageType.text,
              date: DateTime(2023, 2, 9),
              state: MessageState.read,
            ));
    messages.addAll(list);
    itemPositionsListener.itemPositions.addListener(_showArrow);
    super.onInit();
  }

  @override
  void onClose() {
    // controller.dispose();
    si.socket?.emit('offline', {'email': email});
    if (timer != null) {
      timer?.cancel();
    }
    si.disconnect();
    super.onClose();
  }

  void _showArrow() {
    if (itemPositionsListener.itemPositions.value.last.index ~/ 2 <
        messages.indexOf(messages.last)) {
      _show.value = true;
    } else {
      _show.value = false;
      _newMessages.value = 0;
    }
  }

  void _initConnection() {
    si = SocketInit(Links.base);
    si.connect();
    si.socket?.emit('connected', {'email': email});
    si.socket?.emit('online', {'email': email});
    si.socket?.on('online', (data) {
      if (data['email'] == to) {
        isOnline.value = true;
      }
    });
    si.socket?.on('offline', (data) {
      if (data['email'] == to) {
        isOnline.value = false;
      }
    });
    si.socket?.on('typing', (data) {
      if (data['to'] == email) {
        isTyping.value = true;
      }
    });
    si.socket?.on('stop-typing', (data) {
      if (data['to'] == email) {
        isTyping.value = false;
      }
    });
    si.socket?.on('message', (data) {
      final Message message = Message(
        id: '',
        chatId: '',
        from: data['from'],
        to: data['to'],
        text: data['text'],
        type: MessageType.text,
        date: DateTime.parse(data['createdAt']),
        state: MessageState.read,
      );
      messages.add(message);
      if (_show.value) {
        _newMessages.value++;
        return;
      }
      animateToLast();
    });
  }

  void animateToLast() {
    scrollController.scrollTo(
      index: messages.indexOf(messages.last),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void send(String text) {
    final Message message = Message(
      id: '',
      chatId: '',
      from: email,
      to: to,
      text: text,
      type: MessageType.text,
      date: DateTime.now(),
      state: MessageState.waiting,
    );
    messages.add(message);
    si.socket?.emit('stop-typing', {'to': to});
    if (timer != null) {
      timer?.cancel();
    }
    si.socket?.emit('message', {
      'from': email,
      'to': to,
      'text': text,
      'createdAt': message.date.toIso8601String()
    });
    animateToLast();
  }

  void onTextChanged(String text) {
    if (timer != null) {
      timer?.cancel();
    }
    si.socket?.emit('typing', {'to': to});
    // await Future.delayed(const Duration(seconds: 1));
    timer = Timer(const Duration(seconds: 1), () {
      si.socket?.emit('stop-typing', {'to': to});
    });
  }
}
