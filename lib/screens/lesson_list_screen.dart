import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/lesson_model.dart';
import 'package:myapp/screens/lesson_screen.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/widgets/lesson_item.dart';

class LessonListScreen extends StatelessWidget {
  final String language;

  const LessonListScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Leçons de $language'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getLessonsForLanguage(language),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final lessons = snapshot.data!.docs.map((doc) {
            return Lesson.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return LessonItem(
                title: lesson.title,
                level: lesson.level,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonScreen(lessonId: lesson.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
