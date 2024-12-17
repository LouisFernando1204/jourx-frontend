part of 'pages.dart';

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
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Home",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.white),
              ),
              centerTitle: true),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Registration Successful",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.orange),
                textAlign: TextAlign.left,
              ),
              Text(
                "Username: ${username}",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.orange),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ),
    );
  }
}
