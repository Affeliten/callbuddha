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
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> toggleAudioRecording(
  BuildContext context,
  bool start,
) async {
  final record = Record();

  try {
    if (!start) {
      // Stop recording
      final path = await record.stop();
      FFAppState().update(() {
        FFAppState().isRecording = false;
        FFAppState().audioFilePath = path ?? '';
      });
      print('Stopped recording. Audio saved at: ${FFAppState().audioFilePath}');

      if (FFAppState().audioFilePath.isNotEmpty) {
        print('Sending audio to Buddha API...');
      }
    } else {
      // Start recording
      final micPermission = await Permission.microphone.request();
      if (micPermission.isGranted) {
        if (await record.hasPermission()) {
          final directory = await getTemporaryDirectory();
          final filePath =
              '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

          await record.start(
            path: filePath,
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            samplingRate: 44100,
          );

          FFAppState().update(() {
            FFAppState().isRecording = true;
            FFAppState().audioFilePath = filePath;
          });

          print('Started recording at: $filePath');
        } else {
          print('No permission to record audio.');
        }
      } else {
        print('Microphone permission denied');
      }
    }
  } catch (e) {
    print('Error in toggleAudioRecording: $e');
    FFAppState().update(() {
      FFAppState().isRecording = false;
      FFAppState().audioFilePath = '';
    });
  }
}
