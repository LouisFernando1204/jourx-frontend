import 'package:flutter/material.dart';
import 'package:jourx/data/response/api_response.dart';
import 'package:jourx/model/daily_data.dart';
import 'package:jourx/repository/diary_repository.dart';

class DailyDataViewModel with ChangeNotifier {
    final _diaryRepo = DiaryRepository();


  ApiResponse<List<DailyData>> _dailyDataList = ApiResponse.loading();
  ApiResponse<List<DailyData>> get dailyDataList => _dailyDataList;

  void setDailyDataList(ApiResponse<List<DailyData>> response) {
    if (_dailyDataList != response) {
      _dailyDataList = response;
      notifyListeners();
    }
  }

  Future<void> fetchDailyData(String bearerToken) async {
    setDailyDataList(ApiResponse.loading());
    try {
      final List<DailyData> dailyData = await _diaryRepo.fetchDailyData(bearerToken);
      setDailyDataList(ApiResponse.completed(dailyData));
    } catch (e) {
      setDailyDataList(ApiResponse.error(e.toString()));
    }
  }
}
