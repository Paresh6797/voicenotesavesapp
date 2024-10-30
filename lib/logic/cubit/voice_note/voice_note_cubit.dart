import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceNoteCubit extends Cubit<List<String>> {
  final List<String> voiceNotes = [];
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;

  VoiceNoteCubit() : super([]);

  Future<void> startRecording(String userId) async {
    if (!await requestMicrophonePermission()) {
      emitError('Microphone permission denied.');
      return;
    }

    try {
      _recorder = FlutterSoundRecorder();
      await _recorder!.openRecorder();

      // Create a directory for user-specific voice notes
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String userNotesPath = '${appDocDir.path}/voice_notes/$userId';
      await Directory(userNotesPath).create(recursive: true);

      loadVoiceNotes(userId);

      // Set the path for the recording
      String filePath = '$userNotesPath/note_${voiceNotes.length}.aac';
      await _recorder!.startRecorder(toFile: filePath);
    } catch (e) {
      emitError('Failed to start recording: $e');
    }
  }

  Future<void> stopRecording(String userId) async {
    try {
      String? path = await _recorder!.stopRecorder();
      if (path != null) {
       await loadVoiceNotes(userId);
      }
    } catch (e) {
      emitError('Failed to stop recording: $e');
    }
  }

  Future<void> playRecording(String path) async {
    try {
      _player = FlutterSoundPlayer();
      await _player!.openPlayer();
      await _player!.startPlayer(fromURI: path);
    } catch (e) {
      // emitError('Failed to play recording: $e');
    }
  }

  /*Future<void> pausePlayback() async {
    if (isPlaying) {
      await _player?.pausePlayer();
      isPlaying = false;
      emit(List.from(voiceNotes));
    }
  }

  Future<void> resumePlayback() async {
    try {
      if (_player == null) {
        _player = FlutterSoundPlayer();
        await _player!.openPlayer();
      }

      if (!isPlaying) {
        await _player?.resumePlayer();
        isPlaying = true;
      }
    } catch (e) {
      emitError('Failed to resume playback: $e');
    }
  }

  Future<void> stopPlayback() async {
    await _player?.stopPlayer();
  }
*/
  Future<void> loadVoiceNotes(String userId) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String userNotesPath = '${appDocDir.path}/voice_notes/$userId';
      final directory = Directory(userNotesPath);

      if (await directory.exists()) {
        List<FileSystemEntity> files = directory.listSync();
        voiceNotes.clear();
        voiceNotes.addAll(files.map((file) => file.path));
        emit(List.from(voiceNotes)); // Emit loaded voice notes
      } else {
        emit([]);
      }
    } catch (e) {
      emit([]);
    }
  }

  Future<bool> requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      // Request permission
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }

  void emitError(String message) {
    print("Error: $message");
  }

  Future<void> dispose() async {
    await _recorder?.closeRecorder();
    await _player?.closePlayer();
    _recorder = null;
    _player = null;
    await super.close();
  }
}
