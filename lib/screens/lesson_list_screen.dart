import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../models/lesson_model.dart';
import 'lesson_detail_screen.dart'; // Import the new screen

class LessonListScreen extends StatelessWidget {
  final Language language;

  const LessonListScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    // Dummy data for lessons
    final List<Lesson> lessons = [
      Lesson(id: '1', title: 'Salutations de base', description: 'Apprenez à dire bonjour, bonsoir, etc.'),
      Lesson(id: '2', title: 'Présentations', description: 'Comment vous présenter et demander le nom de quelqu\'un.'),
      Lesson(id: '3', title: 'Les chiffres de 1 à 10', description: 'Compter jusqu\'à dix dans la langue de votre choix.'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Leçons de ${language.name}'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(lesson.description),
              trailing: const Icon(Icons.play_circle_outline),
              onTap: () {
                // Navigate to lesson details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailScreen(lesson: lesson),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
