import 'package:flutter/material.dart';

class PhraseItem extends StatelessWidget {
  final String textFr;
  final String textLocal;
  final VoidCallback onPlayAudio;

  const PhraseItem({
    super.key,
    required this.textFr,
    required this.textLocal,
    required this.onPlayAudio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(textFr),
        subtitle: Text(textLocal, style: const TextStyle(fontStyle: FontStyle.italic)),
        trailing: IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: onPlayAudio,
        ),
      ),
    );
  }
}
