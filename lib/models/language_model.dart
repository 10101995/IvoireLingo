class Language {
  final String id;
  final String name;
  final String flag;

  Language({required this.id, required this.name, required this.flag});

  factory Language.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Language(
      id: documentId,
      name: data['name'] ?? '',
      flag: data['flag'] ?? '🇨🇮',
    );
  }
}
