import 'package:flutter/material.dart';
import '../../models/user.dart';
import 'login_page.dart';
import 'register_page.dart';

class FigmaWelcomePage extends StatefulWidget {
  final User? account;

  const FigmaWelcomePage({super.key, this.account});

  @override
  State<FigmaWelcomePage> createState() => _FigmaWelcomePageState();
}

class _FigmaWelcomePageState extends State<FigmaWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEBF3FF), // Biru muda atas
              Color(0xFF5B8DF6), // Biru khas Figma
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),

                // LOGO DAN DESKRIPSI
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 140,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.bolt_rounded,
                        size: 100,
                        color: Color(0xFF0066FF),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Pantau dan kelola energi surya dengan\nmudah dan efisien",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // TOMBOL MASUK & DAFTAR
                Column(
                  children: [
                    // 1. Tombol Masuk -> Direct ke LoginPage
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(account: widget.account),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 2. Tombol Daftar -> Direct ke RegisterPage
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          "Daftar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // FOOTER TEKS
                const Text(
                  "Sistem Smart Micro-Grid ITH 2026",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
