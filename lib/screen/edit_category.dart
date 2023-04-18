import 'package:admin_app_ecommerce/model/category_model.dart';
import 'package:flutter/material.dart';

class EditCategoryPage extends StatefulWidget {
  EditCategoryPage({Key? key,this.categoryModel}) : super(key: key);
  CategoryModel ? categoryModel;
  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
