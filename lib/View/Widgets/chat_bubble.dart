import 'package:flutter/material.dart';
import 'package:talk_app/Core/Utils/Message/message_state.dart';
import 'package:talk_app/Model/Models/message.dart';
import 'package:intl/intl.dart' as intl;

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool fromMe;
  const ChatBubble({Key? key, required this.message, this.fromMe = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String date = intl.DateFormat('hh:mm a').format(message.date);
    final double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: fromMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(
          minWidth: width * 0.2,
          maxWidth: width * 0.8,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: fromMe ? Colors.blue : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: Text(
                message.text,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: fromMe ? Colors.white : null,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color: fromMe ? Colors.white38 : Colors.black38,
                    fontSize: 10,
                  ),
                ),
                if (fromMe) ...[
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(
                    _checkMessageState(),
                    color: message.state == MessageState.failed
                        ? Colors.red
                        : Colors.white,
                    size: 16,
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _checkMessageState() {
    switch (message.state) {
      case MessageState.read:
        return Icons.check_circle;
      case MessageState.delivered:
        return Icons.check_circle_outline;
      case MessageState.sent:
        return Icons.check;
      case MessageState.waiting:
        return Icons.alarm;
      case MessageState.failed:
        return Icons.info;
    }
  }
}
