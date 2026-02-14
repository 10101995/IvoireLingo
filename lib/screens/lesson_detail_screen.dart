import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/lesson_model.dart';
import '../models/phrase_model.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({super.key, required this.lesson});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> playAudio(String url) async {
    try {
      await player.play(UrlSource(url));
    } catch (e) {
      print("Error playing audio: $e");
      // Show a snackbar or dialog to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur de lecture audio.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for phrases with a real audio example
    final List<Phrase> phrases = [
      Phrase(
        id: '1',
        frenchText: 'Bonjour',
        translatedText: 'Akwaba',
        audioUrl: 'https://firebasestorage.googleapis.com/v0/b/ivoirelingo.appspot.com/o/salut.mp3?alt=media',
      ),
      Phrase(
        id: '2',
        frenchText: 'Comment ça va ?',
        translatedText: 'I ka kene?',
        audioUrl: 'https://firebasestorage.googleapis.com/v0/b/ivoirelingo.appspot.com/o/commentcava.mp3?alt=media',
      ),
      Phrase(id: '3', frenchText: 'Je vais bien', translatedText: 'M\'be kene', audioUrl: 'dummy_url'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: ListView.builder(
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          final phrase = phrases[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(phrase.frenchText),
              subtitle: Text(phrase.translatedText, style: const TextStyle(fontStyle: FontStyle.italic)),
              trailing: IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  playAudio(phrase.audioUrl);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
