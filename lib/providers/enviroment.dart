import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String get fileName {
    return '.env';
  }

  static String get apiUrl {
    String? url = dotenv.env['API_URL'];

    return url as String;
  }
}
