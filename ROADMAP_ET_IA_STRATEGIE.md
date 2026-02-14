# IvoireLingo : Roadmap Technique & Stratégie IA

Ce document sert de source de vérité pour l'architecture, le plan de développement et la stratégie de collecte de données pour l'intelligence artificielle du projet IvoireLingo.

## 1. Arborescence du Projet

Voici la structure de dossiers cible pour une architecture propre et évolutive.

```
/
|-- lib/
|   |-- main.dart               # Point d'entrée de l'application
|   |-- app_theme.dart          # Fichier central pour le thème (couleurs, polices)
|   |
|   |-- screens/                # Contient les écrans complets de l'application
|   |   |-- splash_screen.dart
|   |   |-- home_screen.dart
|   |   |-- lesson_list_screen.dart
|   |   |-- lesson_screen.dart
|   |   |-- quiz_screen.dart
|   |   |-- profile_screen.dart
|   |
|   |-- widgets/                # Widgets réutilisables à travers l'application
|   |   |-- language_card.dart
|   |   |-- lesson_item.dart
|   |   |-- quiz_option.dart
|   |   |-- audio_player_widget.dart
|   |
|   |-- models/                 # Classes de modèle pour les données (ex: depuis Firestore)
|   |   |-- language_model.dart
|   |   |-- lesson_model.dart
|   |   |-- user_profile_model.dart
|   |   |-- quiz_model.dart
|   |
|   |-- services/               # Logique métier et communication avec les APIs externes
|   |   |-- auth_service.dart       # Authentification Firebase (connexion, etc.)
|   |   |-- firestore_service.dart  # Interaction avec la base de données Firestore
|   |   |-- audio_recording_service.dart # Gestion de l'enregistrement audio
|   |
|   |-- data/                   # Données statiques ou sources de données brutes
|   |   |-- initial_languages.dart  # Liste des langues de départ
|   |
|   |-- navigation/             # Gestion de la navigation (GoRouter)
|   |   |-- app_router.dart
|   |
|-- assets/
|   |-- images/
|   |-- icons/
|   |-- fonts/
|
|-- pubspec.yaml
|-- ROADMAP_ET_IA_STRATEGIE.md
```

## 2. Structure des Données (Firestore)

### Collection `lessons` - Structure d'un document JSON :

```json
{
  "lessonId": "baoule_01_greetings",
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
}
```

## 3. Checklist de Développement (Phase 1)

- [ ] **Setup Firebase & CI/CD**
  - [ ] Créer le projet Firebase.
  - [ ] Configurer Firestore et les règles de sécurité de base.
  - [ ] Configurer Firebase Authentication.
  - [ ] Mettre en place `flutterfire_cli` pour la configuration Flutter.
- [ ] **Écran d'Accueil (Home Screen)**
  - [X] Créer `home_screen.dart` avec la liste des 4 langues initiales.
  - [X] Créer le widget `language_card.dart`.
  - [ ] Mettre en place la navigation vers un écran de leçons (vide pour l'instant).
- [ ] **Structure des Leçons & Quiz**
  - [ ] Créer les modèles Dart (`lesson_model.dart`, `quiz_model.dart`).
  - [ ] Créer l'écran `lesson_list_screen.dart` qui affiche les leçons pour une langue.
  - [ ] Développer l'écran `lesson_screen.dart` pour afficher les phrases.
  - [ ] Implémenter le premier type de quiz (`multiple_choice_text`).
- [ ] **Fonctionnalité Audio**
  - [ ] Intégrer un package de lecture audio (ex: `just_audio`).
  - [ ] Lire les phrases des leçons depuis une URL distante.
- [ ] **Contribution IA (Crowdsourcing)**
  - [ ] Créer l'UI pour la fonctionnalité "Enregistrer votre voix".
  - [ ] Intégrer un package d'enregistrement audio (ex: `record`).
  - [ ] Uploader le fichier audio (WAV) et ses métadonnées sur Firebase Storage.


## 4. Stratégie d'Entraînement de l'IA (Low-Resource Languages)

Cette section est cruciale. Notre succès dépend de la qualité des données que nous collectons.

### A. Méthode de Collecte : Crowdsourcing Actif et Passif

Nous utiliserons l'application elle-même comme principal outil de collecte.

1.  **Contribution Active (Fonctionnalité "Studio d'Enregistrement")** :
    *   Une section dédiée dans l'app où les utilisateurs (validés comme "locuteurs natifs") peuvent lire et enregistrer des phrases proposées.
    *   **Gamification** : Les contributeurs gagnent des points, des badges ("Gardien de la Langue") et apparaissent dans un classement pour encourager la participation.
    *   **Validation Croisée** : Chaque phrase est enregistrée par plusieurs utilisateurs. D'autres utilisateurs peuvent ensuite écouter et voter pour le meilleur enregistrement, garantissant la qualité.

2.  **Contribution Passive (Pendant les leçons)** :
    *   Lors de certains exercices de prononciation, l'application demandera à l'utilisateur s'il accepte que son enregistrement soit utilisé (anonymement) pour améliorer l'IA. C'est une source de données massive.

### B. Structure des Données pour le Fine-Tuning

Chaque enregistrement sera stocké sur **Firebase Storage** et sa métadonnée sur **Firestore**.

*   **Format Audio** : **WAV, 16-bit, 16kHz, mono**. C'est un standard pour la plupart des modèles de reconnaissance vocale (ASR).
*   **Stockage** : `gs://ivoirelingo-contributions/baoule/user_id_xyz/timestamp_abc.wav`
*   **Métadonnée (Document Firestore dans une collection `contributions`)** :

```json
{
  "contributionId": "contrib_abc123",
  "userId": "user_id_xyz",
  "languageId": "baoule",
  "originalPhraseId": "phrase_02", // Lien vers la phrase lue
  "text_local": "Y'o oulé?",      // Le texte exact qui a été lu
  "audio_storage_path": "gs://ivoirelingo-contributions/baoule/user_id_xyz/timestamp_abc.wav",
  "timestamp": "2024-10-27T10:00:00Z",
  "validation_score": 0, // Score basé sur les votes des autres utilisateurs
  "device_info": {
    "os": "Android 13",
    "model": "Pixel 7"
  }
}
```
Ce "couplage" texte-audio est la pierre angulaire de l'entraînement de modèles comme Whisper, SeamlessM4T, etc.

### C. Pipeline : Des Données Brutes au Modèle Entraîné

1.  **Étape 1 : Collecte & Stockage**
    *   L'application collecte les paires `(audio.wav, texte)` et les stocke sur Firebase (Storage + Firestore).

2.  **Étape 2 : Pré-traitement et Filtrage (Cloud Functions / Batch Job)**
    *   **Normalisation** : Uniformiser le volume des audios.
    *   **Filtrage** : Écarter les enregistrements trop courts (<1s), trop longs (>15s) ou silencieux.
    *   **Filtrage par Qualité** : Utiliser le `validation_score` pour ne garder que les contributions les mieux notées par la communauté.

3.  **Étape 3 : Annotation & Formatage**
    *   Créer un script qui génère un fichier `dataset.jsonl` ou un format compatible Hugging Face, où chaque ligne contient le chemin du fichier audio et la transcription.
    *   Exemple : `{"audio": "path/to/audio1.wav", "sentence": "Y'o oulé?"}`

4.  **Étape 4 : Fine-Tuning du Modèle de Base**
    *   Choisir un modèle pré-entraîné (ex: `facebook/seamless-m4t-v2-large`, `openai/whisper-large-v3`).
    *   Utiliser une plateforme comme Google Colab Pro, Vertex AI, ou Hugging Face pour lancer le fine-tuning sur notre `dataset.jsonl`. L'objectif est d'adapter le modèle à l'accent, au vocabulaire et à la prosodie spécifiques des langues ivoiriennes.

5.  **Étape 5 : Évaluation**
    *   Mesurer la performance du modèle sur un jeu de test (données non utilisées pour l'entraînement) avec des métriques comme le Word Error Rate (WER).

6.  **Étape 6 : Déploiement**
    *   Déployer le modèle fine-tuné sur un service comme Firebase ML ou Vertex AI pour qu'il soit accessible depuis l'application via une API.
