import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketInit {
  io.Socket? socket;
  static SocketInit? _instance;
  SocketInit._(String url) {
    if (socket == null) {
      socket = io.io(
        url,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .disableAutoConnect()
            .build(),
      );
    } else {
      return;
    }
  }
  factory SocketInit(String url) {
    return _instance ?? SocketInit._(url);
  }

  void disconnect() {
    socket?.disconnect();
    socket = null;
  }
}
