import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/data/model/sources_response.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/news/news_list/news_list.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/news/news_tab_view_model.dart';
import 'package:news_sun_c9/ui/widgets/error_view.dart';
import 'package:news_sun_c9/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatefulWidget {
  final String categoryId;
  NewsTab(this.categoryId);
  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;
  NewsTabViewModel viewModel = NewsTabViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getSources(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (_) {
          print("Creating provider");
          return viewModel;
        },
        child: Consumer<NewsTabViewModel>(
          builder: (context, viewModel, _){
            Widget currentView;
            if(viewModel.isLoading){
              currentView = LoadingWidget();
            }
            else if(viewModel.sources.isNotEmpty){
              currentView = buildTabs(viewModel.sources);
            }else {
              currentView = ErrorView(message: viewModel.errorText??"");
            }
            return currentView;
          },
        ),
    );
  }

  Widget buildTabs(List<Source> list) {
    return DefaultTabController(
      length: list.length,
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              onTap: (index) {
                currentTabIndex = index;
                setState(() {});
              },
              tabs: list
                  .map((source) => buildTabWidget(source.name ?? "",
                      currentTabIndex == list.indexOf(source)))
                  .toList()),
          Expanded(
            child: TabBarView(
                children: list
                    .map((source) => NewsList(sourceId: source.id!))
                    .toList()),
          )
        ],
      ),
    );
  }

  Widget buildTabWidget(String name, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.blue)),
      child: Text(
        name,
        style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
      ),
    );
  }
}