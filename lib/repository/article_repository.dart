import 'package:jourx/data/network/network_api_services.dart';
import 'package:jourx/model/model.dart';

class ArticleRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Article>> fetchArticleList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/api/articles');
      if (response != null && response['status'] == 'success') {
        List<Article> result = [];
        if (response['status'] == 'success') {
          result = (response['data'] as List)
              .map((e) => Article.fromJson(e))
              .toList();
          result.sort((a, b) {
            if (a.createdAt == null || b.createdAt == null) {
              return 0;
            }
            return b.createdAt!.compareTo(a.createdAt!);
          });
        }
        print("Artikel berhasil diambil: $result");
        return result;
      } else {
        throw Exception(response['message'] ?? 'Gagal mengambil artikel');
      }
    } catch (e) {
      print("Terjadi error: $e");
      throw Exception('Error saat mengambil artikel: $e');
    }
  }

  Future<Article> fetchArticleDetail(String slug) async {
    try {
      final String endpoint = '/api/articles/$slug';
      dynamic response = await _apiServices.getApiResponse(endpoint);

      if (response != null && response['status'] == 'success') {
        final Article article = Article.fromJson(response['data']);
        print("Detail artikel berhasil diambil: $article");
        return article;
      } else {
        throw Exception(
            response['message'] ?? 'Gagal mengambil detail artikel');
      }
    } catch (e) {
      print("Terjadi error: $e");
      throw Exception('Error saat mengambil detail artikel: $e');
    }
  }
}
