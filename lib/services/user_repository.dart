import 'dart:convert';
import 'package:dio/dio.dart';

import 'api_routes.dart';
import 'options_dio.dart';

class UserRepository {
  late Dio dio;

  signIn(data) async {
    dio = await optionsDio(login: true);
    return await dio.post(Api().login, data: jsonEncode(data));
  }

  newUser(data) async {
    dio = await optionsDio(login: true);
    return await dio.post(Api().newuser, data: jsonEncode(data));
  }

  signOut() async {
    dio = await optionsDio();
    return await dio.post(Api().logout);
  }
}
