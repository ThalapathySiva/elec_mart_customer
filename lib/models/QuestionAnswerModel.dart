class QuestionAnswerModel {
  final String question;
  final String answer;

  QuestionAnswerModel({this.question, this.answer});

  factory QuestionAnswerModel.fromJson(Map<dynamic, dynamic> json) {
    return QuestionAnswerModel(
      question: json['questionText'],
      answer: json['answerText'],
    );
  }
}
