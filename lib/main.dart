import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/Core/Routes/pages.dart';
import 'package:talk_app/Core/Utils/Socket/socket_init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SocketInit('http://localhost:4040');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Pages.initial,
      getPages: Pages.pages,
    );
  }
}

// class JoinScreen extends StatelessWidget {
//   const JoinScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextField(onSubmitted: (value) {
//           Navigator.push(
//             context,
//             GetPageRoute(
//               page: () => MyHomePage(email: value),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.email}) : super(key: key);
//   final String email;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late SocketInit socket;
//   final List<Message> _messages = [];
//   final TextEditingController controller = TextEditingController();
//   @override
//   void initState() {
//     initConnection();
//     super.initState();
//   }
//   @override
//   void dispose() {
//     controller.dispose();
//     socket.socket.disconnect();
//     super.dispose();
//   }
//   void initConnection() {
//     socket = SocketInit(Links.ws);
//     socket.socket.connect();
//     socket.socket.emit('connected', {'email': widget.email});
//     socket.socket.on(
//       'message',
//       (data) {
//         setState(() {
//           final Message message = Message(
//             id: '',
//             chatId: '',
//             from: data['from'],
//             to: data['to'],
//             text: data['text'],
//             type: MessageType.text,
//             date: DateTime.parse(data['createdAt']),
//             state: MessageState.read,
//           );
//           _messages.add(message);
//         });
//       },
//     );
//   }
//   void send(String text) {
//     setState(() {
//       final Message message = Message(
//         id: '',
//         chatId: '',
//         from: widget.email,
//         to: controller.text,
//         text: text,
//         type: MessageType.text,
//         date: DateTime.now(),
//         state: MessageState.read,
//       );
//       _messages.add(message);
//       socket.socket.emit('message', {
//         'from': widget.email,
//         'to': controller.text,
//         'text': text,
//         'createdAt': message.date.toIso8601String()
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat Screen'),
//       ),
//       body: Column(
//         children: [
//           Text('from:${widget.email}'),
//           TextField(
//             decoration: const InputDecoration(hintText: 'to'),
//             controller: controller,
//           ),
//           Expanded(
//             child: GroupedListView<Message, String>(
//               groupBy: (message) =>
//                   intl.DateFormat.yMMMd().format(message.date),
//               groupSeparatorBuilder: (date) => DateChip(
//                 date: intl.DateFormat.yMMMd().parseStrict(date),
//                 color: Colors.grey.shade400,
//               ),
//               useStickyGroupSeparators: true,
//               floatingHeader: true,
//               elements: _messages,
//               itemBuilder: (context, message) {
//                 return BubbleNormal(
//                   text: message.text,
//                   color: message.from == widget.email
//                       ? Colors.blue
//                       : Colors.grey.shade400,
//                   tail: true,
//                   textStyle: TextStyle(
//                     color: message.from == widget.email ? Colors.white : null,
//                   ),
//                   seen: message.from == widget.email &&
//                       message.type == MessageState.read,
//                   isSender: message.from == widget.email,
//                 );
//               },
//             ),
//           ),
//           MessageBar(
//             onSend: send,
//           ),
//         ],
//       ),
//     );
//   }
// }
