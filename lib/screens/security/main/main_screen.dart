import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/login/login_screen.dart';
import 'package:digister/screens/security/cctv/cctv_screen.dart';
import 'package:digister/screens/security/home/home_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgets = const [
    HomeScreen(),
    CCTVScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _handleLogout() async {
    showModalDialog(
      context,
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah anda yakin ?'),
        actions: [
          TextButton(
            onPressed: () => RouteHelper.pop(context),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () async {
              localStorage.removeItem('token');

              RouteHelper.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                widget: const LoginScreen(isRegister: false),
                transitionType: PageTransitionType.leftToRight,
              );
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: _selectedIndex == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          setState(() {
            _selectedIndex = 0;
          });
        },
        child: _widgets[_selectedIndex],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _handleLogout,
              child: const Icon(Icons.logout_rounded),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_outdoor_rounded),
            label: 'CCTV',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
