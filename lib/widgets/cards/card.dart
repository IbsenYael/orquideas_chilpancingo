import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orquideas_chilpancingo/pages/detail.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';

class CardDesing extends StatelessWidget {
  final Map<String, dynamic> orquidea;
  const CardDesing({
    Key? key,
    required this.orquidea,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            width: 187,
            height: 173,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Texto(
                          texto: orquidea["name"],
                          size: 14,
                          font: FontWeight.w700,
                          height: 15,
                          widht: 200,
                          minFont: 14,
                          maxFont: 14,
                          maxLines: 1),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Texto(
                          texto: orquidea["description"],
                          size: 13,
                          font: FontWeight.w700,
                          color: Theme.of(context).colorScheme.secondary,
                          textAling: TextAlign.left,
                          height: 14,
                          widht: 120,
                          minFont: 13,
                          maxFont: 13,
                          maxLines: 1),
                    ),
                    const Padding(padding: EdgeInsets.all(2)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Texto(
                              texto: "\$${orquidea["price"]}",
                              size: 14,
                              font: FontWeight.w900,
                              color: Theme.of(context).colorScheme.secondary,
                              textAling: TextAlign.left,
                              height: 15,
                              widht: 120,
                              minFont: 14,
                              maxFont: 14,
                              maxLines: 1),
                        ),
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
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                  ]),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 70,
            child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.all(10),
                width: 87,
                height: 160,
                child: Image.asset(orquidea["images"][0])),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailOrquidea(
                detail: orquidea,
              ),
            ));
      },
    );
  }
}
