import 'package:flutter/material.dart';
import '../models/language_model.dart';

class LanguageCard extends StatelessWidget {
  final Language language;

  const LanguageCard({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: language.color.withOpacity(0.1),
      child: InkWell(
        onTap: () {
          // Navigate to lesson list for this language
          print('Tapped on ${language.name}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for a proper icon/image
              Text(language.flagIcon, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 10),
              Text(
                language.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: language.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
