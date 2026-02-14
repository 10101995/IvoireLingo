class Quiz {
  final String quizId;
  final String type;
  final String question;
  final List<String> options;
  final String correctAnswer;

  Quiz({
    required this.quizId,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
