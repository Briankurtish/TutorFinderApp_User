import 'package:finder_app/data/categories.dart';
import 'package:finder_app/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryCarousel extends StatelessWidget {
  final categoryContainer = Category.generateCategory();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryCard(
          categoryContainer[index],
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: 20,
        ),
        itemCount: categoryContainer.length,
      ),
    );
  }
}
