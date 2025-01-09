import 'package:flutter/material.dart';
import 'package:jourx/view/pages/pages.dart';
import 'package:jourx/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jourx/data/network/network_api_services.dart';
import 'package:jourx/model/diary.dart';
import 'package:jourx/repository/diary_repository.dart';
import 'package:jourx/view/pages/pages.dart';
import 'package:jourx/view/widgets/widgets.dart';
import 'package:jourx/view_model/article_viewmodel.dart';
import 'package:jourx/view_model/diary_viewmodel.dart';
import 'package:provider/provider.dart'; // Pastikan Anda mengganti path ini ke lokasi sebenarnya dari PricePage
// import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  print("Starting app...");
  // // await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null);

  final router = GoRouter(
    routes: [
// ganti url / dengan page yang pertama kali muncul saat aplikasi dibuka
// ganti username dengan nama user yang disimpan di local (dengan shared preferences) atau google firebase auth
      GoRoute(
        path: '/',
        name: 'Login/Register',
        builder: (context, state) => const MainMenu(username: "Jessica"),
      ),
      GoRoute(
        path: '/success',
        name: 'Home Page',
        builder: (context, state) {
          final username = state.uri.queryParameters['username'].toString();
          return MainMenu(username: username.toString());
        },
      ),
      GoRoute(
        path: '/articles',
        name: 'Article List Page',
        builder: (context, state) => const ArticleListPage(),
      ),
      GoRoute(
        path: '/article/:slug',
        name: 'Article Detail Page',
        builder: (context, state) {
          final slug = state.pathParameters['slug'].toString();
          return ArticleDetailPage(slug: slug);
        },
      ),
    ],
  );
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
    return MultiProvider(
      // Gunakan MultiProvider untuk beberapa provider
      providers: [
        ChangeNotifierProvider(create: (_) => DiaryViewmodel()),
        ChangeNotifierProvider(create: (_) => ArticleViewModel()),
        // Tambahkan provider lain jika ada
      ],
      child: MaterialApp.router(
        title: 'Jourx App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home: const MainMenu(), // sudah tidak dipakai lagi karena sudah menggunakan gorouter
        routerConfig: router,
      ),
    );
  }
}
