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
        home: const JoinScreen());
  }
}

class JoinScreen extends StatelessWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(onSubmitted: (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return MyHomePage(email: value);
              },
            ),
          );
        }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late io.Socket socket;
  final List<Map<String, dynamic>> _messages = [];

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    initConnection();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    socket.disconnect();
    super.dispose();
  }

  void initConnection() {
    socket = io.io(
      'http://localhost:4040',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
    socket.emit('connected', {'email': widget.email});
    socket.on(
      'message',
      (data) {
        setState(() {
          _messages.add(data);
        });
      },
    );
  }

  void send(String text) {
    setState(() {
      _messages.add({'from': widget.email, 'text': text});
      socket.emit('message',
          {'from': widget.email, 'to': controller.text, 'text': text});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Text('from:${widget.email}'),
          TextField(
            decoration: const InputDecoration(hintText: 'to'),
            controller: controller,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return BubbleNormal(
                  text: _messages[index]['text'],
                  color: _messages[index]['from'] == widget.email
                      ? Colors.blue
                      : Colors.grey.shade400,
                  tail: index == _messages.length - 1,
                  textStyle: TextStyle(
                    color: _messages[index]['from'] == widget.email
                        ? Colors.white
                        : null,
                  ),
                  seen: _messages[index]['from'] == widget.email,
                  isSender: _messages[index]['from'] == widget.email,
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
