import 'package:flutter/material.dart';
import 'package:Estichara/AfterRegister/home2.dart';
import 'package:Estichara/statistics/statisticscard.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google navbar',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Home2(),
    SurveyListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: GNav(
          rippleColor: Colors.white,
          hoverColor: Colors.white,
          haptic: true,
          tabBorderRadius: 15,

          tabBorder:
              Border.all(color: Colors.white, width: 1), 
          tabShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 8)
          ],
          curve: Curves.easeOutExpo, 
          duration: Duration(milliseconds: 500), 
          gap: 14,
          color: Colors.grey, 
          activeColor: Colors.orange, 
          iconSize: 35,
          tabBackgroundColor: Colors.orange.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedIndex: _currentIndex,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.pie_chart,
              text: 'Statistics',
            ),
          ],
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}


