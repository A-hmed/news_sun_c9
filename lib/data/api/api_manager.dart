import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_sun_c9/data/model/sources_response.dart';

abstract class ApiManager {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "a2803275cc264f5ab82151862011361a";
  static const String sourcesEndPoint = "/v2/top-headlines/sources";

  static Future<List<Source>> getSources() async {

    Uri url = Uri.parse("https://${baseUrl}$sourcesEndPoint?apiKey=$apiKey");
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

  static getArticles() {}
}
