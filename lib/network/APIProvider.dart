import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class APIProvider {
  final String _baseUrl = 'yvsdncrpod.execute-api.ap-south-1.amazonaws.com';

  Future<dynamic> get(String endpoint, Map<String, dynamic> params) async {
    var responseJson;
    try {
      final response = await http.get(Uri.https(this._baseUrl, endpoint, params));
      responseJson = _response(response);
    } on SocketException {
      throw HttpException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      default:
        throw HttpException('Failed to load metadta ${response.statusCode}.');
    }
  }
}
