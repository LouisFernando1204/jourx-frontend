import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jourx/view/pages/pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
  runApp(MaterialApp.router(routerConfig: router));
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'Article List Page',
      builder: (context, state) => const ArticleListPage(),
    ),
    GoRoute(
      path: '/success',
      name: 'Home Page',
      builder: (context, state) {
        final username = state.pathParameters['username'].toString();
        print("USERNAME: ${username}");
        if (username == null || username.isEmpty) {
          // Menampilkan error jika parameter username tidak ada
          return const Scaffold(
            body: Center(child: Text('Username parameter is missing!')),
          );
        }
        return HomePage(username: username.toString());
      },
    ),
    GoRoute(
      path: '/article/:slug',
      name: 'Article Detail Page',
      builder: (context, state) {
        final slug = state.pathParameters['slug'].toString();
        print("SLUG: " + slug);
        return ArticleDetailPage(slug: slug);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: ArticleListPage());
  }
}
