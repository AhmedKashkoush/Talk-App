import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talk_app/Core/Constants/links.dart';
import 'package:talk_app/Core/Utils/Message/message_state.dart';
import 'package:talk_app/Core/Utils/Message/message_types.dart';
import 'package:talk_app/Core/Utils/Socket/socket_init.dart';
import 'package:talk_app/Model/Models/message.dart';

class ChatController extends GetxController {
  late SocketInit si;
  final RxList<Message> messages = <Message>[].obs;
  final String email = Get.arguments['email'];

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxInt _newMessages = 0.obs;
  RxInt get newMessages => _newMessages;

  final RxBool _show = false.obs;
  RxBool get show => _show;

  @override
  void onInit() {
    _initConnection();
    scrollController.addListener(_showArrow);
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    si.disconnect();
    super.dispose();
  }

  void _showArrow() {
    final double maxPosition = scrollController.position.maxScrollExtent + 200;
    final double currentPosition = scrollController.position.pixels;
    if (currentPosition < maxPosition - 500) {
      _show.value = true;
    } else {
      _show.value = false;
      _newMessages.value = 0;
    }
  }

  void _initConnection() {
    si = SocketInit(Links.base);
    si.socket?.connect();
    si.socket?.emit('connected', {'email': email});
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
      final double maxPosition =
          scrollController.position.maxScrollExtent + 200;
      final double currentPosition = scrollController.position.pixels;
      if (currentPosition < maxPosition - 500) {
        _newMessages.value++;
        return;
      }
      animateToLast();
    });
  }

  void animateToLast() {
    final double maxPosition = scrollController.position.maxScrollExtent + 200;
    scrollController.animateTo(
      maxPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void send(String text) {
    final Message message = Message(
      id: '',
      chatId: '',
      from: email,
      to: controller.text,
      text: text,
      type: MessageType.text,
      date: DateTime.now(),
      state: MessageState.waiting,
    );
    messages.add(message);
    si.socket?.emit('message', {
      'from': email,
      'to': controller.text,
      'text': text,
      'createdAt': message.date.toIso8601String()
    });
    final double maxPosition = scrollController.position.maxScrollExtent + 200;
    final double currentPosition = scrollController.position.pixels;
    if (currentPosition < maxPosition - 500) return;
    animateToLast();
  }
}
