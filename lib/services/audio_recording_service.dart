import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecordingService {
  final AudioRecorder _recorder = AudioRecorder();

  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/recording.m4a';
      await _recorder.start(const RecordConfig(), path: path);
    }
  }

  Future<String?> stopRecording() async {
    final path = await _recorder.stop();
    return path;
  }

  void dispose() {
    _recorder.dispose();
  }
}
