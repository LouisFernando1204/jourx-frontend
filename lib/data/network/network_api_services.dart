import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:jourx/data/network/base_api_services.dart';
import 'package:jourx/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:jourx/data/app_exception.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future getApiResponse(String endpoint, {String? bearerToken}) async {
  dynamic responseJson;
  try {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (bearerToken != null && bearerToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }

    final response = await http.get(
      Uri.parse('${Const.baseUrl}$endpoint'),
      headers: headers,
    );

    responseJson = returnResponse(response);
  } on SocketException {
    throw NoInternetException('No Internet connection.');
  } on TimeoutException {
    throw FetchDataException('Network request timed out!');
  }

  return responseJson;
}


  @override
 Future<dynamic> postApiResponse(String endpoint, dynamic data, {String? bearerToken}) async {
  dynamic responseJson;
  try {
    print(data);

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (bearerToken != null && bearerToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }

    final response = await http.post(
      Uri.parse('${Const.baseUrl}$endpoint'),
      headers: headers,
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
