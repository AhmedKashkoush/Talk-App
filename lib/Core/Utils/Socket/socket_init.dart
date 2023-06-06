import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketInit {
  io.Socket? _socket;
  io.Socket? get socket => _socket;
  static SocketInit? _instance;
  SocketInit._(String url) {
    if (socket == null) {
      _socket = io.io(
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

  void connect() {
    if (_socket == null || _socket!.connected) return;
    _socket?.connect();
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }
}
