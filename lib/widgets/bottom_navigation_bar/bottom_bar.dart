import 'dart:io';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:orquideas_chilpancingo/providers/badge_provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  final bool user;
  final bool home;
  final bool cart;
  final Function(bool home, bool user, bool cart) change;
  const BottomBar(
      {Key? key,
      required this.user,
      required this.home,
      required this.cart,
      required this.change})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late bool user;
  late bool home;
  late bool cart;
  @override
  void initState() {
    user = widget.user;
    home = widget.home;
    cart = widget.cart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int badge = Provider.of<BadgeProvider>(context).carBadge;
    Color selectColor = Theme.of(context).primaryColor;
    Color unselectColor = Theme.of(context).colorScheme.secondary;
    double sizeIcon = 35;
    double sizeselectedicon = 45;
    IconData userIcon = (user) ? Icons.person : Icons.person_outline;
    IconData homeIcon = (home) ? Icons.home : Icons.home_outlined;
    IconData cartIcon =
        (cart) ? Icons.shopping_cart : Icons.shopping_cart_outlined;
    double navigationbarHeight = (Platform.isIOS) ? 60 : 70;
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).bottomAppBarColor, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 4.0,
            offset: const Offset(0, 1))
      ]),
      height: MediaQuery.of(context).viewPadding.bottom + navigationbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  userIcon,
                  size: (user) ? sizeselectedicon : sizeIcon,
                ),
                color: (user) ? selectColor : unselectColor,
                onPressed: () {
                  widget.change(false, true, false);
                  user = true;
                  home = false;
                  cart = false;
                  setState(() {});
                },
              )),
          Container(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  homeIcon,
                  size: (home) ? sizeselectedicon : sizeIcon,
                ),
                color: (home) ? selectColor : unselectColor,
                onPressed: () {
                  widget.change(true, false, false);
                  user = false;
                  home = true;
                  cart = false;
                  setState(() {});
                },
              )),
          Container(
              margin: const EdgeInsets.all(10),
              child: Badge(
                alignment: Alignment.center,
                padding: EdgeInsets.all((cart) ? 7 : 9),
                badgeColor: Theme.of(context).indicatorColor,
                badgeContent: Text(
                  "$badge",
                  style: TextStyle(
                      fontSize: 9,
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    cartIcon,
                    size: (cart) ? 40 : 30,
                  ),
                  color: (cart) ? selectColor : unselectColor,
                  onPressed: () {
                    widget.change(false, false, true);
                    user = false;
                    home = false;
                    cart = true;
                    setState(() {});
                  },
                ),
              ))
        ],
      ),
    );
  }
}
