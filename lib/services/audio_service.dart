import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
    } catch (e) {
      // Gérer les erreurs de lecture audio
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
