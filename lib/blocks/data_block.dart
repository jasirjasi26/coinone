import 'package:coinone/models/coinone_data.dart';
import 'package:coinone/resources/data_repository.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _repository = Repository();
  final _dataFetcher = PublishSubject<Coinone>();

  Observable<Coinone> get allData => _dataFetcher.stream;

  fetchAllData() async {
    Coinone dataModel = await _repository.fetchData();
    _dataFetcher.sink.add(dataModel);
  }

  dispose() {
    _dataFetcher.close();
  }
}

final bloc = DataBloc();