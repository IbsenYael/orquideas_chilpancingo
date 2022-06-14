import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/services/api_requests.dart';

class OrquideasProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _orquideas = [];

  int _totalDocs = 0;

  List<Map<String, dynamic>> get orquideas => _orquideas;
  int get totaldocs => _totalDocs;

  set orquideas(List<Map<String, dynamic>> value) {
    _orquideas = value;
    notifyListeners();
  }

  set totaldocs(int value) {
    _totalDocs = value;
    notifyListeners();
  }

  Future<void> getOrquideas(BuildContext context, int pageKey) async {
    _orquideas = [];
    Response data = await ApiRquests().getPlants(page: pageKey);
    Map<String, dynamic> response = Map<String, dynamic>.from(data.data);

    (_totalDocs == 0) ? _totalDocs = response['plants']['totalDocs'] : () {};
    for (var item in response['plants']['docs']) {
      _orquideas.add(item);
    }
  }

  // Future<void> getFilterOrquideas(BuildContext context, String busqueda) async {
  //   try {
  //     Response data = await ApiRquests().searchPlants(busqueda: busqueda);
  //     Map<String, dynamic> response = Map<String, dynamic>.from(data.data);
  //   } on DioError catch (e) {
  //     handleError(e, context);
  //   }
  // }
}
