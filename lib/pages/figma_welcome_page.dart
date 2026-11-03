import 'package:flutter/material.dart';
import 'package:profil_mahasiswa/models/user.dart';
import 'package:profil_mahasiswa/pages/login_page.dart';
import 'package:profil_mahasiswa/pages/register_page.dart';

class FigmaWelcomePage extends StatefulWidget {
  const FigmaWelcomePage({super.key});

  @override
  State<FigmaWelcomePage> createState() => _FigmaWelcomePageState();
}

class _FigmaWelcomePageState extends State<FigmaWelcomePage> {
  User? registeredUser;

  // Membuka halaman Register
  Future<void> openRegister() async {
    final result = await Navigator.push<User>(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        registeredUser = result;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran berhasil! Silakan masuk.'),
        ),
      );
    }
  }

  // Membuka halaman Login
  void openLogin() {
    if (registeredUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan daftar terlebih dahulu.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          account: registeredUser!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final scaleX = constraints.maxWidth / 412;
          final scaleY = constraints.maxHeight / 917;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD9E1F1),
                  Color(0xFF4566AD),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Logo
                Positioned(
                  left: 19 * scaleX,
                  top: 85 * scaleY,
                  width: 374 * scaleX,
                  height: 374 * scaleY,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // Deskripsi
                Positioned(
                  left: 43 * scaleX,
                  top: 479 * scaleY,
                  width: 327 * scaleX,
                  height: 25 * scaleY,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: const Text(
                      'Pantau dan kelola energi surya dengan',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Alatsi',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 116 * scaleX,
                  top: 504 * scaleY,
                  width: 178 * scaleX,
                  height: 25 * scaleY,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: const Text(
                      'mudah dan efisiensi',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Alatsi',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Tombol Masuk
                Positioned(
                  left: 88 * scaleX,
                  top: 580 * scaleY,
                  width: 237 * scaleX,
                  height: 53 * scaleY,
                  child: ElevatedButton(
                    onPressed: openLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF31487A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),

                // Tombol Daftar
                Positioned(
                  left: 88 * scaleX,
                  top: 659 * scaleY,
                  width: 237 * scaleX,
                  height: 53 * scaleY,
                  child: OutlinedButton(
                    onPressed: openRegister,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF31487A),
                      side: const BorderSide(
                        color: Color(0xFF1E2E4F),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),

                // Footer
                Positioned(
                  bottom: 15 * scaleY,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Sistem Smart Mikro-Grid ITH 2026',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11 * scaleX,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}