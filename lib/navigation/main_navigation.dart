import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';
import 'package:smart_mikro_grid/pages/admin/admin_akun_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_analisis_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_beranda_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_model_ai_page.dart';
import 'package:smart_mikro_grid/pages/admin/admin_riwayat_page.dart';
import 'package:smart_mikro_grid/pages/autentikasi/figma_welcome_page.dart';

class MainNavigation extends StatefulWidget {
  final User? account;

  const MainNavigation({super.key, this.account});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final String role = (widget.account?.role ?? 'Admin').trim().toLowerCase();
    final bool isPengguna = role == 'pengguna';

    // 1. JALUR PENGGUNA (Sementara menunggu rekan tim mengisi folder pages/pengguna/)
    if (isPengguna) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard Pengguna'),
          backgroundColor: const Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              tooltip: 'Keluar',
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FigmaWelcomePage(account: widget.account),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.solar_power_rounded,
                  size: 72,
                  color: Color(0xFF1E3A8A),
                ),
                const SizedBox(height: 16),
                Text(
                  'Halo, ${widget.account?.name ?? "Pengguna"}!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Akun Anda terdaftar dengan peran Pengguna (Read-Only).\n'
                  'Tampilan khusus Pengguna sedang disiapkan pada folder:\n'
                  'lib/pages/pengguna/',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 2. JALUR ADMIN (5 Tab Utama di folder lib/pages/admin/)
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
        unselectedItemColor: Colors.grey.shade600,
        selectedFontSize: 11.5,
        unselectedFontSize: 11,
        onTap: (index) => setState(() => _selectedIndex = index),
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
