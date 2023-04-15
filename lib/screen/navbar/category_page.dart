import 'dart:convert';

import 'package:admin_app_ecommerce/custome_http/custome_http_request.dart';
import 'package:admin_app_ecommerce/screen/login_page.dart';
import 'package:flutter/material.dart';

import '../../model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  CategoryModel ? categorymodel;
  List<CategoryModel> categoryList=[];

  getCategories()async{
    try{
      var url = "${baseUrl}category";
      var responce = await http.get(Uri.parse(url),headers: await CustomHttpRequest.getHeaderWithToken());
      print('Api heat ${responce.body}');
      if(responce.statusCode==200){
        var data = jsonDecode(responce.body);
        print("data are ${data}");
        for(var i in data){
          categorymodel = CategoryModel.fromJson(i);
          setState(() {
            categoryList.add(categorymodel!);
          });
        }
      }
    }catch(e){
      print("Something wrong $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CategoryPage"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Categories")
          ],
        ),
      ),
    );
  }
}
