import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTexStyle({
  double size = 14,
  Color color = Colors.black,
  FontWeight weight = FontWeight.normal,
}) {
  return GoogleFonts.raleway(fontSize: size, fontWeight: weight, color: color);
}
