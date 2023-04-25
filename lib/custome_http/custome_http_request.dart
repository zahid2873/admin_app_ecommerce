

import 'dart:convert';

import 'package:admin_app_ecommerce/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/custome_widget.dart';
import 'package:http/http.dart' as http;

class CustomHttpRequest{

  static Future<Map<String,String>> getHeaderWithToken()async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header={
      "Accept" : "application/json",
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    };
    return header;
  }




  static Future<dynamic> getCategories()async{
    CategoryModel ? categorymodel;
    List<CategoryModel> categoryList=[];
    try{
      var url = "${baseUrl}category";
      var responce = await http.get(Uri.parse(url),headers: await CustomHttpRequest.getHeaderWithToken());
      print('Api heat ${responce.body}');
      if(responce.statusCode==200){
        var data = jsonDecode(responce.body);
        print("data are ${data}");
        for(var i in data){
          categorymodel = CategoryModel.fromJson(i);
            categoryList.add(categorymodel!);
            print(categoryList.length);
        }
      }
    }catch(e){
      print("Something wrong $e");
    }
    return categoryList;
  }

  static Future<bool> deleteCategoryData(int ? id)async{
    var uri = "${baseUrl}category/${id}/delete";
    var responce = await http.delete(Uri.parse(uri),headers: await getHeaderWithToken());
    final data = jsonDecode(responce.body);
    print("reponce data is $data");
    if(responce.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
}