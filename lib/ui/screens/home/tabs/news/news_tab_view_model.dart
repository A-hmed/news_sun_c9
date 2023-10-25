import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/repos/news_repo/data_sources/offline_data_source.dart';
import 'package:news_sun_c9/data/repos/news_repo/data_sources/online_data_source.dart';
import 'package:news_sun_c9/data/model/sources_response.dart';
import 'package:news_sun_c9/data/repos/news_repo/news_repo.dart';

class NewsTabViewModel extends ChangeNotifier{
  List<Source> sources = [];
  bool isLoading = false;
  String? errorText;
  NewsRepo newsRepo = NewsRepo(OnlineDataSource(), OfflineDataSource());

  void getSources(String categoryId) async {
    /// loading
    isLoading = true;
    notifyListeners();
    try{
      SourcesResponse? sourcesResponse = await newsRepo.getSources(categoryId);
      if(sourcesResponse != null && sourcesResponse.sources?.isNotEmpty == true){
        print("Sources: $sources");
        isLoading = false;
        sources = sourcesResponse.sources!;
        notifyListeners();
      }else {
        throw "Something went wrong please try again later";
      }
    }catch(error){
      isLoading = false;
      errorText = error.toString();
      notifyListeners();
    }
   }
}