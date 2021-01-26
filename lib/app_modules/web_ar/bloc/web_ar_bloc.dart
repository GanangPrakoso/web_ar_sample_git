import 'package:rxdart/rxdart.dart';
import '../resources/api_provider.dart';

class WebArBloc {
  WebArBloc() {
    _getObjectList();
  }

  final BehaviorSubject<List<String>> _objectList =
      BehaviorSubject<List<String>>();

  Stream<List<String>> get objectList => _objectList.stream;

  Future<void> _getObjectList() async {
    final String response = await ApiProvider([], []).objectList();
    final List<String> urlList = response.split('\r\n');
    _objectList.sink.add(urlList);
  }

  Future<void> refreshList() async {
    _objectList.sink.add(null);
    await Future<void>.delayed(Duration(seconds: 1));
    _getObjectList();
  }

  void dispose() {
    _objectList.close();
  }
}
