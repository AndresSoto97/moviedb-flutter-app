import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';
  static String movieDbToken = dotenv.env['TOKEN_MOVIEDB'] ?? 'No hay TOKEN';
}
