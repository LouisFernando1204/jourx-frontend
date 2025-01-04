abstract class BaseApiServices {
  Future<dynamic> getApiResponse(String endpoint, {String? bearerToken});
  Future<dynamic> postApiResponse(String url, dynamic data, {String? bearerToken});
}
