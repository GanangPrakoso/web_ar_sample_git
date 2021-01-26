import 'package:dio/dio.dart'
    show Dio, DioError, DioErrorType, Options, Response;

mixin NetworkConnection {
  /// -------------------------------------------------------------
  /// Method that get response of JSON return from the API server
  /// which receive the parameter of 2 list of String
  /// -------------------------------------------------------------
  Future<Response<dynamic>> getJSON(String url, String typeRequest,
      List<String> indexMap, List<dynamic> fieldValue, String auth,
      {String refresh = ''}) async {
    final Options options = Options(receiveTimeout: 30000, sendTimeout: 30000);

    if (auth != '') {
      options.headers = <String, dynamic>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + auth
      };
    }

    if (refresh != '') {
      options.headers = <String, dynamic>{
        'Content-Type': 'application/json',
        'refreshToken': refresh
      };
    }

    // Handle request for not type POST or PUT
    if (typeRequest != 'POST' ||
        typeRequest != 'PUT' ||
        typeRequest != 'PATCH') {
      String response = '';
      for (int i = 0; i < indexMap.length; i++) {
        response += indexMap[i] +
            '=' +
            fieldValue[i].toString() +
            (indexMap.length > 1 ? '&' : '');
      }
      if (typeRequest == 'GET')
        return Dio().get<dynamic>(url + (response != '' ? '?' + response : ''),
            options: options);

      if (typeRequest == 'DELETE')
        return Dio().delete<dynamic>(
            url + (response != '' ? '?' + response : ''),
            options: options);
    }

    // Handle Request for type POST or PUT or PATCH
    options.method = typeRequest;
    return await Dio().request<dynamic>(url,
        data: _toMap(indexMap, fieldValue), options: options);
  }

  /// ---------------------------------------------------------------------
  /// Method that handle errors of the JSON response from the API server
  /// which return of String of error
  /// ---------------------------------------------------------------------
  String handleError(DioError error) {
    String errorDescription = '';
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = 'Sent timeout with API server';
          break;
        case DioErrorType.CANCEL:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription =
              'There is disruption in the network, Please try again Later!';
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              'There is disruption in the network, Please try again Later!';
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              'Received invalid status code: ${error.response.statusCode}';
          break;
      }
    } else {
      errorDescription = 'Unexpected error occured';
    }
    return errorDescription;
  }

  int getTotalPage(Response<dynamic> response) {
    int page = 0;
    final List<String> linkString =
        response.headers['link'].toString().split(',');
    for (int i = 0; i < linkString.length; i++) {
      final RegExp checkPage = RegExp(r'(?=rel)(.*)');
      final RegExpMatch checkResult = checkPage.firstMatch(linkString[i]);
      if (checkResult != null) {
        if (checkResult.group(0).contains('last')) {
          final RegExp totalPage = RegExp(r'(?<=page=)(.*)(?=&size)');
          final RegExpMatch totalMatch = totalPage.firstMatch(linkString[i]);
          page = int.parse(totalMatch.group(0));
        }
      }
    }

    return page;
  }

  /// ---------------------------------------------------------------------
  /// Methods which convert the value of list and return the value of Map
  /// ---------------------------------------------------------------------
  Map<String, dynamic> _toMap(List<String> indexMap, List<dynamic> fieldValue) {
    final Map<String, dynamic> map = <String, dynamic>{};
    for (int i = 0; i < indexMap.length; i++) {
      map[indexMap[i]] = fieldValue[i];
    }

    return map;
  }
}
