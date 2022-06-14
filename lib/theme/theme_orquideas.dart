import 'package:flutter/material.dart';

ThemeData orquideasChilpoTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: const Color(0xff97C4B8),
    backgroundColor: const Color(0xffF8F8F8),
    cardColor: const Color(0xffF6A5B8).withOpacity(0.7),
    hintColor: const Color(0xffF7BECB),
    indicatorColor: const Color(0xffFF8DE9),
    bottomAppBarColor: const Color(0xffFFFFFF),
    errorColor: const Color.fromARGB(239, 229, 106, 106),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xff707070), primary: const Color(0xFFF4E5E5)),
  );
}
