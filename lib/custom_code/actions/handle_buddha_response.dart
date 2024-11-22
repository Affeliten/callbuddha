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

import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> handleBuddhaResponse(BuildContext context) async {
  final audioPlayer = AudioPlayer();

  if (FFAppState().buddhaWSConnection != null &&
      FFAppState().buddhaWSConnection.isConnected) {
    try {
      // Create a WebSocketChannel from the stored connection information
      final uri = Uri.parse(FFAppState().buddhaWSConnection.url);
      final channel = WebSocketChannel.connect(uri);

      channel.stream.listen(
        (dynamic message) async {
          final data = json.decode(message.toString());

          if (data['type'] == 'audio') {
            final audioData = data['audio'];
            try {
              await audioPlayer.setAudioSource(
                AudioSource.uri(Uri.parse('data:audio/wav;base64,$audioData')),
              );
              FFAppState().update(() {
                FFAppState().isPlayingAudio = true;
              });
              await audioPlayer.play();
              await audioPlayer.playerStateStream.firstWhere((state) =>
                  state.processingState == ProcessingState.completed);
            } catch (e) {
              print('Error playing audio: $e');
            } finally {
              FFAppState().update(() {
                FFAppState().isPlayingAudio = false;
              });
            }
          } else if (data['type'] == 'text') {
            FFAppState().update(() {
              FFAppState().buddhaResponse = data['text'];
            });
          }

          // Update connection state
          FFAppState().update(() {
            FFAppState().buddhaWSConnection = WebSocketConnectionStruct(
              isConnected: true,
              url: FFAppState().buddhaWSConnection.url,
              sessionId: FFAppState().buddhaWSConnection.sessionId,
              lastMessageTimestamp: DateTime.now(),
            );
          });
        },
        onError: (error) {
          print('WebSocket error: $error');
          _handleDisconnection();
        },
        onDone: () {
          print('WebSocket connection closed');
          _handleDisconnection();
        },
      );
    } catch (e) {
      print('Error handling Buddha response: $e');
      _handleDisconnection();
    }
  } else {
    print('WebSocket connection is not established');
  }
}

void _handleDisconnection() {
  FFAppState().update(() {
    FFAppState().buddhaWSConnection = WebSocketConnectionStruct(
      isConnected: false,
      url: FFAppState().buddhaWSConnection?.url ?? '',
      sessionId: FFAppState().buddhaWSConnection?.sessionId ?? '',
      lastMessageTimestamp: DateTime.now(),
    );
  });
}
