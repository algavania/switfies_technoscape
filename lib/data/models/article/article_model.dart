class ArticleModel {
  final String title, thumbnailUrl, content;
  final int readingInMinutes;
  final DateTime createdAt;

  ArticleModel({
      required this.title,
      required this.thumbnailUrl,
      required this.content,
      required this.readingInMinutes,
      required this.createdAt
  });
}