part of 'pages.dart';

class JournalingPage extends StatefulWidget {
  const JournalingPage({super.key});

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  late stt.SpeechToText _speech;
  late TextEditingController _textController;
  bool _isListening = false;
  String _text = "";
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _textController = TextEditingController(text: _text);
    _textController.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    setState(() {
      _isButtonEnabled = _textController.text.trim().isNotEmpty;
    });
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        localeId: 'id-ID',
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
            _textController.text = _text;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading:
              false, // Menonaktifkan tombol kembali otomatis
          title: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 19.0), // Menambahkan padding horizontal
            child: Center(
              child: Text(
                'Write Journal',
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
              Navigator.of(context)
                  .pop(); // Navigasi kembali ke halaman sebelumnya
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
                    Text.rich(
                      TextSpan(
                        text: 'Write down what ', // Teks biasa
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 32,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'you are feeling!', // Teks dengan gaya yang berbeda
                            style: GoogleFonts.poppins(
                              color: Color(0xff0284c7),
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8.0),
                    Text(
                      "Jumat, 27 Oktober 2024",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 200.0,
                        ),
                        child: Stack(
                          children: [
                            Scrollbar(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: TextField(
                                  controller: _textController,
                                  maxLines: 90,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'Tulis sesuatu...',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 16),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(16.0),
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(
                                  _isListening ? Icons.mic_off : Icons.mic,
                                  color: Color(0xff0284c7),
                                ),
                                onPressed: () {
                                  if (_isListening) {
                                    _speech.stop();
                                    setState(() {
                                      _isListening = false;
                                    });
                                  } else {
                                    _startListening();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    // Spacer to push the button to the bottom
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isButtonEnabled
                              ? Color(0xff0284c7)
                              : Colors.orange[200],
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: _isButtonEnabled
                            ? () {
                                print(
                                    'Jurnal tersimpan: ${_textController.text}');
                              }
                            : null,
                        child: Text(
                          'Selesai',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
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

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.25, size.height, size.width * 0.5, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.6, size.width, size.height * 0.7)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
