import 'dart:async';

import 'package:coinone/models/coinone_data.dart';

import 'data_provider.dart';

class Repository {
  final dataApiProvider = DataApiProvider();

  Future<Coinone> fetchData() => dataApiProvider.fetchDataList();
}