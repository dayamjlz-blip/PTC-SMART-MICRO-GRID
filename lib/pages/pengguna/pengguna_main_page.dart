
import 'package:flutter/material.dart';

import 'package:smart_mikro_grid/models/user.dart';
import 'package:smart_mikro_grid/pages/autentikasi/figma_welcome_page.dart';

import 'package:smart_mikro_grid/pages/pengguna/pengguna_beranda_page.dart';
import 'package:smart_mikro_grid/pages/pengguna/pengguna_model_ai_page.dart';
import 'package:smart_mikro_grid/pages/pengguna/pengguna_riwayat_page.dart';
import 'package:smart_mikro_grid/pages/pengguna/pengguna_akun_page.dart';

class PenggunaMainPage extends StatefulWidget {
  final User? account;

  const PenggunaMainPage({
    super.key,
    this.account,
  });

  @override
  State<PenggunaMainPage> createState() =>
      _PenggunaMainPageState();
}

class _PenggunaMainPageState extends State<PenggunaMainPage> {
  int _selectedIndex = 0;

  static const Color navy = Color(0xFF20345F);

  final List<String> _titles = [
    'Beranda',
    'Model AI',
    'Riwayat',
    'Profil',
  ];

  // MENAMPILKAN HALAMAN SESUAI MENU YANG DIPILIH
  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const PenggunaBerandaPage();

      case 1:
        return const PenggunaModelAiPage();

      case 2:
        return const PenggunaRiwayatPage();

      case 3:
        return PenggunaAkunPage(
          nama: widget.account?.name ?? 'Pengguna',
        );

      default:
        return const PenggunaBerandaPage();
    }
  }

  // KEMBALI KE HALAMAN AWAL
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FigmaWelcomePage(account: widget.account),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EDF9),

      // BAGIAN JUDUL
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        backgroundColor: const Color(0xFFE7EDF9),
        foregroundColor: navy,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      // BAGIAN ISI HALAMAN
      body: _buildPage(),

      // NAVIGASI BAWAH
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: navy.withValues(alpha: 0.10),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: navy,
            unselectedItemColor: Colors.blueGrey,
            selectedFontSize: 11,
            unselectedFontSize: 10,
            showUnselectedLabels: true,

            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bolt_outlined),
                activeIcon: Icon(Icons.bolt),
                label: 'Model AI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
