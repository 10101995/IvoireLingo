import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/splash_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si l'état de la connexion est en attente, affichez le splash screen.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        // Si l'utilisateur est connecté, affichez l'écran d'accueil.
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Sinon (l'utilisateur n'est pas connecté), vous pouvez afficher un écran de connexion
        // ou, dans notre cas avec la connexion anonyme, simplement continuer à attendre ou afficher une erreur.
        // Pour la robustesse, nous retournons le SplashScreen, car la connexion anonyme devrait réussir.
        return const SplashScreen(); 
      },
    );
  }
}
