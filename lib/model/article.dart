part of 'model.dart';

class Article extends Equatable {
  final int? id;
  final String? title;
  final String? slug;
  final String? content;
  final String? imageUrl;
  final int? viewsCount;
  final DateTime? createdAt;

  const Article({
    this.id,
    this.title,
    this.slug,
    this.content,
    this.imageUrl,
    this.viewsCount,
    this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'] as int?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        content: json['content'] as String?,
        imageUrl: json['image_url'] as String?,
        viewsCount: json['views_count'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'slug': slug,
        'content': content,
        'image_url': imageUrl,
        'views_count': viewsCount,
        'created_at': createdAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      slug,
      content,
      imageUrl,
      viewsCount,
      createdAt,
    ];
  }
}
