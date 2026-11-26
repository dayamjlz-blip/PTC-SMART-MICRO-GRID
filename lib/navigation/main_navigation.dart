import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';

// Halaman Admin
import 'package:smart_mikro_grid/pages/admin/admin_akun_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_analisis_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_beranda_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_model_ai_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_riwayat_page.dart';

// Halaman Pengguna
import 'package:smart_mikro_grid/pages/pengguna/pengguna_akun_page.dart';
import 'package:smart_mikro_grid/pages/pengguna/pengguna_beranda_page.dart';
import 'package:smart_mikro_grid/pages/pengguna/pengguna_model_ai_page.dart';
import 'package:smart_mikro_grid/pages/pengguna/pengguna_riwayat_page.dart';

class MainNavigation extends StatefulWidget {
  final User? account;

  const MainNavigation({
    super.key,
    this.account,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final String role =
        (widget.account?.role ?? 'Pengguna').trim().toLowerCase();
    final bool isAdmin = role == 'admin';

    // Daftar halaman sesuai role
    final List<Widget> pages = isAdmin
        ? [
            const AdminBerandaPage(),
            const AdminAnalisisPage(),
            const AdminModelAiPage(),
            const AdminRiwayatPage(),
            const AdminAkunPage(),
          ]
        : [
            const PenggunaBerandaPage(),
            const PenggunaModelAiPage(),
            const PenggunaRiwayatPage(),
            const PenggunaAkunPage(),
          ];

    // Daftar menu BottomNavigationBar sesuai role
    final List<BottomNavigationBarItem> navItems = isAdmin
        ? const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Analitik',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.psychology_rounded),
              label: 'Prediksi Daya',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Akun',
            ),
          ]
        : const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.psychology_rounded),
              label: 'Predikasi Daya',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Akun',
            ),
          ];

    // Jaga agar index tidak out-of-range saat berpindah role
    final int safeIndex = _selectedIndex >= pages.length ? 0 : _selectedIndex;

    return Scaffold(
      body: pages[safeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: safeIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11.5,
        unselectedFontSize: 11,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: navItems,
      ),
    );
  }
}
