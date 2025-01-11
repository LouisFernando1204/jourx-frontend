part of 'pages.dart';

class AiRecomendationPage extends StatefulWidget {
  final String bearerToken;
  final int diaryID;

  const AiRecomendationPage({
    super.key,
    required this.bearerToken,
    required this.diaryID,
  });

  @override
  State<AiRecomendationPage> createState() => _AiRecomendationPageState();
}

class _AiRecomendationPageState extends State<AiRecomendationPage> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Center(
              child: Text(
                'AI Recommendation',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff1f1f1f)
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
      body: Consumer<DiaryViewmodel>(
        builder: (context, viewModel, _) {
          switch (viewModel.diaryDetail.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load data. Please try again.'),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<DiaryViewmodel>(context, listen: false)
                            .getDiaryDetail(
                                widget.diaryID.toString(), widget.bearerToken);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            case Status.completed:
              final diary = viewModel.diaryDetail.data;
              if (diary == null) {
                return const Center(child: Text('No data available'));
              }
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            diary.createdAt != null
                                ? DateFormat('EEEE, dd MMMM yyyy', 'id')
                                    .format(diary.createdAt!)
                                : "",
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
                                color: Color(0xff1f1f1f),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: diary.emotion,
                                  style: GoogleFonts.poppins(
                                    color: Color(0xff0D92F4),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14.0),
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xff0D92F4),
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 20.0,
                                      right: 27.0,
                                      bottom: 16.0),
                                  child: Text(
                                    diary.suggestionsAi!,
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
                                  color: Color(0xff1f1f1f)),
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
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainMenu(
                                  username:
                                      "Jessica"), // Ganti dengan halaman yang sesuai
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
                          ),
                        ),
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
                  ),
                ],
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
