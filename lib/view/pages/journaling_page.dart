part of 'pages.dart';

class JournalingPage extends StatefulWidget {
  final String bearerToken;

  const JournalingPage({
    super.key,
    required this.bearerToken,
  });

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  late stt.SpeechToText _speech;
  late TextEditingController _textController;
  bool _isListening = false;
  String _text = "";
  bool _isButtonEnabled = false;

  final viewModel = DiaryViewmodel();
  int? diaryId;
  @override
  void initState() {
    super.initState();
    requestMicrophonePermission();
    _speech = stt.SpeechToText();
    _textController = TextEditingController(text: _text);
    _textController.addListener(_handleTextChange);
  }

  Future<void> requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      var result = await Permission.microphone.request();
      if (!result.isGranted) {
        print("Microphone permission not granted");
      }
    }
  }

  void _handleTextChange() {
    setState(() {
      _text = _textController.text;
      _isButtonEnabled = _text.trim().isNotEmpty;
    });
  }

  void _startListening() async {
    try {
      bool available = await _speech.initialize(
        onError: (val) => print("Speech Error: $val"),
        onStatus: (val) => print("Speech Status: $val"),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          localeId: 'id-ID',
          listenFor: Duration(seconds: 30),
          pauseFor: Duration(seconds: 60),
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
              _textController.text = _text;
            });
          },
        );
      } else {
        print("Speech-to-Text is not available");
      }
    } catch (e) {
      print("Error initializing Speech-to-Text: $e");
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
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
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
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider<DiaryViewmodel>(
        create: (_) => DiaryViewmodel(),
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
                        text: 'Write down what ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 32,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'you are feeling!',
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
                            ? () async {
                                setState(() {
                                  _isButtonEnabled = false;
                                });
                                final response = await viewModel.postDiary(
                                  content: _text,
                                  bearerToken: widget.bearerToken,
                                );

                                final responseId = response["data"]["id"];
                                setState(() {
                                  diaryId = responseId;
                                });
                                print('DIARY RESPONSE: $response');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AiRecomendationPage(
                                        bearerToken: widget.bearerToken,
                                        diaryID: diaryId!),
                                  ),
                                );
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
