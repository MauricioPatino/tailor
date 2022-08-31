import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor/ui/pages/utils/global_routes.dart';
import 'package:provider/provider.dart';
import 'package:tailor/ui/pages/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

    class _HomePageState extends State<Home> {
      int _selectedIndex = 1;

      late PageController _pageController;

      @override
      void initState(){
        super.initState();
        _pageController = PageController(initialPage: 1);
      }

      @override
      void dispose(){
        super.dispose();
        _pageController.dispose();
      }

      void onPageChanged(int index) {
        setState(() {
          _selectedIndex = index;
        });
      }

      void _onItemTapped(int index) {
        _pageController.jumpToPage(index);
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,

      ) ,

      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 30),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Feedback'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
