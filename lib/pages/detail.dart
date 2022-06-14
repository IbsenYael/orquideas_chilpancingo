import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orquideas_chilpancingo/providers/badge_provider.dart';
import 'package:orquideas_chilpancingo/utils/storage/storage.dart';
import 'package:orquideas_chilpancingo/utils/validators.dart';
import 'package:orquideas_chilpancingo/widgets/button/button.dart';
import 'package:orquideas_chilpancingo/widgets/cards/card_detail.dart';
import 'package:orquideas_chilpancingo/widgets/messenger/emergent_messages.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';
import 'package:provider/provider.dart';

class DetailOrquidea extends StatefulWidget {
  final Map<String, dynamic> detail;
  const DetailOrquidea({Key? key, required this.detail}) : super(key: key);

  @override
  State<DetailOrquidea> createState() => _DetailOrquideaState();
}

class _DetailOrquideaState extends State<DetailOrquidea> {
  Map<String, dynamic> detail = {};

  @override
  void initState() {
    detail = widget.detail;
    super.initState();
  }

  int cantidad = 1;
  @override
  Widget build(BuildContext context) {
    String total =
        Validators().formatoDinero((cantidad * detail["price"]) as double);
    String id = detail["_id"];
    String name = detail["name"];
    String description = detail["description"];
    double price = detail["price"];
    String image = detail["images"][0];
    String flowerSize = detail["flower_size"];
    String color = detail["color"];
    String size = detail["size"];
    String type = detail["type"];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    )),
                CardDetail(
                  name: name,
                  description: description,
                  image: image,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 394,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 36,
                          width: 85,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Texto(
                              texto: "Cantidad",
                              size: 14,
                              font: FontWeight.bold,
                              height: 15,
                              widht: 80,
                              minFont: 14,
                              maxFont: 14,
                              maxLines: 1,
                              textAling: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            width: 281,
                            height: 36,
                            margin: const EdgeInsets.only(left: 20, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      cantidad++;
                                    });
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.plus,
                                    size: 15,
                                  ),
                                ),
                                Texto(
                                    texto: "$cantidad",
                                    size: 14,
                                    font: FontWeight.bold,
                                    height: 15,
                                    widht: 50,
                                    minFont: 14,
                                    maxFont: 14,
                                    maxLines: 1,
                                    textAling: TextAlign.center),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (cantidad > 1) cantidad--;
                                    });
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.minus,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Texto(
                        texto: "Detalles del Producto",
                        size: 14,
                        font: FontWeight.bold,
                        height: 15,
                        widht: 200,
                        minFont: 14,
                        maxFont: 14,
                        maxLines: 1,
                        textAling: TextAlign.center),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 223,
                    width: 394,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            const _DetailRow(
                                description: "Tamaño flor:", atributo: "color"),
                            _DetailRow(
                                description: flowerSize, atributo: color),
                            const SizedBox(
                              height: 30,
                            ),
                            const _DetailRow(
                                description: "Tamaño Maceta:",
                                atributo: "Tipo"),
                            _DetailRow(description: size, atributo: type),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Texto(
                          texto: "Total:",
                          size: 14,
                          font: FontWeight.bold,
                          height: 15,
                          widht: 50,
                          minFont: 14,
                          maxFont: 14,
                          maxLines: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Texto(
                          texto: "\$ $total",
                          size: 14,
                          font: FontWeight.bold,
                          height: 16,
                          widht: 90,
                          minFont: 14,
                          maxFont: 14,
                          maxLines: 1),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                PrimaryButton(
                  width: 394.00,
                  height: 36.00,
                  textdescription: "Agregar al carrito",
                  onpress: () {
                    var badgeAux =
                        Provider.of<BadgeProvider>(context, listen: false)
                            .carBadge;
                    badgeAux += cantidad;
                    Provider.of<BadgeProvider>(context, listen: false)
                        .carBadge = badgeAux;
                    StorageTables().insertCart(
                      id: id,
                      name: name,
                      description: description,
                      price: price * cantidad,
                      image: image,
                      color: color,
                      cantidad: cantidad,
                    );
                    successMessage(
                        context: context,
                        text: "Se han agregado al carrito tus Orquideas");
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String description;
  final String atributo;
  const _DetailRow(
      {Key? key, required this.description, required this.atributo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: const EdgeInsets.only(top: 25, left: 60),
            child: Texto(
                texto: description,
                size: 14,
                height: 15,
                widht: 120,
                minFont: 14,
                maxFont: 14,
                maxLines: 1,
                textAling: TextAlign.center)),
        Container(
            margin: const EdgeInsets.only(top: 25, right: 60),
            child: Texto(
                texto: atributo,
                size: 14,
                height: 15,
                widht: 100,
                minFont: 14,
                maxFont: 14,
                maxLines: 1,
                textAling: TextAlign.center)),
      ],
    );
  }
}
