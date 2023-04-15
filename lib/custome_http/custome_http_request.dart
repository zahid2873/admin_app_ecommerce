

import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpRequest{

  static Future<Map<String,String>> getHeaderWithToken()async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header={
      "Accept" : "application/json",
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    };
    return header;
  }
}