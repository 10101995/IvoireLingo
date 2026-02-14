import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final String languageName;
  final String flag;
  final VoidCallback onTap;

  const LanguageCard({super.key, required this.languageName, required this.flag, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 40.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              languageName,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
