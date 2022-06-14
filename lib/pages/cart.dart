import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:orquideas_chilpancingo/utils/storage/storage.dart';
import 'package:orquideas_chilpancingo/widgets/cards/card_cart.dart';
import 'package:orquideas_chilpancingo/widgets/cards/card_payment.dart';
import 'package:orquideas_chilpancingo/widgets/listvacias/list_vacia.dart';
import 'package:provider/provider.dart';

import '../providers/badge_provider.dart';
import '../providers/carrito_provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int cantidad = 0;
  double pagototal = 0.00;

  callback() async {
    List<Map> badge = await StorageTables().getTotalCart();
    Provider.of<BadgeProvider>(context, listen: false).carBadge =
        badge[0]["total"] ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageTables().getCart(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<dynamic> orquideasCart = snapshot.data;
          cantidad =
              Provider.of<CarritoProvider>(context, listen: false).cantidad;
          pagototal =
              Provider.of<CarritoProvider>(context, listen: false).totalpago;

          return (orquideasCart.isNotEmpty)
              ? Stack(
                  children: [
                    SlidableAutoCloseBehavior(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: orquideasCart.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 20,
                                ),
                                CardCart(
                                    orquidea: orquideasCart[index],
                                    callbackFunction: callback),
                              ],
                            );
                          }),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: TotalCard(
                          cantidad: cantidad,
                          totalpago: pagototal,
                        ))
                  ],
                )
              : const ListVacia(
                  icon: Icons.shopping_bag,
                  text: "Agrega productos a tu carrito");
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
