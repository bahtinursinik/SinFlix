import 'package:flutter/material.dart';
import 'package:one_path/presentation/pages/custom_bottom_bar_page.dart';

import 'home_page.dart';
import 'profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> _pages = [const HomePage(), const ProfilePage()];

  void _onTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigation(
              selectedIndex: selectedIndex,
              onTabChange: _onTabChange,
            ),
          ),
        ],
      ),
    );
  }
}
