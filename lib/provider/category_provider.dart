

import 'package:admin_app_ecommerce/custome_http/custome_http_request.dart';
import 'package:flutter/cupertino.dart';

import '../model/category_model.dart';

class CategoryProvider with ChangeNotifier{

  List <CategoryModel> categoryList=[];

  getCategoryData()async{
    //isLoading = true;
    categoryList = await CustomHttpRequest.getCategories();
    //isLoading = false;
    notifyListeners();
  }
}