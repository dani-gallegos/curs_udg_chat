import 'package:chat_client/generated/grpc/chat.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class ChatService {
  static const String _backendServer = 'localhost';
  static const int _backendPort = 5000;

  final ClientChannel _channel;
  late ChatterBoxClient _client;

  ChatService()
      : _channel = ClientChannel(
          _backendServer,
          port: _backendPort,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        ) {
    _client = ChatterBoxClient(_channel);
  }

  Stream<ChatMessage> createChat(Stream<ChatMessage> outgoingMessages) {
    return _client.chat(outgoingMessages).asBroadcastStream();
    //return client.chat(outgoingMessages).asBroadcastStream(); //Extra: for listening multiple times
  }

  void shutdown() {
    _channel.shutdown();
  }
}
