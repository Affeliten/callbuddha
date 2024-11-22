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

import 'package:just_audio/just_audio.dart';
import 'dart:convert';

Future<void> playBuddhaAudio(BuildContext context) async {
  final audioPlayer = AudioPlayer();

  try {
    if (FFAppState().audioBuffer.isNotEmpty) {
      // Combine all audio chunks into a single base64 string
      final completeAudioBase64 = FFAppState().audioBuffer.join();

      // Decode the base64 string to bytes
      final audioBytes = base64Decode(completeAudioBase64);

      // Create a temporary file to store the audio data
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/buddha_audio.mp3');
      await tempFile.writeAsBytes(audioBytes);

      // Set the audio source and play
      await audioPlayer.setFilePath(tempFile.path);

      FFAppState().update(() {
        FFAppState().isPlayingAudio = true;
      });

      await audioPlayer.play();

      // Wait for the audio to complete playing
      await audioPlayer.playerStateStream.firstWhere(
          (state) => state.processingState == ProcessingState.completed);

      FFAppState().update(() {
        FFAppState().isPlayingAudio = false;
        FFAppState().audioBuffer = []; // Clear the buffer after playing
      });

      // Clean up: delete the temporary file
      await tempFile.delete();
    } else {
      print('No audio data available to play');
    }
  } catch (e) {
    print('Error playing Buddha audio: $e');
    FFAppState().update(() {
      FFAppState().isPlayingAudio = false;
    });
  } finally {
    await audioPlayer.dispose();
  }
}
