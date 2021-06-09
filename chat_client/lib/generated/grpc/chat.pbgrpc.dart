///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;
export 'chat.pb.dart';

class ChatterBoxClient extends $grpc.Client {
  static final _$chat = $grpc.ClientMethod<$0.ChatMessage, $0.ChatMessage>(
      '/chat_dto.ChatterBox/Chat',
      ($0.ChatMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ChatMessage.fromBuffer(value));

  ChatterBoxClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.ChatMessage> chat(
      $async.Stream<$0.ChatMessage> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$chat, request, options: options);
  }
}

abstract class ChatterBoxServiceBase extends $grpc.Service {
  $core.String get $name => 'chat_dto.ChatterBox';

  ChatterBoxServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ChatMessage, $0.ChatMessage>(
        'Chat',
        chat,
        true,
        true,
        ($core.List<$core.int> value) => $0.ChatMessage.fromBuffer(value),
        ($0.ChatMessage value) => value.writeToBuffer()));
  }

  $async.Stream<$0.ChatMessage> chat(
      $grpc.ServiceCall call, $async.Stream<$0.ChatMessage> request);
}
