import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/repos/news_repo/data_sources/online_data_source.dart';
import 'package:news_sun_c9/data/model/articles_response.dart';
import 'package:news_sun_c9/ui/widgets/article_widget.dart';
import 'package:news_sun_c9/ui/widgets/error_view.dart';
import 'package:news_sun_c9/ui/widgets/loading_widget.dart';

class NewsList extends StatelessWidget {
  final String sourceId;
  const NewsList({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: OnlineDataSource().getArticles(sourceId),
        builder: (context, snapshot){
           if(snapshot.hasData){
             return buildArticlesListView(snapshot.data!);
           }else if(snapshot.hasError){
             return ErrorView(message: snapshot.error.toString());
           }else {
             return const LoadingWidget();
           }
        });
  }
  buildArticlesListView(List<Article> articles){
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index){
          return ArticleWidget(article: articles[index],);
        }
    );
  }
}
