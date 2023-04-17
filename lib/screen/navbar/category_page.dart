import 'dart:convert';

import 'package:admin_app_ecommerce/custome_http/custome_http_request.dart';
import 'package:admin_app_ecommerce/provider/category_provider.dart';
import 'package:admin_app_ecommerce/screen/login_page.dart';
import 'package:admin_app_ecommerce/widget/custome_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {


  // bool isLoading = false;
  // fetchData(){
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Provider.of<CategoryProvider>(context,listen: false).getCategoryData();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    //fetchData();
    Provider.of<CategoryProvider>(context,listen: false).getCategoryData();
    //getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var category = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("CategoryPage"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text("Categories"),
              SizedBox(height: 20,),
              category.categoryList.isNotEmpty? ListView.builder(
                itemCount: category.categoryList.length,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (contex,index){
                return Container(
                  height: 200,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomRight,
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: NetworkImage("${imgBaseUrl}${category.categoryList[index].image}"),fit: BoxFit.cover)
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage("${imgBaseUrl}${category.categoryList[index].icon}"),
                        ),

                      ),
                      Text("${category.categoryList[index].name}",style: textStyle(24,Colors.black,FontWeight.bold),),
                    ],
                  ),
                );
              }):Center(
                child: CircularProgressIndicator(),)
          ]
          )
    ),
      )
            );
  }
}