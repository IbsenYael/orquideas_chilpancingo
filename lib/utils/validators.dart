import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class Validators {
  final storage = const FlutterSecureStorage();
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final _format = NumberFormat("#,##0.00", "en_US");

  String formatoDinero(double value) {
    if (value.isNaN) {
      return _format.format(0.00);
    } else {
      return _format.format(value);
    }
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  Future<void> savePreferencesAuth(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<bool> isTokenExist() async {
    bool _validate = false;
    if (await storage.read(key: "token") != null) {
      _validate = true;
    }
    return _validate;
  }

  Future<String> getToken() async {
    String token = await storage.read(key: "token") as String;
    return token;
  }

  Future<void> delteStorageToken() async {
    await storage.deleteAll();
  }
}
