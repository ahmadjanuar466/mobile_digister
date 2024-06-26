import 'package:digister/screens/message/message_screen.dart';
import 'package:digister/screens/notification/notification_screen.dart';
import 'package:digister/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:digister/screens/account/account_screen.dart';
import 'package:digister/screens/home/home_screen.dart';
import 'package:digister/screens/treasury/treasury_screen.dart';
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
    if (userLevel.userLevelName != "Warga") const TreasuryScreen(),
    const NotificationScreen(),
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
        iconSize: 22,
        selectedFontSize: 12,
        unselectedFontSize: 10,
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
          if (userLevel.userLevelName != "Warga")
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.balance_rounded,
              ),
              label: 'Bendahara',
            ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3
                  ? Icons.notifications
                  : Icons.notifications_outlined,
            ),
            label: 'Notifikasi',
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
