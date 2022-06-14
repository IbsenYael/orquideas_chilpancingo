import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';

class ListVacia extends StatelessWidget {
  final IconData icon;
  final String text;
  const ListVacia({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(
            icon,
            size: 70,
            color: Colors.black.withOpacity(0.6),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Texto(
              texto: text,
              size: 16,
              height: 17,
              widht: 300,
              maxLines: 1,
              minFont: 16,
              maxFont: 16,
              color: Colors.black.withOpacity(0.6),
              textAling: TextAlign.center,
            ),
          )
        ]));
  }
}
