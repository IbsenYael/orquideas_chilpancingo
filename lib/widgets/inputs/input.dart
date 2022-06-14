import 'package:flutter/material.dart';

class InputDesing extends StatelessWidget {
  final IconData icon;
  final String textdescription;
  final double height;
  final double width;
  final bool isSecret;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType type;
  final Widget suffixIcon;
  // ignore: prefer_const_constructors_in_immutables
  InputDesing(
      {Key? key,
      required this.icon,
      required this.textdescription,
      required this.height,
      required this.width,
      required this.readOnly,
      required this.controller,
      required this.type,
      this.suffixIcon = const SizedBox(),
      this.isSecret = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).indicatorColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          cursorHeight: 10,
          readOnly: readOnly,
          controller: controller,
          style: const TextStyle(fontSize: 11, fontFamily: "Gill Sans"),
          textAlignVertical: TextAlignVertical.top,
          autovalidateMode: AutovalidateMode.always,
          textAlign: TextAlign.start,
          cursorColor: Theme.of(context).colorScheme.secondary,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                icon,
                color: Theme.of(context).indicatorColor,
              ),
              suffixIcon: suffixIcon,
              labelText: textdescription,
              floatingLabelBehavior: FloatingLabelBehavior.auto),
          keyboardType: type,
          autocorrect: false,
          obscureText: isSecret,
        ),
      ),
    );
  }
}
