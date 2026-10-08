import 'package:flutter/material.dart';
import '../services/lot_service.dart';
import 'home/home_screen.dart';
import 'lots/my_lots_screen.dart';
import 'scanner/qr_scanner_screen.dart';
import 'profile/profile_screen.dart';
import '../core/constants/app_colors.dart';

class MainNavigationScreen extends StatefulWidget {
  final LotService lotService;

  const MainNavigationScreen({super.key, required this.lotService});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        lotService: widget.lotService,
        onOpenScanner: () {
          setState(() {
            _currentIndex = 2; // Switch to Scanner tab
          });
        },
      ),
      MyLotsScreen(lotService: widget.lotService),
      QrScannerScreen(lotService: widget.lotService),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.deepGreen2,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.oliveLight,
        unselectedItemColor: const Color(0x99E2D4B9),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Mes lots',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            activeIcon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
