class Phrase {
  final String id;
  final String textFr;
  final String textLocal;
  final String? audioUrl;

  Phrase({
    required this.id,
    required this.textFr,
    required this.textLocal,
    this.audioUrl,
  });

  factory Phrase.fromMap(Map<String, dynamic> data) {
    return Phrase(
      id: data['id'] ?? '',
      textFr: data['text_fr'] ?? '',
      textLocal: data['text_local'] ?? '',
      audioUrl: data['audio_url_ref'], 
    );
  }
}
