part of 'pages.dart';

class HomePage extends StatefulWidget {
  final String bearerToken;
  final String username;

  const HomePage({super.key, required this.bearerToken, required this.username});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ArticleViewModel>(context, listen: false).getArticleList();
    });
  }

  @override
  Widget build(BuildContext context) {
     final LogoutViewModel _logoutViewModel = LogoutViewModel();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Reflection",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                  PopupMenuButton<int>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (value) async {
                      if (value == 3) { 
                        await _logoutViewModel.logout(widget.bearerToken);
                        context.go('/register');
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: Center(
                            child: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Hello, ${widget.username}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 32,
                  color: Color(0xff1f1f1f),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'How do you feel about your ',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 32,
                      color: Color(0xff1f1f1f)),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'current emotions?',
                      style: GoogleFonts.poppins(
                        color: Color(0xff0D92F4),
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
                  backgroundColor: const Color(0xff0D92F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Reflex Your Day',
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
                        size: 25,
                  
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
                  color: Color(0xff1f1f1f),
                ),
              ),
              const SizedBox(height: 10),
              Consumer<DiaryViewmodel>(
                builder: (context, viewModel, _) {
                  switch (viewModel.diaryList.status) {
                    case Status.loading:
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF0D92F4)));
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
              SizedBox(height: 20),
              Text(
                "New Articles",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xff1f1f1f),
                ),
              ),
              Consumer<ArticleViewModel>(
                builder: (context, value, _) {
                  switch (value.articleList.status) {
                    case Status.loading:
                      return Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF0D92F4)));
                    case Status.error:
                      return Center(
                          child: Text(
                              'Gagal memuat artikel: ${value.articleList.message}'));
                    case Status.completed:
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: List.generate(
                                3,
                                (index) {
                                  var article = value.articleList.data![
                                      value.articleList.data!.length -
                                          1 -
                                          index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.go('/article/${article.slug}');
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        color: Colors.white70,
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 10,
                                                  child: Image.network(
                                                    article.imageUrl!,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Color(
                                                                    0xFF0D92F4)),
                                                      );
                                                    },
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Text(
                                                          "Gambar gagal dimuat!");
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      article.title!,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color:
                                                                  Color(0xff1f1f1f)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      article.content!,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF0D92F4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 6.0,
                                                        horizontal: 12.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Read by: ${article.viewsCount}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(width: 6),
                                                        Icon(
                                                          Icons.visibility,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat(
                                                            'EEEE, dd MMMM yyyy',
                                                            'id_ID')
                                                        .format(
                                                            article.createdAt!),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 14,
                                                      color: Color(0xFF0D92F4),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    default:
                      return Container();
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
