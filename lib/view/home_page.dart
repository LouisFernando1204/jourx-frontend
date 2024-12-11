import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final dynamic username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Home Page", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Registration Successful!",
                style: TextStyle(color: Colors.white)),
            Text("Username: ${username}",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
