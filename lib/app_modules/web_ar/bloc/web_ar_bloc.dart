import 'package:rxdart/rxdart.dart';
import '../resources/api_provider.dart';

class WebArBloc {
  WebArBloc() {
    _getObjectList();
  }

  final BehaviorSubject<List<String>> _objectList =
      BehaviorSubject<List<String>>();
  final BehaviorSubject<String> _search = BehaviorSubject<String>();

  List<String> _objectRemap;

  Stream<List<String>> get objectList => _objectList.stream;

  Stream<String> get search => _search.stream.transform(_getSearch());

  Function(String) get searchListener => _search.sink.add;

  void refresh() {
    _getObjectList();
    if (!_objectList.isClosed) {
      _objectList.sink.add(null);
    }
  }

  void dispose() {
    _objectList.close();
    _search.close();
  }

  Future<void> _getObjectList() async {
    final String response = await ApiProvider([], []).objectList();
    final List<String> urlList = response.split('\r\n');

    _objectRemap = urlList;
    _objectList.sink.add(_objectRemap);
  }

  Future<void> refreshList() async {
    _objectList.sink.add(null);
    await Future<void>.delayed(Duration(seconds: 1));
    _getObjectList();
  }

  ScanStreamTransformer<String, String> _getSearch() =>
      ScanStreamTransformer<String, String>(
          (String cache, String searchInfo, int index) {
        List<String> _tempList = _objectRemap;

        if (searchInfo.isNotEmpty) {
          List<String> searchList = [];
          for (int i = 0; i < _tempList.length; i++) {
            if (_tempList[i]
                .toLowerCase()
                .contains(searchInfo.toLowerCase().replaceAll(' ', '_'))) {
              searchList.add(_tempList[i]);
            }
          }
          if (!_objectList.isClosed) {
            _objectList.sink.add(searchList);
          }
        } else {
          if (!_objectList.isClosed) {
            _objectList.sink.add(_objectRemap);
          }
        }

        return searchInfo;
      });
}
