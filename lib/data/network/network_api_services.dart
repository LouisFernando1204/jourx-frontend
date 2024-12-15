import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:jourx/data/network/base_api_services.dart';
import 'package:jourx/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:jourx/data/app_exception.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future getApiResponse(String endpoint) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.https(Const.baseUrl, endpoint), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network request time out!');
    }

    return responseJson;
  }

  @override
  Future<dynamic> postApiResponse(String endpoint, dynamic data) async {
    dynamic responseJson;
    try {
      print(data);
      final response = await http.post(
        Uri.https(Const.baseUrl, endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey,
        },
        body: jsonEncode(data),
      );
      responseJson = returnResponse(response);
      print("RESPONSE");
      return responseJson;
    } on SocketException {
      throw NoInternetException('No internet connection!');
    } on TimeoutException {
      throw FetchDataException('Network request timeout!');
    } on FormatException {
      throw FetchDataException('Invalid response format!');
    } catch (e) {
      throw FetchDataException('Unexpected error: $e');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with server');
    }
  }
}
