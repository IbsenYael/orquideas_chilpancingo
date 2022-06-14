import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Texto extends StatelessWidget {
  final String texto;
  final Color color;
  final double size;
  final FontWeight font;
  final TextAlign textAling;
  final double widht;
  final double height;
  final int maxLines;
  final double minFont;
  final double maxFont;

  // ignore: prefer_const_constructors_in_immutables
  Texto({
    Key? key,
    required this.texto,
    this.color = Colors.black,
    required this.size,
    this.font = FontWeight.normal,
    this.textAling = TextAlign.justify,
    required this.height,
    required this.widht,
    required this.maxLines,
    required this.minFont,
    required this.maxFont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        width: widht,
        height: height,
        child: AutoSizeText(
          texto,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: font,
            fontFamily: "Gill Sans",
          ),
          textAlign: textAling,
          minFontSize: minFont,
          maxLines: maxLines,
          maxFontSize: maxFont,
          overflow: TextOverflow.ellipsis,
        ));
  }
}
