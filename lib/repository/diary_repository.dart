import 'package:jourx/data/network/network_api_services.dart';
import 'package:jourx/model/diary.dart';

class DiaryRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Diary>> fetchDiaryList(String bearerToken) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/api/diaries', bearerToken: bearerToken);
      print("Respons API diterima: $response");
      if (response != null && response['status'] == 'success') {
        List<Diary> result = [];
        if (response['data'] != null && response['data']['data'] is List) {
          result = (response['data']['data'] as List)
              .map((e) => Diary.fromJson(e))
              .toList();
          result.sort((a, b) {
            if (a.createdAt == null || b.createdAt == null) {
              return 0;
            }
            return b.createdAt!.compareTo(a.createdAt!);
          });
        } else {
          throw Exception('Data diaries tidak ditemukan');
        }
        print("Diary berhasil diambil: $result");
        return result;
      } else {
        throw Exception(response['message'] ?? 'Gagal mengambil diary');
      }
    } catch (e) {
      print("Terjadi error: $e");
      throw Exception('Error saat mengambil diary: $e');
    }
  }

  Future<Diary> fetchDiaryDetails(String diaryId, String bearerToken) async {
    try {
      dynamic response = await _apiServices.getApiResponse(
        '/api/diaries/$diaryId',
        bearerToken: bearerToken,
      );

      print("Respons API diterima untuk detail diary: $response");

      if (response != null && response['status'] == 'success') {
        if (response['data'] != null) {
          Diary diary = Diary.fromJson(response['data']);
          print("Diary details berhasil diambil: $diary");
          return diary;
        } else {
          throw Exception('Data diary tidak ditemukan');
        }
      } else {
        throw Exception(response['message'] ?? 'Gagal mengambil detail diary');
      }
    } catch (e) {
      print("Terjadi error saat mengambil detail diary: $e");
      throw Exception('Error saat mengambil detail diary: $e');
    }
  }

  Future<Map<String, dynamic>> postDiary(
      String content, String bearerToken) async {
    const String endpoint = '/api/diaries';
    final Map<String, dynamic> body = {
      'content': content,
    };

    try {
      final response = await _apiServices.postApiResponse(
        endpoint,
        body,
        bearerToken: bearerToken,
      );
      print('Diary posted successfully: $response');
      return response; // Kembalikan data
    } catch (e) {
      print('Error posting diary: $e');
      throw e;
    }
  }
}
