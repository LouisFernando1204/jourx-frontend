part of 'pages.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key, required this.username, this.user, this.token});
  final String bearerToken =
      '1|TBHGYu1mVtGg3zwtnA4vcoi0O0iejmlFSFbvHhUx6106c8a4';
  final String username;

  final Model.User? user;
  final String? token;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    print('User: ${widget.user}');
    print('Token: ${widget.token}');
    _pages = [
      HomePage(bearerToken: widget.bearerToken, username: widget.username),
      HistoryPage(bearerToken: widget.bearerToken),
      ArticleListPage()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0D92F4),
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Homepage"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
    );
  }
}
