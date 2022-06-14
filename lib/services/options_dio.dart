import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../providers/enviroment.dart';
import '../utils/validators.dart';

Future<Dio> optionsDio({login = false}) async {
  Dio dio = Dio();
  var token = "";
  if (await Validators().isTokenExist()) {
    token = (!login) ? await Validators().getToken() : "";
  }

  String url = Enviroment.apiUrl;

  dio.options = BaseOptions(
      baseUrl: url,
      headers: (!login) ? {"X-TOKEN": token} : {},
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000);

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return dio;
}
