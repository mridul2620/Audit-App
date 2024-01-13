import 'dart:io';

class Category {
  final int id;
  final String categoryName;
  final List<Question> questions;
  final String categoryImage;

  Category({
    required this.id,
    required this.categoryName,
    required this.questions,
    required this.categoryImage,
  });
}

class Question {
  final int id;
  final int categoryId;
  final int questionNo;
  final String questionName;

  Question({
    required this.id,
    required this.categoryId,
    required this.questionNo,
    required this.questionName,
  });
}

class QuestionData {
  final Question question;
  String selectedMethodology; // 0 for "Visually", 1 for "Records", 2 for "Both"
  String observation;
  String recommendation;
  String riskLevel; // 'Normal', 'Low', 'High', 'No Risk'
  File? evidenceImage1;
  File? evidenceImage2;
  File? evidenceImage3;

  QuestionData({
    required this.question,
    required this.selectedMethodology,
    required this.observation,
    required this.recommendation,
    required this.riskLevel,
    required this.evidenceImage1,
    required this.evidenceImage2,
    required this.evidenceImage3,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    final question = Question(
      id: json['question']['id'],
      categoryId: json['question']['categoryId'],
      questionNo: json['question']['questionNo'],
      questionName: json['question']['questionName'],
    );

    return QuestionData(
      question: question,
      selectedMethodology: json['selectedMethodology'],
      observation: json['observation'],
      recommendation: json['recommendation'],
      riskLevel: json['riskLevel'],
      evidenceImage1: json['evidenceImage1'],
      evidenceImage2: json['evidenceImage2'],
      evidenceImage3: json['evidenceImage3'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': {
        'id': question.id,
        'categoryId': question.categoryId,
        'questionNo': question.questionNo,
        'questionName': question.questionName,
      },
      'evidenceImage1': evidenceImage1 != null ? evidenceImage1!.path : null,
      'evidenceImage2': evidenceImage2 != null ? evidenceImage2!.path : null,
      'evidenceImage3': evidenceImage3 != null ? evidenceImage3!.path : null,
    };
  }
}
