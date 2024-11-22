// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<dynamic> websocketConnection(BuildContext context) async {
  WebSocketChannel? channel;

  try {
    final wsUrl = Uri.parse(
        'wss://api.openai.com/v1/realtime?model=gpt-4o-realtime-preview-2024-10-01');
    final apiKey = FFAppState().openAIKey;

    final headers = {
      'Authorization': 'Bearer $apiKey',
      'OpenAI-Beta': 'realtime=v1',
      'Content-Type': 'application/json',
    };

    channel = WebSocketChannel.connect(
      wsUrl,
      protocols: [json.encode(headers)],
    );

    await channel.ready;
    print('Connected to OpenAI Realtime API');

    FFAppState().update(() {
      FFAppState().buddhaWSConnection = channel;
      FFAppState().isWebSocketOpen = true;
    });

    channel.stream.listen(
      (message) {
        final data = json.decode(message);
        FFAppState().update(() {
          switch (data['type']) {
            case 'session.created':
              FFAppState().sessionId = data['session']['id'];
              break;
            case 'response.text.delta':
              if (FFAppState().conversationHistory == null) {
                FFAppState().conversationHistory = [];
              }
              FFAppState().conversationHistory.add({
                'role': 'assistant',
                'content': data['delta']['text'],
                'timestamp': DateTime.now().toIso8601String(),
              });
              break;
          }
        });
        (context as Element).markNeedsBuild();
      },
      onDone: () {
        print('WebSocket connection closed');
        FFAppState().update(() {
          FFAppState().isWebSocketOpen = false;
          FFAppState().buddhaWSConnection = null;
        });
      },
      onError: (error) {
        print('WebSocket error: $error');
        FFAppState().update(() {
          FFAppState().isWebSocketOpen = false;
          FFAppState().buddhaWSConnection = null;
        });
      },
    );

    return channel;
  } catch (e) {
    print('Error establishing WebSocket connection: $e');
    FFAppState().update(() {
      FFAppState().isWebSocketOpen = false;
      FFAppState().buddhaWSConnection = null;
    });
    return null;
  }
}
