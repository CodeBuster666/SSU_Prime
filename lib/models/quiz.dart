import 'package:ssu_prime/models/question.dart';

class Quiz {
  final String? id;
  final String title;
  final String? categoryId; // Single field for category ID
  final int timeLimit;
  final List<Question> questions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Quiz({
    required this.id,
    required this.title,
    this.categoryId,
    required this.timeLimit,
    required this.questions,
    this.createdAt,
    this.updatedAt,
  });

  factory Quiz.fromMap(String id, Map<String, dynamic> map) {
    return Quiz(
      id: id,
      title: map['title'] ?? "",
      categoryId: map['categoryId'] ?? "", // Use categoryId from Firestore
      timeLimit: map['timeLimit'] ?? 0,
      questions: (map['questions'] as List<dynamic>? ?? [])
          .map((e) => Question.fromMap(e as Map<String, dynamic>))
          .toList(),
      createdAt: map['createdAt']?.toDate(),
      updatedAt: map['updatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap({bool isUpdate = false}) {
    return {
      'title': title,
      'categoryId': categoryId, // Use categoryId as the single field
      'timeLimit': timeLimit,
      'questions': questions.map((e) => e.toMap()).toList(),
      if(isUpdate) 'updatedAt' : DateTime.now(),
      'createdAt' : createdAt,
      // 'updatedAt': DateTime.now(),
      // 'createdAt' : DateTime.now(),
    };
  }

  Quiz copyWith({
    String? id,
    String? title,
    String? categoryId, // Use categoryId consistently
    int? timeLimit,
    List<Question>? questions,
    DateTime? createdAt,
    //DateTime? updatedAt,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      timeLimit: timeLimit ?? this.timeLimit,
      questions: questions ?? this.questions,
      createdAt: DateTime.now(),
      //updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}