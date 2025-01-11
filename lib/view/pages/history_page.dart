part of 'pages.dart';

class HistoryPage extends StatefulWidget {
  final String bearerToken;

  const HistoryPage({
    super.key,
    required this.bearerToken,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _searchController = TextEditingController();
  String _searchText = "";

  late Future<void> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    final diaryViewModel =
        Provider.of<DiaryViewmodel>(context, listen: false);
    final dailyDataViewModel =
        Provider.of<DailyDataViewModel>(context, listen: false);

    await Future.wait([
      diaryViewModel.getDiaryList(widget.bearerToken),
      dailyDataViewModel.fetchDailyData(widget.bearerToken),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Journal History',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return _buildContent();
        },
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(19.0),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 12.0),
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
          ),
        ),
        Consumer<DailyDataViewModel>(
          builder: (context, viewModel, _) {
            final allDiaries = viewModel.dailyDataList.data ?? [];
            final totalCount = allDiaries.length;

            final lowStressCount = allDiaries
                .where((diary) =>
                    diary.averageStress! >= 0 && diary.averageStress! <= 40)
                .length;
            final mediumStressCount = allDiaries
                .where((diary) =>
                    diary.averageStress! > 40 && diary.averageStress! <= 80)
                .length;
            final highStressCount = allDiaries
                .where((diary) =>
                    diary.averageStress! > 80 && diary.averageStress! <= 100)
                .length;

            final lowStressPercentage =
                totalCount > 0 ? (lowStressCount / totalCount) * 100 : 0;
            final mediumStressPercentage =
                totalCount > 0 ? (mediumStressCount / totalCount) * 100 : 0;
            final highStressPercentage =
                totalCount > 0 ? (highStressCount / totalCount) * 100 : 0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: Stack(
                      children: [
                        PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: const Color(0xff3BA79E),
                                value: lowStressPercentage.toDouble(),
                                title:
                                    '${lowStressPercentage.toStringAsFixed(1)}%',
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: const Color(0xffEABE00),
                                value: mediumStressPercentage.toDouble(),
                                title:
                                    '${mediumStressPercentage.toStringAsFixed(1)}%',
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: const Color(0xffF65A48),
                                value: highStressPercentage.toDouble(),
                                title:
                                    '${highStressPercentage.toStringAsFixed(1)}%',
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                            sectionsSpace: 2,
                            centerSpaceRadius: 50,
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Monthly \nStress Level',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLegendItem('Low Stress', const Color(0xff3BA79E)),
                      _buildLegendItem('Medium Stress', const Color(0xffEABE00)),
                      _buildLegendItem('High Stress', const Color(0xffF65A48)),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<DiaryViewmodel>(
            builder: (context, viewModel, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: _buildBody(viewModel),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }

  Widget _buildBody(DiaryViewmodel viewModel) {
    switch (viewModel.diaryList.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.error:
        return Center(child: Text('Error: ${viewModel.diaryList.message}'));
      case Status.completed:
        final allDiaries = viewModel.diaryList.data ?? [];
        final filteredDiaries = _searchText.isEmpty
            ? allDiaries
            : allDiaries
                .where((diary) => diary.content!
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
                .toList();
        return filteredDiaries.isEmpty
            ? const Center(child: Text('No diaries found for your search'))
            : ListView.builder(
                itemCount: filteredDiaries.length,
                itemBuilder: (context, index) {
                  final history = filteredDiaries[index];
                  return HistoryCard(
                    journalTitle: history.content,
                    journalDate: history.createdAt,
                    categoryValue: history.stressLevel,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JournalResultPage(
                            bearerToken: widget.bearerToken,
                            diaryID: history.id!,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
      default:
        return const Center(child: Text("Unknown State"));
    }
  }
}
