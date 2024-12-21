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
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider<JournalingViewmodel>(
        create: (_) => JournalingViewmodel(),
        child: Stack(
          children: [
            // Wave design
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 150),
                painter: WavePainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        '../assets/images/maskot.png',
                        width: 300,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 32.0), // Space for wave
                    Text(
                      "Apa yang kamu rasakan hari ini?",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.orange),
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
                                  color: Colors.orange,
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isButtonEnabled
                              ? Colors.orange
                              : Colors.orange[200],
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: _isButtonEnabled
                            ? () {
                                print('Jurnal tersimpan: ${_textController.text}');
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
