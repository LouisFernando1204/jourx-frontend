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
              color: Color(0xff1f1f1f),
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
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text.rich(
              TextSpan(
                text: 'Through writing to manage ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 36,
                  color: Color(0xff1f1f1f),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'emotions',
                    style: GoogleFonts.poppins(
                      color: Color(0xff0D92F4),
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
              color: const Color(0xff0D92F4),
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
              'Stress Level',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xff1f1f1f),
              ),
            ),
          ),
          const SizedBox(height: 15.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), 
                child: Image.asset(
                  'assets/images/angry.png',
                  height: 40,
                  width: 40,
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.5,
                  height: 25, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        12), 
                    color:
                        Colors.grey[300], 
                  ),
                  child: Stack(
                    children: [
                      LinearProgressIndicator(
                        value: stressLevel /
                            100, 
                        minHeight: 25,
                        backgroundColor: Colors
                            .transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue), 
                        borderRadius:
                            BorderRadius.circular(12), 
                      ),
                      Center(
                        child: Text(
                          '${(stressLevel).toInt()}%', 
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
                    left: 8.0),
                child: Image.asset(
                  'assets/images/happy.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),
        
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
                          widget.bearerToken, 
                      diaryID: widget.diaryID,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0D92F4),
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
