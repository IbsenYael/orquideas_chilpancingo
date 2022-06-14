import 'package:dio/dio.dart';
import 'package:orquideas_chilpancingo/services/api_routes.dart';
import 'package:orquideas_chilpancingo/services/options_dio.dart';

class ApiRquests {
  late Dio dio;

  getPlants({int page = 1}) async {
    dio = await optionsDio(login: true);
    return await dio.get(Api().getplants + "page=$page");
  }

  searchPlants({String busqueda = ""}) async {
    dio = await optionsDio();
    return await dio.get(Api().getplants + "search=$busqueda");
  }
}
