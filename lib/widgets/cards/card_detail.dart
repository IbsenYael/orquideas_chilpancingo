import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../text/texto.dart';

class CardDetail extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  const CardDetail(
      {Key? key,
      required this.name,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: <Widget>[
      Container(
        width: 394,
        height: 173,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Texto(
                    texto: name,
                    size: 14,
                    font: FontWeight.w700,
                    height: 15,
                    widht: 200,
                    minFont: 14,
                    maxFont: 14,
                    maxLines: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Texto(
                          texto: description,
                          size: 13,
                          font: FontWeight.w700,
                          color: Theme.of(context).colorScheme.secondary,
                          textAling: TextAlign.left,
                          height: 14,
                          widht: 150,
                          minFont: 13,
                          maxFont: 13,
                          maxLines: 1)),
                  GestureDetector(
                    child: const Icon(
                      FontAwesomeIcons.heart,
                      color: Colors.white,
                    ),
                    onTap: () {
                      print("Favoritos");
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      Positioned(
        left: 160,
        bottom: 70,
        child: Container(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.all(10),
            width: 97,
            height: 170,
            child: Image.asset(image)),
      ),
    ]);
  }
}
