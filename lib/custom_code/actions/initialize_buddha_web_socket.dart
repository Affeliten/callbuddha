// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

Future<void> initializeBuddhaWebSocket(BuildContext context) async {
  WebSocketChannel? channel;

  try {
    final wsUrl = Uri.parse(
        'wss://api.openai.com/v1/realtime?model=gpt-4o-realtime-preview-2024-10-01');
    final apiKey = FFAppState().openAIKey;
    final accessToken = FFAppState().accessToken;

    final headers = {
      'Authorization': 'Bearer $apiKey',
      'OpenAI-Beta': 'realtime=v1',
      'Content-Type': 'application/json',
      if (accessToken != null && accessToken.isNotEmpty)
        'access-token': accessToken,
    };

    channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;

    // Send the headers as the first message
    channel.sink.add(json.encode(headers));

    print('Connected to OpenAI Realtime API');

    FFAppState().update(() {
      FFAppState().isWebSocketOpen = true;
      FFAppState().buddhaWSConnection = channel;
    });

    // Initialize Buddha session
    channel.sink.add(json.encode({
      "type": "session.update",
      "session": {
        "voice": "sage",
        "modalities": ["audio", "text"],
        "input_audio_transcription": true,
        "turn_detection": "server_vad",
        "instructions":
            "You are Buddha, providing wisdom and guidance with a calm, compassionate voice."
      }
    }));

    channel.stream.listen(
      (message) {
        final data = json.decode(message);
        FFAppState().update(() {
          if (data['type'] == 'session.created') {
            FFAppState().sessionId = data['session']['id'];
          } else if (data['type'] == 'response.text.delta') {
            List<dynamic> currentHistory =
                List.from(FFAppState().conversationHistory ?? []);
            currentHistory.add({
              'role': 'assistant',
              'content': data['delta']['text'],
              'timestamp': DateTime.now().toIso8601String()
            });
            FFAppState().conversationHistory = currentHistory;
          } else if (data['type'] == 'response.audio.delta') {
            List<String> currentBuffer =
                List.from(FFAppState().audioBuffer ?? []);
            currentBuffer.add(data['delta']['audio']);
            FFAppState().audioBuffer = currentBuffer;
          }
        });
      },
      onDone: () {
        print('WebSocket connection closed');
        _handleDisconnection(context);
      },
      onError: (error) {
        print('WebSocket error: $error');
        _handleDisconnection(context);
      },
    );
  } catch (e) {
    print('Error establishing WebSocket connection: $e');
    _handleDisconnection(context);
  }
}

void _handleDisconnection(BuildContext context) {
  FFAppState().update(() {
    FFAppState().isWebSocketOpen = false;
    FFAppState().buddhaWSConnection = null;
    FFAppState().sessionId = '';
  });
}
