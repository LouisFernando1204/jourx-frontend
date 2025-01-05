import 'package:flutter/material.dart';
import 'package:jourx/data/network/network_api_services.dart';
import 'package:jourx/model/diary.dart';
import 'package:jourx/repository/diary_repository.dart';
import 'package:jourx/view/pages/pages.dart';
import 'package:jourx/view/widgets/widgets.dart';
import 'package:jourx/view_model/diary_viewmodel.dart';
import 'package:provider/provider.dart'; // Pastikan Anda mengganti path ini ke lokasi sebenarnya dari PricePage

void main() async {
  print("Starting app...");
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

// void main() async {
//   final apiService = NetworkApiServices(); // Pastikan `ApiService` sudah diinisialisasi.
//   final postDiaryRepository = DiaryRepository();

//   const String bearerToken = '1|TBHGYu1mVtGg3zwtnA4vcoi0O0iejmlFSFbvHhUx6106c8a4'; // Ganti dengan token Anda.
//   const String content = 'info aku pusing 7 keliling plisss aw aw aw';

//   try {
//     await postDiaryRepository.postDiary(content, bearerToken);
//     print('Diary successfully posted!');
//   } catch (e) {
//     print('Failed to post diary: $e');
//   }
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Pastikan Flutter terinisialisasi sebelum fungsi async

//   // Tes fetchDiaryDetails
//   await testFetchDiaryDetails();

//   runApp(MyApp());
// }

// Future<void> testFetchDiaryDetails() async {
//   final apiServices = NetworkApiServices(); // Inisialisasi ApiServices
//   final diaryRepository = DiaryRepository(); // Inisialisasi DiaryRepository

//   const diaryId = '7'; // Ganti dengan ID diary valid
//   const bearerToken = '2|wtNTspLZwt3FxSlKDAt2KLE7oEPziIumAb1IhXpd9e83bfbc'; // Ganti dengan token valid

//   try {
//     print("Memulai pengujian fetchDiaryDetails...");
//     Diary diary = await diaryRepository.fetchDiaryDetails(diaryId, bearerToken);
//     print("Hasil fetch diary details: ${diary.toJson()}");
//   } catch (e) {
//     print("Terjadi error saat pengujian fetchDiaryDetails: $e");
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Gunakan MultiProvider untuk beberapa provider
      providers: [
        ChangeNotifierProvider(create: (_) => DiaryViewmodel()),
        // Tambahkan provider lain jika ada
      ],
      child: MaterialApp(
        title: 'Jourx App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainMenu(), // Halaman awal aplikasi
      ),
    );
  }
}
