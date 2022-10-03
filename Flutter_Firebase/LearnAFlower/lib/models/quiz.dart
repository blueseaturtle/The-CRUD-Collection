class Quiz {
  final String id;
  final String title;
  final int level;
  List<dynamic> questions = [];

  Quiz(
      {required this.id,
      required this.title,
      required this.level,
      required this.questions});

  Quiz.newQuiz({
    required this.id,
    required this.title,
    required this.level,
  });

  factory Quiz.fromDocumentSnapshot(dynamic doc) {
    return Quiz(
      id: doc.data()['id'],
      title: doc.data()['title'],
      level: doc.data()['level'],
      questions: doc.data()['questions'],
    );
  }

  static toJSON(Quiz quiz) {
    return {
      'id': quiz.id,
      'title': quiz.title,
      'level': quiz.level,
      'questions': quiz.questions
    };
  }
}
