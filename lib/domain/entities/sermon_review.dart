/// Domain entity for Sermon Review
class SermonReviewEntity {
  final String date;
  final String title;
  final String chapter;
  final String review;
  final String application;
  final String inDepth;

  const SermonReviewEntity({
    required this.date,
    required this.title,
    required this.chapter,
    required this.review,
    required this.application,
    required this.inDepth,
  });

  /// Check if this review has any content
  bool get hasContent =>
      title.isNotEmpty ||
      review.isNotEmpty ||
      application.isNotEmpty ||
      inDepth.isNotEmpty;

  /// Get header text for display
  String get headerText {
    if (title.isEmpty) return date;
    return '$date\n$title';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SermonReviewEntity &&
        other.date == date &&
        other.title == title &&
        other.chapter == chapter &&
        other.review == review &&
        other.application == application &&
        other.inDepth == inDepth;
  }

  @override
  int get hashCode =>
      date.hashCode ^
      title.hashCode ^
      chapter.hashCode ^
      review.hashCode ^
      application.hashCode ^
      inDepth.hashCode;
}
