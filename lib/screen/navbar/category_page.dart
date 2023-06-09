import 'dart:convert';

import 'package:admin_app_ecommerce/custome_http/custome_http_request.dart';
import 'package:admin_app_ecommerce/provider/category_provider.dart';
import 'package:admin_app_ecommerce/screen/add_category.dart';
import 'package:admin_app_ecommerce/screen/edit_category.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategory()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("CategoryPage"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
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
                    height: 220,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.withOpacity(.3),
                                child: IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>EditCategoryPage(categoryModel: category.categoryList[index],))).then((value){
                                    Provider.of<CategoryProvider>(context,listen: false).getCategoryData();
                                  });
                                }, icon: Icon(Icons.edit,color: Colors.green,))),
                              CircleAvatar(child: IconButton(onPressed: (){
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Are you sure?"),
                                    content: Text("You want delete data"),
                                    actions: [
                                      TextButton(onPressed: ()async{
                                        bool isDelete= await CustomHttpRequest.deleteCategoryData(category.categoryList[index].id);
                                        print("IS delete value is $isDelete");
                                        Navigator.pop(context);
                                        if(isDelete==true){
                                          showInToast("Category Delete is successful");
                                          setState(() {
                                            category.categoryList.removeAt(index);
                                          });
                                        }else{
                                          showInToast("Category not delete, please try again");
                                        }
                                      }, child: Text("Delete")),
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text("Cancel")),
                                    ],
                                  );
                                });
                              }, icon: Icon(Icons.delete,color: Colors.red,)))
                          ],),
                        )
                      ],
                    ),
                  );
                }):Center(
                 child: CircularProgressIndicator(),)
            ]
            ),
          )
    ),
      )
    );
  }


}