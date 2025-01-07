part of 'pages.dart';


class HomePage extends StatefulWidget {
  final String bearerToken;

  const HomePage({super.key, required this.bearerToken});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiaryViewmodel>(context, listen: false)
          .getDiaryList(widget.bearerToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Judul dan sapaan)
              Text(
                "Daily Reflection",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 5),
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
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JournalingPage(
                        bearerToken: widget.bearerToken,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: const Color(0xff0284c7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Refleksikan Hari Mu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Transform.rotate(
                      angle: -45 * 3.14159 / 180,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Text(
                "Recent Journal",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Consumer<DiaryViewmodel>(
                builder: (context, viewModel, _) {
                  switch (viewModel.diaryList.status) {
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator());
                    case Status.error:
                      return Center(
                          child: Text('Error: ${viewModel.diaryList.message}'));
                    case Status.completed:
                      final allDiaries = viewModel.diaryList.data ?? [];
                      final displayedDiaries = allDiaries.length > 3
                          ? allDiaries.sublist(0, 3)
                          : allDiaries;

                      return displayedDiaries.isEmpty
                          ? const Center(child: Text('No diaries found'))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: displayedDiaries.length,
                              itemBuilder: (context, index) {
                                final diary = displayedDiaries[index];
                                return HistoryCard(
                                  journalTitle: diary.content,
                                  journalDate: diary.createdAt,
                                  categoryValue: diary.stressLevel,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JournalResultPage(
                                        bearerToken: widget.bearerToken,
                                        diaryID: diary.id!,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    default:
                      return const Center(child: Text("Unknown State"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}