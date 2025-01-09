import 'package:flutter/material.dart';
import 'package:jourx/data/response/api_response.dart';
import 'package:jourx/model/diary.dart';
import 'package:jourx/repository/diary_repository.dart';

class DiaryViewmodel with ChangeNotifier {
  final _diaryRepo = DiaryRepository();

  ApiResponse<List<Diary>> _diaryList = ApiResponse.loading();
  ApiResponse<List<Diary>> get diaryList => _diaryList;

  void setDiaryList(ApiResponse<List<Diary>> response) {
    if (_diaryList != response) {
      _diaryList = response;
      notifyListeners();
    }
  }

  Future<void> getDiaryList(String bearerToken) async {
    setDiaryList(ApiResponse.loading());
    try {
      final List<Diary> diaries = await _diaryRepo.fetchDiaryList(bearerToken);
      setDiaryList(ApiResponse.completed(diaries));
    } catch (e) {
      setDiaryList(ApiResponse.error(e.toString()));
    }
  }

  ApiResponse<Diary> diaryDetail = ApiResponse.loading();
  setDiaryDetail(ApiResponse<Diary> response) {
    diaryDetail = response;
    notifyListeners();
  }

  Future<void> getDiaryDetail(String diaryId, String bearerToken) async {
    setDiaryDetail(ApiResponse.loading());
    try {
      final diary = await _diaryRepo.fetchDiaryDetails(diaryId, bearerToken);
      setDiaryDetail(ApiResponse.completed(diary));
      print('API Response: $diary');
    } catch (e) {
      setDiaryDetail(ApiResponse.error(e.toString()));
    }
  }

  ApiResponse<Map<String, dynamic>> diaryResponse = ApiResponse.loading();

  void setDiaryResponse(ApiResponse<Map<String, dynamic>> response) {
    diaryResponse = response;
    notifyListeners();
  }

  Future<Map<String, dynamic>> postDiary({
    required String content,
    required String bearerToken,
  }) async {
    setDiaryResponse(ApiResponse.loading());

    try {
      final response = await _diaryRepo.postDiary(content, bearerToken);
      return response;
    } catch (e) {
      setDiaryResponse(ApiResponse.error(e.toString()));
      throw e;
    }
  }
}
