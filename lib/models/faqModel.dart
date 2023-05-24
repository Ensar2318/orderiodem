// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

List<FaqModel> faqModelFromJson(String str) => List<FaqModel>.from(json.decode(str).map((x) => FaqModel.fromJson(x)));

String faqModelToJson(List<FaqModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqModel {
  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String question;
  String answer;
  DateTime updatedAt;
  DateTime createdAt;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}
