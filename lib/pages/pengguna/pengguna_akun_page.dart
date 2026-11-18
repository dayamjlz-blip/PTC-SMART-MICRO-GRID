
import 'package:flutter/material.dart';

class PenggunaAkunPage extends StatefulWidget {
  final String nama;
  final String email;

  const PenggunaAkunPage({
    super.key,
    this.nama = 'Andi Pratama',
    this.email = 'andi.pratama@ith.ac.id',
  });

  @override
  State<PenggunaAkunPage> createState() => _PenggunaAkunPageState();
}

class _PenggunaAkunPageState extends State<PenggunaAkunPage> {
  late TextEditingController _namaController;
  late String _nama;

  static const Color navy = Color(0xFF20345F);

  @override
  void initState() {
    super.initState();
    _nama = widget.nama;
    _namaController = TextEditingController(text: _nama);
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE7EDF9),
            Color(0xFF9DB2DA),
            Color(0xFF6684BC),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profil Pengguna',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 14),

              // KARTU PROFIL
              _card(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: navy,
                      child: Text(
                        _nama.isNotEmpty
                            ? _nama[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nama,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: navy,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.email,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: navy,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'User',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // RINGKASAN AKSES
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Ringkasan akses',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Peran User dapat memantau Beranda, Model AI, '
                      'dan Riwayat. Kontrol beban dan pengaturan '
                      'sistem hanya untuk Admin.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _menuItem(
                icon: Icons.edit,
                title: 'Edit nama profil',
                onTap: _editNama,
              ),

              const SizedBox(height: 9),

              _menuItem(
                icon: Icons.lock,
                title: 'Ganti kata sandi',
                onTap: _gantiPassword,
              ),

              const SizedBox(height: 9),

              _menuItem(
                icon: Icons.logout,
                title: 'Keluar',
                iconColor: Colors.red,
                textColor: Colors.red,
                onTap: _konfirmasiKeluar,
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Energi bersih, masa depan lebih baik',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.05),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = navy,
    Color textColor = navy,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 14,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: iconColor.withValues(alpha: 0.1),
                child: Icon(icon, size: 17, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 13, color: textColor),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.black45,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editNama() {
    _namaController.text = _nama;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit nama profil'),
          content: TextField(
            controller: _namaController,
            decoration: const InputDecoration(
              labelText: 'Nama pengguna',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final namaBaru = _namaController.text.trim();

                if (namaBaru.isEmpty) return;

                setState(() {
                  _nama = namaBaru;
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _gantiPassword() {
    final passwordController = TextEditingController();
    final konfirmasiController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Ganti kata sandi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Kata sandi baru',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: konfirmasiController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi kata sandi',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text.isEmpty ||
                    passwordController.text !=
                        konfirmasiController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Kata sandi kosong atau tidak cocok.',
                      ),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fitur perubahan kata sandi belum terhubung.',
                    ),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    ).then((_) {
      passwordController.dispose();
      konfirmasiController.dispose();
    });
  }

  void _konfirmasiKeluar() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar akun'),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fitur keluar akan dihubungkan ke autentikasi.',
                    ),
                  ),
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
