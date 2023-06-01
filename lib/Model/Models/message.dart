import 'package:talk_app/Core/Utils/Message/message_state.dart';
import 'package:talk_app/Core/Utils/Message/message_types.dart';

class Message {
  final String id;
  final String chatId;
  final String from;
  final String to;
  final String text;
  final MessageType type;
  final DateTime date;
  final MessageState state;

  const Message({
    required this.id,
    required this.chatId,
    required this.from,
    required this.to,
    this.text = '',
    this.type = MessageType.text,
    required this.date,
    required this.state,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        id: json['_id'],
        chatId: json['chatId'],
        from: json['from'],
        to: json['to'],
        text: json['text'],
        type: MessageType.values.byName(
          json['messageType'],
        ),
        date: DateTime.parse(json['createdAt']),
        state: MessageState.values.byName(json['state']),
      );

  static Map<String, dynamic> toJson(Message model) => {
        'id': model.id,
        'chatId': model.chatId,
        'from': model.from,
        'to': model.to,
        'text': model.text,
        'type': model.type.name,
        'state': model.state.name,
      };

  Message copyWith({
    String? id,
    String? chatId,
    String? from,
    String? to,
    String? text,
    MessageType? type,
    DateTime? date,
    MessageState? state,
  }) =>
      Message(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        from: from ?? this.from,
        to: to ?? this.to,
        text: text ?? this.text,
        type: type ?? this.type,
        date: date ?? this.date,
        state: state ?? this.state,
      );
}
