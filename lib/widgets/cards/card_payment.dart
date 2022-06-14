import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/utils/validators.dart';
import 'package:orquideas_chilpancingo/widgets/button/button.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';

class TotalCard extends StatelessWidget {
  final int cantidad;
  final double totalpago;
  const TotalCard({Key? key, required this.cantidad, required this.totalpago})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pago = Validators().formatoDinero(totalpago);
    return Container(
      margin: const EdgeInsets.all(10),
      width: 394,
      height: 165,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 4.0,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Texto(
                  texto: "Cantidad",
                  size: 14,
                  font: FontWeight.bold,
                  height: 15,
                  widht: 100,
                  minFont: 14,
                  maxFont: 14,
                  maxLines: 1),
              const SizedBox(
                width: 100,
              ),
              Texto(
                  texto: "$cantidad",
                  size: 14,
                  font: FontWeight.bold,
                  height: 15,
                  widht: 50,
                  minFont: 14,
                  maxFont: 14,
                  maxLines: 1)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: <Widget>[
              Texto(
                  texto: "Total",
                  size: 14,
                  font: FontWeight.bold,
                  height: 15,
                  widht: 40,
                  minFont: 14,
                  maxFont: 14,
                  maxLines: 1),
              const SizedBox(
                width: 5,
              ),
              Texto(
                  texto: "(IVA incluido)",
                  size: 14,
                  font: FontWeight.bold,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                  height: 15,
                  widht: 100,
                  minFont: 14,
                  maxFont: 14,
                  maxLines: 1),
              const SizedBox(
                width: 90,
              ),
              Expanded(
                child: Texto(
                    texto: "\$ $pago MXM",
                    size: 14,
                    font: FontWeight.bold,
                    height: 15,
                    widht: 50,
                    minFont: 14,
                    maxFont: 14,
                    maxLines: 1),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
          child: PrimaryButton(
              height: 36, width: 362, textdescription: "Pagar", onpress: () {}),
        )
      ]),
    );
  }
}
