import 'package:dio/dio.dart';

import 'network_connection.dart';

class ApiProvider with NetworkConnection {
  ApiProvider(this._indexList, this._valueList);
  final List<String> _indexList, _valueList;

  Future<String> objectList() async {
    Response<dynamic> response;
    try {
      response = await getJSON(
          // '${AppString.urlApiPath}msloyalty/api/promotion-categories?search[0][name]=name&search[0][type]=contains&search[0][value]=To&page=1&size=99&sort=id:desc',
          'http://assetidx.mandayamedical.group/3dobject/3d_index.txt',
          'GET',
          _indexList,
          _valueList,
          '');
      return response.data as String;
    } on DioError catch (error) {
      print(error);
    }
  }
}
