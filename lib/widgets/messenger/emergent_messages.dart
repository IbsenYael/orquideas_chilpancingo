import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';

void successMessage(
    {required BuildContext context, required String text, bool error = false}) {
  final Color color =
      (error) ? Theme.of(context).indicatorColor : Theme.of(context).errorColor;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      content: Container(
          padding: const EdgeInsets.all(5),
          height: 25,
          width: 300,
          child: Texto(
            texto: text,
            size: 14,
            color: color,
            height: 15,
            widht: 100,
            minFont: 14,
            maxFont: 14,
            maxLines: 1,
          ))));
}

SnackBar load(BuildContext context, String texto) {
  return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(texto),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.0,
          )
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
      backgroundColor: Theme.of(context).primaryColorDark);
}
