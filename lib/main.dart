import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jourx/view/home_page.dart';
import 'package:jourx/view/register_page.dart';

void main() => runApp(MaterialApp.router(routerConfig: router));

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'Registration Page',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/success',
      name: 'Home Page',
      builder: (context, state) {
        var username = "lofer1204";
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
        home: RegisterPage());
  }
}
