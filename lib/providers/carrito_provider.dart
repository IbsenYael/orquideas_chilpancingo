import 'package:flutter/material.dart';

class CarritoProvider with ChangeNotifier {
  int _cantidad = 0;
  double _totalpago = 0;

  int get cantidad => _cantidad;
  double get totalpago => _totalpago;

  set cantidad(int value) {
    _cantidad = value;
    notifyListeners();
  }

  set totalpago(double value) {
    _totalpago = value;
    notifyListeners();
  }
}
