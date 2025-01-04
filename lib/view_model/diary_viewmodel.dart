import 'package:flutter/material.dart';
import 'package:jourx/data/response/api_response.dart';
import 'package:jourx/model/diary.dart';
import 'package:jourx/repository/diary_repository.dart';

class DiaryViewmodel with ChangeNotifier {
  final _diaryRepo = DiaryRepository();

  ApiResponse<List<Diary>> diaryList = ApiResponse.loading();
  setDiaryList(ApiResponse<List<Diary>> response) {
    diaryList = response;
    notifyListeners();
  }

  Future<dynamic> getDiaryList(String bearerToken) async {
    _diaryRepo.fetchDiaryList(bearerToken).then((value) {
      setDiaryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDiaryList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<Diary> diaryDetail = ApiResponse.loading();
  setDiaryDetail(ApiResponse<Diary> response) {
    diaryDetail = response;
    notifyListeners();
  }

  Future<dynamic> getDiaryDetail(String diaryId, String bearerToken) async {
    _diaryRepo.fetchDiaryDetails(diaryId, bearerToken).then((value) {
      
      setDiaryDetail(ApiResponse.completed(value));
      print('API Response: $value'); // Log response for debugging
    }).onError((error, stackTrace) {
      setDiaryDetail(ApiResponse.error(error.toString()));
    });
  }
}
