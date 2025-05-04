import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_provider.g.dart';

@Riverpod(keepAlive: true)
class MyWebSocket extends _$MyWebSocket {
  late WebSocketChannel channel;

  @override
  Future<WebSocketChannel> build() async {
    /// Create the WebSocket channel
    final myWsUrl = 'wss://echo.websocket.events';
    channel = WebSocketChannel.connect(Uri.parse(myWsUrl));

    ref.onDispose(channel.sink.close);

    await channel.ready;
    return channel;
  }

  void send(String message) {
    channel.sink.add(message);
  }
}
