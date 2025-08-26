import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle poppins({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
}) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
  );
}
