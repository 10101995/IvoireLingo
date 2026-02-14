import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../widgets/language_card.dart';
import '../app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Language> languages = [
      Language(id: 'baoule', name: 'Baoulé', flagIcon: '🛖', color: AppTheme.orange),
      Language(id: 'dioula', name: 'Dioula', flagIcon: '🕌', color: AppTheme.green),
      Language(id: 'bete', name: 'Bété', flagIcon: '🌳', color: Colors.brown),
      Language(id: 'senoufo', name: 'Sénoufo', flagIcon: '🎭', color: Colors.redAccent),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('IvoireLingo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quelle langue veux-tu apprendre aujourd\'hui ?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return LanguageCard(language: languages[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
