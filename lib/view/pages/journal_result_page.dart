part of 'pages.dart';

class JournalResultPage extends StatefulWidget {
  final String bearerToken;
  final int diaryID;

  const JournalResultPage({
    super.key,
    required this.bearerToken,
    required this.diaryID,
  });

  @override
  State<JournalResultPage> createState() => _JournalResultPageState();
}

class _JournalResultPageState extends State<JournalResultPage> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<DiaryViewmodel>(context, listen: false)
          .getDiaryDetail(widget.diaryID.toString(), widget.bearerToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(
          child: Text(
            'Your Journal',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Consumer<DiaryViewmodel>(builder: (context, viewModel, _) {
        switch (viewModel.diaryDetail.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.error:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${viewModel.diaryDetail.message}'),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<DiaryViewmodel>(context, listen: false)
                          .getDiaryDetail(
                              widget.diaryID.toString(), widget.bearerToken);
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          case Status.completed:
            final diary = viewModel.diaryDetail.data;
            return diary == null
                ? const Center(child: Text('No details found'))
                : _buildJournalDetail(diary);
          default:
            return const Center(child: Text('Unknown State'));
        }
      }),
    );
  }

  Widget _buildJournalDetail(Diary diary) {
    double stressLevel =
        double.tryParse(diary.stressLevel.toString() ?? '0') ?? 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Content goes here
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text.rich(
              TextSpan(
                text: 'Through writing to manage ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 36,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'emotions',
                    style: GoogleFonts.poppins(
                      color: Color(0xff0284c7),
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff0284c7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              diary.content ?? 'No content available',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          Center(
            child: Text(
              'Stress Level: ${diary.stressLevel ?? 'Unknown'}',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15.0),

          // Progress bar with icons on the sides
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), // Memberikan jarak di sisi kanan icon kiri
                child: Image.asset(
                  'assets/images/angry.png',
                  height: 40,
                  width: 40,
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.5, // Mengatur panjang progress bar 50% dari lebar layar
                  height: 30, // Mengatur tinggi progress bar
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        12), // Menambahkan radius pada sudut
                    color:
                        Colors.grey[300], // Warna latar belakang progress bar
                  ),
                  child: Stack(
                    children: [
                      LinearProgressIndicator(
                        value: stressLevel /
                            100, // Normalize to a value between 0 and 1
                        minHeight: 30,
                        backgroundColor: Colors
                            .transparent, // Membuat latar belakang menjadi transparan
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue), // Mengatur warna progres menjadi biru
                        borderRadius:
                            BorderRadius.circular(12), // Menambahkan radius
                      ),
                      Center(
                        child: Text(
                          '${(stressLevel).toInt()}%', // Menampilkan angka progress sebagai persen
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0), // Memberikan jarak di sisi kiri icon kanan
                child: Image.asset(
                  'assets/images/happy.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),
          // Expanded widget pushes the button to the bottom
          Expanded(
            child: Container(),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AiRecomendationPage(
                      bearerToken:
                          widget.bearerToken, // Ganti sesuai token Anda
                      diaryID: widget.diaryID,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0284c7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
              ),
              child: Center(
                child: Text(
                  'Ai Recomendation',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
