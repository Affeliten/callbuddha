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

Future<void> sendBuddhaMessage(
  BuildContext context,
  String message,
) async {
  if (FFAppState().buddhaWSConnection != null && FFAppState().isWebSocketOpen) {
    try {
      final WebSocketChannel channel = FFAppState().buddhaWSConnection!;

      // Add the user's message to the conversation history
      FFAppState().update(() {
        List<dynamic> currentHistory =
            List.from(FFAppState().conversationHistory ?? []);
        currentHistory.add({
          'role': 'user',
          'content': message,
          'timestamp': DateTime.now().toIso8601String()
        });
        FFAppState().conversationHistory = currentHistory;
      });

      // Send the message to the WebSocket
      final payload = json.encode({
        "type": "message",
        "message": {"role": "user", "content": message}
      });

      channel.sink.add(payload);
      print('Message sent: $message');
    } catch (e) {
      print('Error sending message: $e');
    }
  } else {
    print('WebSocket is not connected. Unable to send message.');
    // Optionally, you could try to reconnect here or show a message to the user
  }
}
