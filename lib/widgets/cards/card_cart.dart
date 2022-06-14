import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orquideas_chilpancingo/utils/storage/storage.dart';
import 'package:orquideas_chilpancingo/utils/validators.dart';

import '../text/texto.dart';

class CardCart extends StatelessWidget {
  final Map orquidea;
  final Function() callbackFunction;
  const CardCart(
      {Key? key, required this.orquidea, required this.callbackFunction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String id = orquidea["id"];
    String name = orquidea["name"];
    int cantidad = orquidea["cantidad"];
    double total = orquidea["price"];
    String image = orquidea["image"];

    String formatMoney = Validators().formatoDinero(total);
    return Slidable(
      groupTag: '0',
      endActionPane: ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          backgroundColor: Theme.of(context).errorColor,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: "Eliminar",
          onPressed: (BuildContext context) {
            StorageTables().deleteproductCart(id);
            callbackFunction();
          },
        ),
        SlidableAction(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          icon: FontAwesomeIcons.heart,
          label: "Wishlist",
          onPressed: (BuildContext context) {},
        )
      ]),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 169,
        width: 394,
        color: Theme.of(context).backgroundColor,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Texto(
                          texto: name,
                          size: 14,
                          font: FontWeight.w700,
                          height: 15,
                          widht: 200,
                          minFont: 14,
                          maxFont: 14,
                          maxLines: 1),
                      Texto(
                          texto: "Cantidad: $cantidad pz",
                          size: 14,
                          font: FontWeight.w700,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(.50),
                          height: 15,
                          widht: 150,
                          minFont: 14,
                          maxFont: 14,
                          maxLines: 1)
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Texto(
                    texto: "\$ $formatMoney",
                    size: 16,
                    font: FontWeight.w700,
                    height: 17,
                    widht: 120,
                    minFont: 16,
                    maxFont: 16,
                    maxLines: 1,
                    textAling: TextAlign.center),
              ),
            ),
            Positioned(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 87,
                  height: 160,
                  child: Image.asset(image)),
            )
          ],
        ),
      ),
    );
  }
}
