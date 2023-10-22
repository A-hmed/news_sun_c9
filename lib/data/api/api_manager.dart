import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_sun_c9/data/model/articles_response.dart';
import 'package:news_sun_c9/data/model/sources_response.dart';

abstract class ApiManager {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "a2803275cc264f5ab82151862011361a";
  static const String sourcesEndPoint = "/v2/top-headlines/sources";
  static const String articlesEndPoint = "/v2/everything";

  static Future<List<Source>> getSources(String category) async {
    Uri url = Uri.parse("https://$baseUrl$sourcesEndPoint?apiKey=$apiKey&category=$category");
    Response response = await get(url);
    Map json = jsonDecode(response.body);
    //print(json);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);

    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        sourcesResponse.sources?.isNotEmpty == true) {
      return sourcesResponse.sources!;
    }
    throw Exception(sourcesResponse.message);
  }

  static Future<List<Article>> getArticles(String sourceId) async {
    Uri url = Uri.https(
        baseUrl, articlesEndPoint, {"apiKey": apiKey, "sources": sourceId});
    var serverResponse = await get(url);
    Map json = jsonDecode(serverResponse.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
    if (serverResponse.statusCode >= 200 &&
        serverResponse.statusCode < 300 &&
        articlesResponse.articles?.isNotEmpty == true) {
      return articlesResponse.articles!;
    }
    throw Exception("Something went wrong please try again later!");
  }
}
