import 'package:flutter/material.dart';
import '../models/user_role.dart';
import '../pages/beranda_page.dart';
import '../pages/figma_analisis_page.dart';
import '../pages/riwayat_page.dart';
import '../pages/model_ai_page.dart';
import '../pages/akun_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isAdmin = UserSession.currentRole == UserRole.admin;

    // Daftar Halaman Admin (5 Tab)
    final List<Widget> adminPages = [
      const BerandaPage(),
      const FigmaAnalisisPage(),
      const RiwayatPage(),
      const ModelAIPage(),
      const AkunPage(),
    ];

    // Daftar Halaman Pengguna Biasa (3 Tab)
    final List<Widget> userPages = [
      const BerandaPage(),
      const FigmaAnalisisPage(),
      const AkunPage(),
    ];

    final pages = isAdmin ? adminPages : userPages;

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor:
            const Color(0xFF0066FF), // Menggunakan warna utama Figma langsung
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: isAdmin
            ? const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart), label: 'Analitik'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: 'Riwayat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.psychology), label: 'Model AI'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Akun'),
              ]
            : const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart), label: 'Analitik'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Akun'),
              ],
      ),
    );
  }
}
