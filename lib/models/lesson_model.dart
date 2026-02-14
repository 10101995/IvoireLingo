import 'package:myapp/models/phrase_model.dart';

class Lesson {
  final String id;
  final String title;
  final int level;
  final String languageId;
  final List<Phrase> phrases;

  Lesson({
    required this.id,
    required this.title,
    required this.level,
    required this.languageId,
    required this.phrases,
  });

  factory Lesson.fromFirestore(Map<String, dynamic> data, String documentId) {
    var phrasesData = data['phrases'] as List<dynamic>? ?? [];
    List<Phrase> phrasesList = phrasesData.map((p) => Phrase.fromMap(p)).toList();

    return Lesson(
      id: documentId,
      title: data['title'] ?? '',
      level: data['level'] ?? 0,
      languageId: data['languageId'] ?? '',
      phrases: phrasesList,
    );
  }
}
