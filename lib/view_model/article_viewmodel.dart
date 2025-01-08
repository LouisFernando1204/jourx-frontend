import 'package:flutter/material.dart';
import 'package:jourx/data/response/api_response.dart';
import 'package:jourx/model/model.dart';
import 'package:jourx/repository/article_repository.dart';

class ArticleViewModel with ChangeNotifier {
  final _articleRepo = ArticleRepository();

  ApiResponse<List<Article>> articleList = ApiResponse.loading();
  setArticleList(ApiResponse<List<Article>> response) {
    articleList = response;
    notifyListeners();
  }

  Future<dynamic> getArticleList() async {
    _articleRepo.fetchArticleList().then((value) {
      setArticleList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setArticleList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<Article> articleDetail = ApiResponse.loading();
  setArticleDetail(ApiResponse<Article> response) {
    articleDetail = response;
    notifyListeners();
  }

  Future<dynamic> getArticleDetail(String slug) async {
    _articleRepo.fetchArticleDetail(slug).then((value) {
      setArticleDetail(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setArticleDetail(ApiResponse.error(error.toString()));
    });
  }
}
