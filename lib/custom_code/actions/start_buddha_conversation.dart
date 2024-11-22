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

import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

Future<void> startBuddhaConversation(BuildContext context) async {
  final record = Record();

  try {
    // Check and request microphone permission
    if (await Permission.microphone.request().isGranted) {
      // Start recording
      if (await record.hasPermission()) {
        await record.start(
          path: 'audio.m4a',
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );

        FFAppState().update(() {
          FFAppState().isRecording = true;
        });

        print('Started recording');

        // Initialize WebSocket connection
        await initializeBuddhaWebSocket(context);

        // Wait for 5 seconds (you can adjust this duration)
        await Future.delayed(Duration(seconds: 5));

        // Stop recording
        final path = await record.stop();

        FFAppState().update(() {
          FFAppState().isRecording = false;
        });

        print('Stopped recording. Audio saved at: $path');

        // Here you would typically send the audio file to your API
        // For demonstration, we'll just print a message
        print('Sending audio to Buddha API...');

        // You can add the logic to send the audio file to your API here
        // For example:
        // await sendAudioToBuddhaAPI(path);
      } else {
        print('No permission to record audio.');
      }
    } else {
      print('Microphone permission denied');
    }
  } catch (e) {
    print('Error in startBuddhaConversation: $e');
    FFAppState().update(() {
      FFAppState().isRecording = false;
    });
  }
}
