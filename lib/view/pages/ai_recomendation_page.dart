part of 'pages.dart';

class AiRecomendationPage extends StatefulWidget {
  const AiRecomendationPage({super.key});

  @override
  State<AiRecomendationPage> createState() => _AiRecomendationPageState();
}

class _AiRecomendationPageState extends State<AiRecomendationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Center(
              child: Text(
                'AI Recomendation',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider<JournalingViewmodel>(
        create: (_) => JournalingViewmodel(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jumat, 27 Oktober 2024",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text.rich(
                      TextSpan(
                        text: 'Your emotion right now is ',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 36,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Jealousy',
                            style: GoogleFonts.poppins(
                              color: Color(0xff0284c7),
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Color(0xff0284c7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 12.0,
                            right: 12.0,
                            child: Image.asset(
                              'assets/images/AI.png',
                              height: 20,
                              width: 20,
                              color: Colors.white,
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 20.0,
                                right: 27.0,
                                bottom: 16.0),
                            child: Text(
                              'This is the AI recommendation text. It can be multi-line and will be wrapped and scrolled if it exceeds the height of the container.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                     Center(
                      child: Text(
                        'Quotes for you',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                        ),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Center(
                      child: Text(
                        '"The only way to do great work is to love what you do."',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan aksi tombol di sini
                        print('Button pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0284c7), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Radius tombol
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Finish',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
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