import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const IvoireLingoApp());
}

class IvoireLingoApp extends StatelessWidget {
  const IvoireLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IvoireLingo',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
