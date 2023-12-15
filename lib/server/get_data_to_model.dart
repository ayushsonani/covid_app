import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/allapidata.dart';
import 'api_data.dart';

class ResponssGetApi {
  Future<Allapidata> get_all({required String url}) async {
    var respons = await http.get(Uri.parse(url));
    if (respons.statusCode == 200) {
      var data = jsonDecode(respons.body);
      return Allapidata.fromJson(data);
    } else {
      return Allapidata.fromJson([]);
      // throw Exception("not found data");
    }
  }
}
