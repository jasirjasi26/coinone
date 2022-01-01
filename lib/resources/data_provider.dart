import 'dart:async';
import 'package:coinone/models/coinone_data.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' show Client;
import 'dart:convert';

class DataApiProvider {
  Client client = Client();
  final _api = 'https://api.mocklets.com/p68289/screentime';

  Future<Coinone> fetchDataList() async {
    final response = await client.get(Uri.parse(_api));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      List jsonResponse = json.decode(response.body);
      // If the call to the server was successful, parse the JSON
      return Coinone.fromJson(jsonResponse[0]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
