import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/language_model.dart';
import 'package:myapp/screens/lesson_list_screen.dart';
import 'package:myapp/screens/profile_screen.dart';
import 'package:myapp/screens/recording_screen.dart'; 
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/widgets/language_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('IvoireLingo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      // Utilisation d'un StreamBuilder pour écouter les changements dans la collection 'languages' en temps réel.
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getCollection('languages'),
        builder: (context, snapshot) {
          // Gestion des états d'erreur et de chargement.
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Transformation des documents Firestore en une liste d'objets Language.
          final languages = snapshot.data!.docs.map((doc) {
            return Language.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          // Affichage des langues dans une grille.
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.2, 
            ),
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              return LanguageCard(
                languageName: language.name,
                flag: language.flag,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonListScreen(language: language.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecordingScreen()),
          );
        },
        label: const Text('Contribuer'),
        icon: const Icon(Icons.mic),
      ),
    );
  }
}
