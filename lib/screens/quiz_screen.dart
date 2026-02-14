import 'package:flutter/material.dart';
import 'package:myapp/widgets/quiz_option.dart';

class QuizScreen extends StatefulWidget {
  final String lessonTitle;

  const QuizScreen({super.key, required this.lessonTitle});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedOptionIndex;

  // Données statiques pour le quiz
  final String question = "Que signifie 'Akwaba' ?";
  final List<String> options = ['Bonjour', 'Merci', 'Au revoir', 'Bonsoir'];
  final int correctOptionIndex = 0;

  void _selectOption(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _validateAnswer() {
    if (_selectedOptionIndex == null) return;

    final isCorrect = _selectedOptionIndex == correctOptionIndex;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Bonne réponse !' : 'Mauvaise réponse. Essayez encore.'),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );

    // TODO: Passer à la question suivante ou afficher l'écran des résultats
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.lessonTitle}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            ...List.generate(options.length, (index) {
              return QuizOption(
                optionText: options[index],
                isSelected: _selectedOptionIndex == index,
                onTap: () => _selectOption(index),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: _validateAnswer,
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
