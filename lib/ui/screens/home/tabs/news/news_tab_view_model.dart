import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/data/model/sources_response.dart';

class NewsTabViewModel extends ChangeNotifier{
  List<Source> sources = [];
  bool isLoading = false;
  String? errorText;

  void getSources(String categoryId) async {
    /// loading
    isLoading = true;
    notifyListeners();
    try{
      sources = await ApiManager.getSources(categoryId);
      print("Sources: $sources");
      isLoading = false;
      notifyListeners();
    }catch(error){
      isLoading = false;
      errorText = error.toString();
      notifyListeners();
    }
   }
}