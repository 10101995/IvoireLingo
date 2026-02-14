import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/services/audio_recording_service.dart';
import 'package:myapp/services/storage_service.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  final AudioRecordingService _recordingService = AudioRecordingService();
  final StorageService _storageService = StorageService();
  bool _isRecording = false;
  String? _recordingPath;

  @override
  void dispose() {
    _recordingService.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _recordingService.stopRecording();
      if (!mounted) return;
      setState(() {
        _isRecording = false;
        _recordingPath = path;
      });
    } else {
      await _recordingService.startRecording();
      if (!mounted) return;
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _uploadRecording() async {
    if (_recordingPath != null) {
      final file = File(_recordingPath!);
      await _storageService.uploadFile(file);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enregistrement envoyé avec succès!')),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucun enregistrement à envoyer.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contribuer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isRecording ? Icons.mic : Icons.mic_none,
              size: 100,
              color: _isRecording ? Colors.red : Colors.black,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleRecording,
              child: Text(_isRecording ? 'Arrêter l\'enregistrement' : 'Démarrer l\'enregistrement'),
            ),
            if (_recordingPath != null)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text('Enregistrement sauvegardé: $_recordingPath'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _uploadRecording,
                    child: const Text('Envoyer'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
