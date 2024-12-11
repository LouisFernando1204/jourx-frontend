import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jourx/view/home_page.dart';
import 'package:jourx/view/register_page.dart';

void main() {
  runApp(MaterialApp.router(routerConfig: router));
}

final router = GoRouter(routes: [
  GoRoute(
      path: '/success',
      name: 'Home Page',
      builder: (context, state) {
        var username = state.uri.queryParameters['username'].toString();
        // var email = state.uri.queryParameters['email'].toString();
        // var phone_number = state.uri.queryParameters['phone_number'].toString();
        // var date_of_birth = state.uri.queryParameters['date_of_birth'].toString();

        return HomePage(username: username);

        // return HomePage(
        //   username: username,
        //   email: email,
        //   phone_number: phone_number,
        //   date_of_birth: date_of_birth);
      })
]);

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
