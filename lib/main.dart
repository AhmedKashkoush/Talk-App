import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late io.Socket socket;
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    socket = io.io(
      'http://localhost:4040',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
    // socket.on(
    //   'message',
    //   (data) => _incrementCounter(),
    // );
    super.initState();
  }

  void send(String text) {
    setState(() {
      _messages.add({'from': 'me', 'text': text});
      socket.emit('message', {'from': 'me', 'text': text});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return BubbleNormal(
                  text: _messages[index]['text'],
                  color: Colors.blue,
                  tail: index == _messages.length - 1,
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  seen: true,
                );
              },
            ),
          ),
          MessageBar(
            onSend: send,
          ),
        ],
      ),
    );
  }
}
