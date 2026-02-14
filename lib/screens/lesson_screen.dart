import 'package:flutter/material.dart';
import 'package:myapp/models/lesson_model.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/widgets/phrase_item.dart';
import 'package:myapp/services/audio_service.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;

  const LessonScreen({super.key, required this.lessonId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final AudioService _audioService = AudioService();
  late Future<Lesson> _lessonFuture;

  @override
  void initState() {
    super.initState();
    _lessonFuture = _loadLesson();
  }

  Future<Lesson> _loadLesson() async {
    final doc = await _firestoreService.getDocument('lessons', widget.lessonId);
    return Lesson.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leçon'),
      ),
      body: FutureBuilder<Lesson>(
        future: _lessonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement de la leçon.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Leçon non trouvée.'));
          }

          final lesson = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: lesson.phrases.length,
            itemBuilder: (context, index) {
              final phrase = lesson.phrases[index];
              return PhraseItem(
                textFr: phrase.textFr,
                textLocal: phrase.textLocal,
                onPlayAudio: () {
                  // Logique pour jouer l'audio
                },
              );
            },
          );
        },
      ),
    );
  }
}
