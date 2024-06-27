class NewsModel {
  int totalArticles;
  List<Articles> articles;

  NewsModel({required this.totalArticles, required this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      totalArticles: json['totalArticles'],
      articles: List<Articles>.from(
        json['articles'].map(
          (article) => Articles.fromJson(article),
        ),
      ),
    );
  }
}

class Articles {
  String title;
  String description;
  String content;
  String url;
  String imageUrl;
  String publishedAt;
  Source source;

  Articles({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      title: json['title'],
      description: json['description'],
      content: json['content'],
      url: json['url'],
      imageUrl: json["image"],
      publishedAt: json['publishedAt'],
      source: Source.fromJson(json['source']),
    );
  }
}

class Source {
  String name;
  String url;

  Source({required this.name, required this.url});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'],
      url: json['url'],
    );
  }
}
