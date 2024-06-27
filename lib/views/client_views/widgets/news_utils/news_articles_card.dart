import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/service/news/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticlesCards extends StatelessWidget {
  const NewsArticlesCards({
    super.key,
    required this.article,
  });

  final Articles article;

  Future<void> _launchUrl(String url) async {
    final articleUrl = Uri.parse(url);
    if (!await launchUrl(articleUrl)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.imageUrl;
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () => _launchUrl(article.url),
        leading: CachedNetworkImage(
          width: 100,
          height: 50,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              Image.asset("assets/images/image_placeholder.png"),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/image_placeholder.png"),
        ),
        title: Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          article.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
