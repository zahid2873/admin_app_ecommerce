
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


String baseUrl = "http://temp.techsolutions-bd.com/api/admin/";
String imgBaseUrl = "http://temp.techsolutions-bd.com/images/";

textStyle(double size,[ Color ? clr, FontWeight ? fw ]){
  return GoogleFonts.roboto(
    fontSize: size,
    fontWeight: fw,
    color: clr,
  );
}

final spinkit = SpinKitFadingFour(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);

showInToast(String text){
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
