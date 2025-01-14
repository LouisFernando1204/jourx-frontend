part of 'pages.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  ArticleViewModel articleViewModel = ArticleViewModel();

  @override
  void initState() {
    articleViewModel.getArticleList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String removeHtmlTags(String htmlString) {
      final document = parse(htmlString);
      return document.body?.text ?? "";
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D92F4), Color(0xFF0D92F4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Articles",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: ChangeNotifierProvider<ArticleViewModel>(
        create: (context) => articleViewModel,
        child: Consumer<ArticleViewModel>(
          builder: (context, value, _) {
            switch (value.articleList.status) {
              case Status.loading:
                return Center(
                    child: CircularProgressIndicator(color: Color(0xFF0D92F4)));
              case Status.error:
                return Center(
                    child: Text(
                        'Gagal memuat artikel: ${value.articleList.message}'));
              case Status.completed:
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Articles made for you,",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFF0D92F4)),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: value.articleList.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var article = value.articleList.data![index];
                            return GestureDetector(
                              onTap: () {
                                context.push('/article/${article.slug}');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
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
                                              "https://jourx.fun/storage/${article.imageUrl!}",
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Color(
                                                              0xFF0D92F4)),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
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
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Color(0xff1f1f1f)),
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
                                                removeHtmlTags(
                                                    article.content!),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF0D92F4),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0,
                                                      horizontal: 12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Read by: ${article.viewsCount}",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                              DateFormat('EEEE, dd MMMM yyyy',
                                                      'id_ID')
                                                  .format(article.createdAt!),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.italic,
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
                      ],
                    ),
                  ),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
