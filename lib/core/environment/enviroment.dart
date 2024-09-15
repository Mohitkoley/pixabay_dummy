//get .env key value and that will be same throughtout the app

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String _apiKey = "";
  static get apiKey => _apiKey;

  static Future init() async {
    if (kIsWeb) {
      //get data from dart define
      _apiKey = const String.fromEnvironment('KEY');
    }
    //get api key from .env file
    else {
      await dotenv.load(fileName: ".env");
      var apiKey = dotenv.env['KEY'];
      if (apiKey != null) {
        _apiKey = apiKey;
      }
    }
  }
}
