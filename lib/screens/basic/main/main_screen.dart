import 'package:digister/screens/basic/message/message_screen.dart';
import 'package:digister/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:digister/screens/basic/account/account_screen.dart';
import 'package:digister/screens/basic/home/home_screen.dart';
import 'package:digister/screens/basic/treasury/treasury_screen.dart';
import 'package:digister/utils/global.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _listScreen = [
    const HomeScreen(),
    const MessageScreen(),
    if (userLevel.userLevelName == "Bendahara" ||
        userLevel.userLevelName == 'Admin')
      const TreasuryScreen(),
    const AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseApi().initNotifications();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: _listScreen[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? Icons.message : Icons.message_outlined,
            ),
            label: 'Pesan',
          ),
          if (userLevel.userLevelName == "Bendahara" ||
              userLevel.userLevelName == 'Admin')
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.balance_rounded,
              ),
              label: 'Bendahara',
            ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4
                  ? Icons.account_circle
                  : Icons.account_circle_outlined,
            ),
            label: 'Saya',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
