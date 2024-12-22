part of 'pages.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[HomePage(), AiRecomendationPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBack(
        child: _pages[_selectedIndex],
        waitForSecondBackPress: 4,
        onFirstBackPress: (context) {
          return Fluttertoast.showToast(
              msg: "Press",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 14);
        },
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF0284C7),
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Homepage"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article")
        ],
        selectedItemColor: Colors.white, // Warna ikon yang terpilih (aktif)
        unselectedItemColor: Colors.white, 
      ),
      
    );
  }
}
