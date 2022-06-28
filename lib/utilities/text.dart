import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const HeadingText(
      {Key? key, required this.text, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      softWrap: true,
      style: GoogleFonts.outfit(
        color: color,
        fontSize: size,
      ),
    );
  }
}
