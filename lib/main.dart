import 'package:flutter/material.dart';
import 'package:jourx/view/pages/pages.dart';
import 'package:jourx/view/widgets/widgets.dart'; // Pastikan Anda mengganti path ini ke lokasi sebenarnya dari PricePage

void main() async {
  print("Starting app...");
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pricing App',
      debugShowCheckedModeBanner:
          false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainMenu(), // Mengganti halaman utama menjadi PricePage
    );
  }
}
