import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/api/api_manager.dart';
import 'package:news_sun_c9/ui/screens/home/home_screen.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/news/news_tab_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName: (_) => HomeScreen()
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
///
/// View Vm Model
/// View Controller Model
/// View Presenter Model