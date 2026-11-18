
import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';

import 'package:smart_mikro_grid/pages/admin/admin_akun_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_analisis_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_beranda_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_model_ai_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_riwayat_page.dart';

import 'package:smart_mikro_grid/pages/pengguna/pengguna_main_page.dart';

class MainNavigation extends StatefulWidget {
  final User? account;

  const MainNavigation({
    super.key,
    this.account,
  });

  @override
  State<MainNavigation> createState() =>
      _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final String role =
        (widget.account?.role ?? 'Pengguna')
            .trim()
            .toLowerCase();

    final bool isPengguna = role == 'pengguna';

    // JALUR PENGGUNA
    if (isPengguna) {
      return PenggunaMainPage(
        account: widget.account,
      );
    }

    // JALUR ADMIN
    final List<Widget> adminPages = [
      AdminBerandaPage(),
      AdminAnalisisPage(),
      AdminModelAiPage(),
      AdminRiwayatPage(),
      AdminAkunPage(),
    ];

    return Scaffold(
      body: adminPages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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

        items: const [
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
            label: 'Model AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
