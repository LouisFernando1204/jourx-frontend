part of 'pages.dart';

class HomePage extends StatefulWidget {
  final String bearerToken;

  const HomePage({
    super.key,
    required this.bearerToken,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider<HomeViewmodel>(
        create: (_) => HomeViewmodel(),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Reflection",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Hello, Jessica",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'How do you feel about your ',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 32,
                          color: Colors.black
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'current emotions?',
                            style: GoogleFonts.poppins(
                              color: Color(0xff0284c7),
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JournalingPage(bearerToken: widget.bearerToken)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 60),
                        backgroundColor: Color(0xff0284c7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Refleksikan Hari Mu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform.rotate(
                            angle: -45 * 3.14159 / 180,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      "Recent Journal",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}