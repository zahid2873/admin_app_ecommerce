
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

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
