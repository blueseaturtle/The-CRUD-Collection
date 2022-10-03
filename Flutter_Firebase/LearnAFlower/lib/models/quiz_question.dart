class QuizQuestion {
  String id = '';
  String image = '';
  final String question;
  final int answer;
  final List<dynamic> options;

  QuizQuestion(
      {required this.id,
      required this.image,
      required this.question,
      required this.answer,
      required this.options});

  QuizQuestion.newQuestion(
      {required this.answer, required this.options, required this.question});

  factory QuizQuestion.fromDocumentSnapshot(dynamic doc) {
    return QuizQuestion(
        id: doc['id'],
        answer: doc['answer'],
        image: doc['image'],
        options: doc['options'],
        question: doc['question']);
  }

  static toJSON(QuizQuestion question) {
    return {
      'id': question.id,
      'image': question.image,
      'question': question.question,
      'answer': question.answer,
      'options': question.options
    };
  }
}
