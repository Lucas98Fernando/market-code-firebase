import 'package:flutter/material.dart';
// import 'package:authentification/Start.dart';
import 'package:market_code/pages/Favorite.dart';
import 'package:market_code/pages/Profile.dart';
import 'package:market_code/pages/WelcomePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instância para controle das páginas
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  // Array contendo as páginas da navegação
  List<Widget> _screens = [
    WelcomePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Método para mudar de página ao selecionar na navegação
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              ),
              label: "Início",
              backgroundColor: _selectedIndex == 0 ? Colors.blue : Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              ),
              label: "Favoritos",
              backgroundColor: _selectedIndex == 1 ? Colors.blue : Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              ),
              label: "Perfil",
              backgroundColor: _selectedIndex == 2 ? Colors.blue : Colors.grey)
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
