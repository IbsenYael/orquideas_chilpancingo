import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';

class PrimaryButton extends StatelessWidget {
  final String textdescription;
  final double height;
  final double width;
  final Function() onpress;

  // ignore: prefer_const_constructors_in_immutables
  PrimaryButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.textdescription,
      required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 4.0,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Center(
            child: Texto(
                texto: textdescription,
                size: 14,
                font: FontWeight.bold,
                color: Colors.white,
                height: 15,
                widht: 200,
                minFont: 14,
                maxFont: 14,
                maxLines: 1,
                textAling: TextAlign.center),
          ),
        ),
        onTap: () {
          onpress();
        },
      ),
    );
  }
}
