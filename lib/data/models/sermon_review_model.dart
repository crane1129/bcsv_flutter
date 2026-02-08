import 'package:bcsv_flutter_project/domain/entities/sermon_review.dart';

/// Data model for Sermon Review
class SermonReviewModel extends SermonReviewEntity {
  const SermonReviewModel({
    required super.date,
    required super.title,
    required super.chapter,
    required super.review,
    required super.application,
    required super.inDepth,
  });

  /// Create from JSON (from Google Docs API response)
  factory SermonReviewModel.fromJson(Map<String, dynamic> json) {
    return SermonReviewModel(
      date: json['date'] ?? '',
      title: json['title'] ?? '',
      chapter: json['chapter'] ?? '',
      review: json['review'] ?? '',
      application: json['application'] ?? '',
      inDepth: json['in_depth'] ?? '',
    );
  }

  /// Convert to JSON (for caching)
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'chapter': chapter,
      'review': review,
      'application': application,
      'in_depth': inDepth,
    };
  }

  /// Convert to domain entity
  SermonReviewEntity toEntity() {
    return SermonReviewEntity(
      date: date,
      title: title,
      chapter: chapter,
      review: review,
      application: application,
      inDepth: inDepth,
    );
  }

  /// Create from domain entity
  factory SermonReviewModel.fromEntity(SermonReviewEntity entity) {
    return SermonReviewModel(
      date: entity.date,
      title: entity.title,
      chapter: entity.chapter,
      review: entity.review,
      application: entity.application,
      inDepth: entity.inDepth,
    );
  }
}
