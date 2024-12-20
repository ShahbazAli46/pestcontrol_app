
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accurate/utils/appColors.dart';
class AppTextLabels {
  static Widget boldText({
    required String label,
    required Color color,
    required double fontSize,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
              ),
            ),
            softWrap: softWrap,
            overflow: overflow,
            maxLines: maxLines,
            textAlign: textAlign,
          ),
        ),
      ],
    );
  }


  static Widget boldTextShort({
    required String label,
    Color color = const Color(0xff333232),
    required double fontSize,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      label,
      style: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
        ),
      ),
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }

  // static Widget regularText({
  //   required String label,
  //   required Color color,
  //   double fontSize = 14,
  //   bool softWrap = true,
  //   TextOverflow overflow = TextOverflow.clip,
  //   int? maxLines,
  //   TextAlign textAlign = TextAlign.start,
  // }) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Text(
  //           label,
  //           style: GoogleFonts.manrope(
  //             textStyle: TextStyle(
  //               color: color,
  //               fontSize: fontSize,
  //             ),
  //           ),
  //           softWrap: softWrap,
  //           overflow: overflow,
  //           maxLines: maxLines,
  //           textAlign: textAlign,
  //         ),
  //       ),
  //     ],
  //   );
  // }


  static Widget regularShortText({
    required String label,
    required Color color,
    double fontSize = 14,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      label,
      style: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600
        ),
      ),
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }


  static Widget underlinedTextShort({
    required String label,
    required Color color,
    double fontSize = 14,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      label,
      style: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          decoration: TextDecoration.underline,
        ),
      ),
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }


  static Widget underlinedText({
    required String label,
    required Color color,
    double fontSize = 14,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Expanded(
      child: Text(
        label,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(
            color: color,
            fontSize: fontSize,
            decoration: TextDecoration.underline,
          ),
        ),
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }

  static Widget regularText({
    required String label,
    required Color color,
    double fontSize = 14,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.visible,
    int? maxLines,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Expanded(
      child: Text(
        label,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(
            color: color,
            fontSize: fontSize,
          ),
        ),
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
