part of 'pages.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allHistories = [];
  List<Map<String, dynamic>> _filteredHistories = [];

  @override
  void initState() {
    super.initState();

    // Data awal
    _allHistories = [
      {
        'title':
            'Pengalaman Mendaki Gunung Bromo yang Sangat Menakjubkan Makan Ayam',
        'date': 'Kamis, 18 November 2024',
        'categoryValue': 80,
      },
      {
        'title':
            'Pengalaman Mendaki Menakjubkan Makan Ayam Jalan-jalan ke Pantai Indah',
        'date': 'Senin, 20 November 2024',
        'categoryValue': 50,
      },
      {
        'title':
            'Menikmati Pengalaman Mendaki Gunung Brogat Menakjubkan Makan Ayam Wisata Kuliner di Bandung',
        'date': 'Selasa, 21 November 2024',
        'categoryValue': 40,
      },
      {
        'title':
            'Menikmati Pengalaman Mendaki Gunung Bromo yang Sangat Menakjubkan Makan Ayam Wisata Kuliner di Bandung',
        'date': 'Selasa, 21 November 2024',
        'categoryValue': 90,
      },
      {
        'title':
            'Menikmati Pengalaman Mendaki Gunung Bromo yang Sangat Menakjubkan Makan Ayam Wisata Kuliner di Bandung',
        'date': 'Selasa, 21 November 2024',
        'categoryValue': 10,
      },
      {
        'title':
            'Menikmati Pengalaman Mendaki Gunung Bromo yang Sangat Menakjubkan Makan Ayam Wisata Kuliner di Bandung',
        'date': 'Selasa, 21 November 2024',
        'categoryValue': 100,
      },
    ];
    _filteredHistories = List.from(_allHistories);
  }

  void _filterHistories(String query) {
    setState(() {
      _filteredHistories = _allHistories
          .where((history) =>
              history['title'].toLowerCase().contains(query.toLowerCase()) ||
              history['date'].toLowerCase().contains(query.toLowerCase()))
          .toList();
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
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider<JournalingViewmodel>(
        create: (_) => JournalingViewmodel(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              // Search Bar
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by title or date',
                    prefixIcon: Icon(Icons.search, color: Color(0xff0284c7)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xff0284c7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xff0284c7), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xff0284c7)),
                    ),
                  ),
                  onChanged: (value) => _filterHistories(value),
                ),
              ),

              const SizedBox(height: 16),
              // Scrollable List
              Expanded(
                child: _filteredHistories.isEmpty
                    ? Center(
                        child: Text(
                          'Konten tidak ditemukan...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Column(
                            children: _filteredHistories.map((history) {
                              return HistoryCard(
                                journalTitle: history['title'],
                                journalDate: history['date'],
                                categoryValue: history['categoryValue'],
                                onTap: () {
                                  print('${history['title']} di-tap!');
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
