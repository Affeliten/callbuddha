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

Future hangUpBuddhaCall(BuildContext context) async {
  if (FFAppState().buddhaWSConnection != null) {
    try {
      final WebSocketChannel channel = FFAppState().buddhaWSConnection;

      // Send a message to end the session
      channel.sink.add(json.encode({
        "type": "session.end",
      }));

      // Close the WebSocket connection
      await channel.sink.close();

      // Reset the app state
      FFAppState().update(() {
        FFAppState().isWebSocketOpen = false;
        FFAppState().buddhaWSConnection = null;
        FFAppState().sessionId = '';
        FFAppState().buddhaResponse = '';
        FFAppState().isPlayingAudio = false;
      });

      print('Buddha call ended successfully');
    } catch (e) {
      print('Error ending Buddha call: $e');
    }
  } else {
    print('No active Buddha call to hang up');
  }
}
