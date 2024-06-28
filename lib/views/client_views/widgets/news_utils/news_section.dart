import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/service/news/news_model.dart';
import 'package:my_mcms/service/news/news_service.dart';
import 'package:my_mcms/utils/message_widget/loader.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/views/client_views/widgets/news_utils/news_articles_card.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  late String _newsApiKey;
  late NewsService _newsService;
  late Future<NewsModel> _news;

  @override
  void initState() {
    super.initState();
    _newsApiKey = dotenv.env['NEWS_API_KEY'] ?? '';
    _newsService = NewsService(apiKey: _newsApiKey);
    _news = _fetchNews();
  }

  Future<NewsModel> _fetchNews() async {
    try {
      return _newsService.getNews();
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }

  void _refreshNews() {
    setState(() {
      _news = _fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _news,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Error fetching news data"),
          );
        }

        if (!snapshot.hasData || snapshot.data?.articles == null) {
          return const Center(
            child: Text("No news data available"),
          );
        }

        final articlesList = snapshot.data!.articles;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleText(
                    data: "Latest News",
                  ),
                  IconButton(
                    onPressed: _refreshNews,
                    icon: const Icon(Icons.refresh),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8.0, left: 8.0),
              child: Divider(
                height: 0,
                thickness: 3,
                color: ColorPalette.background,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                itemCount: articlesList.length,
                itemBuilder: (context, index) {
                  final article = articlesList[index];
                  return NewsArticlesCards(article: article);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
