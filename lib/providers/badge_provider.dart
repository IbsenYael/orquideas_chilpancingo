import 'package:flutter/material.dart';

class BadgeProvider with ChangeNotifier {
  int _carBadge = 0;

  int get carBadge => _carBadge;

  set carBadge(int val) {
    _carBadge = val;
    notifyListeners();
  }
}
