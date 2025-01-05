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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiaryViewmodel>(context, listen: false).getDiaryList(
          widget.bearerToken); 
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
                'Journal History',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.black), 
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle:
                    const TextStyle(color: Colors.grey), 
                filled: true,
                fillColor:
                    Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, 
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.black),
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
      ),
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
                            bearerToken:
                                widget.bearerToken, 
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
