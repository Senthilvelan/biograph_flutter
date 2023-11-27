
class HealthArticle {
  String? articleType;
  String? articleHeading;
  String? articleCreator;

  HealthArticle({
    this.articleType,
    this.articleHeading,
    this.articleCreator,
  });

  factory HealthArticle.fromJson(Map<dynamic, dynamic> jsonData) {
    return HealthArticle(
      articleType: jsonData['articleType'],
      articleHeading: jsonData['articleHeading'],
      articleCreator: jsonData['articleCreator'],
    );
  }
}
