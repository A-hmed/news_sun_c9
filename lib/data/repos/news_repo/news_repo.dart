import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_sun_c9/data/model/sources_response.dart';
import 'package:news_sun_c9/data/repos/news_repo/data_sources/offline_data_source.dart';
import 'package:news_sun_c9/data/repos/news_repo/data_sources/online_data_source.dart';

class NewsRepo {
  OfflineDataSource offlineDataSource;
  OnlineDataSource onlineDataSource;

  NewsRepo(this.onlineDataSource, this.offlineDataSource);

  Future<SourcesResponse?> getSources(String categoryId) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      SourcesResponse response = await onlineDataSource.getSources(categoryId);
      offlineDataSource.saveSources(response, categoryId);
      return response;
    } else {
      return await offlineDataSource.getSources(categoryId);
    }
  }
}
