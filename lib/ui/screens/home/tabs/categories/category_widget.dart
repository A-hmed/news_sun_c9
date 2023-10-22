import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/model/category_dm.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryDM categoryDM;
  final Radius radius = const Radius.circular(16);

  const CategoryWidget({super.key, required this.categoryDM});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: categoryDM.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: radius,
              topRight: radius,
              bottomLeft: categoryDM.isLeftSided ? Radius.zero : radius,
              bottomRight: !categoryDM.isLeftSided ? Radius.zero : radius)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(categoryDM.imagePath, height: MediaQuery.of(context).size.height * .14,),
          SizedBox(height: 4,),
          Text(categoryDM.title, style: TextStyle(color: Colors.white, fontSize: 18),),

        ],
      ),
    );
  }
}
