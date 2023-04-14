
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

textStyle(double size,[ Color ? clr, FontWeight ? fw ]){
  return GoogleFonts.roboto(
    fontSize: size,
    fontWeight: fw,
    color: clr,
  );
}