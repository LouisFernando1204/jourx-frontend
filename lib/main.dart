import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jourx/model/model.dart';
import 'package:jourx/view/pages/pages.dart';
import 'package:jourx/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jourx/view_model/article_viewmodel.dart';
import 'package:jourx/view_model/daily_data_viewmodel.dart';
import 'package:jourx/view_model/diary_viewmodel.dart';
import 'package:jourx/view_model/login_viewmodel.dart';
import 'package:provider/provider.dart'; // Pastikan Anda mengganti path ini ke lokasi sebenarnya dari PricePage
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  print("Starting app...");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null);

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/sucess',
        name: 'Login Page',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'Register Page',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/',
        name: 'Home Page',
        builder: (context, state) {
          final username =
              state.uri.queryParameters['username'] ?? "DefaultUser";
          return MainMenu(username: username);
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
          final slug = state.pathParameters['slug'] ?? "default-slug";
          return ArticleDetailPage(slug: slug);
        },
      ),
    ],
  );

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DiaryViewmodel()),
        ChangeNotifierProvider(create: (_) => ArticleViewModel()),
        ChangeNotifierProvider(create: (_) => DailyDataViewModel()),
      ],
      child: MaterialApp.router(
        title: 'Jourx App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
