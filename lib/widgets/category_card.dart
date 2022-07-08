import 'package:finder_app/data/categories.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category? category;

  CategoryCard(Category categoryContainer, {this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(right: 50),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.lightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(category!.categoryName),
      ),
    );
  }
}
