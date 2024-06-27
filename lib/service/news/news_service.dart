import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_mcms/service/news/news_model.dart';

class NewsService {
  final baseUrl = "https://gnews.io/api/v4/search";
  final String apiKey;

  NewsService({required this.apiKey});

  Future<NewsModel> getNews() async {
    final url =
        Uri.parse("$baseUrl?q=example&lang=en&country=in&apikey=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewsModel.fromJson(data);
    } else {
      throw Exception("Error fetching news data: ${response.body}");
    }
  }
}
