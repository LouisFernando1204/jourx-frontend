part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Register Page", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
              child: Text("This is Registration Page",
                  style: TextStyle(color: Colors.blue)))),
    );
  }
}
