
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class InitialData {
  static Future<void> populateFirestore() async {
    final firestore = FirebaseFirestore.instance;
    const String lessonId = 'baoule_01_greetings';
    
    developer.log('Starting to populate Firestore...', name: 'InitialData');

    final lessonData = {
      "lessonId": lessonId,
      "languageId": "baoule",
      "title": "Les Salutations de Base",
      "level": 1,
      "phrases": [
        {
          "id": "phrase_01",
          "text_fr": "Bonjour (le matin)",
          "text_local": "Assou CIE",
          "phonetic": "/a.su tjɛ/",
          "audio_url_ref": "gs://ivoirelingo-audio-prod/baoule/greetings/assou_cie.wav"
        },
        {
          "id": "phrase_02",
          "text_fr": "Comment vas-tu ?",
          "text_local": "Y'o oulé?",
          "phonetic": "/jɔ u.le/",
          "audio_url_ref": "gs://ivoirelingo-audio-prod/baoule/greetings/yo_oule.wav"
        }
      ],
      "quiz": [
        {
          "quizId": "quiz_01",
          "type": "multiple_choice_text",
          "question": "Que signifie 'Assou CIE' ?",
          "options": ["Bonjour", "Merci", "Au revoir", "Bonsoir"],
          "correctAnswer": "Bonjour"
        },
        {
          "quizId": "quiz_02",
          "type": "listening_challenge",
          "audio_url_ref": "gs://ivoirelingo-audio-prod/baoule/greetings/yo_oule.wav",
          "question": "Écoutez et choisissez la bonne traduction :",
          "options": ["Bonjour", "Comment vas-tu ?", "Je m'appelle...", "Oui"],
          "correctAnswer": "Comment vas-tu ?"
        }
      ]
    };

    try {
      // We use set with merge:true to avoid overwriting the document if it already exists.
      await firestore.collection('lessons').doc(lessonId).set(lessonData, SetOptions(merge: true));
      developer.log('Firestore populated successfully for document: $lessonId', name: 'InitialData', level: 800);
    } catch (e, s) {
      developer.log(
        'Error populating Firestore',
        name: 'InitialData',
        level: 1000, // SEVERE
        error: e,
        stackTrace: s,
      );
    }
  }
}
