import 'package:flutter/material.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  bool isAuto = true;
  double batteryLimit = 30;

  bool notifBattery = true;
  bool notifLoad = true;
  bool notifEsp = true;
  bool notifWifi = true;

  final Color primary = const Color(0xFF31487A);

  void showInfo(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: primary)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup', style: TextStyle(color: primary)),
          ),
        ],
      ),
    );
  }

  void showSystemSettings() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Pengaturan Sistem',
              style: TextStyle(color: primary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                leading: Icon(Icons.wifi, color: Color(0xFF31487A)),
                title: Text('Hubungkan ESP32'),
                subtitle: Text('Wi-Fi dan alamat server'),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.sensors, color: Color(0xFF31487A)),
                title: Text('Cek Sensor'),
                subtitle: Text('Memeriksa kondisi sensor'),
              ),
              const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mode Otomatis'),
                value: isAuto,
                activeTrackColor: primary,
                onChanged: (value) {
                  setState(() => isAuto = value);
                  setDialogState(() {});
                },
              ),
              const Divider(),
              const Text('Prioritas penggunaan energi'),
              const SizedBox(height: 8),
              const Text(
                'Perangkat penting diprioritaskan saat daya terbatas.',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Selesai', style: TextStyle(color: primary)),
            ),
          ],
        ),
      ),
    );
  }

  void showNotifications() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Notifikasi', style: TextStyle(color: primary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('SoC mendekati batas kritis'),
                value: notifBattery,
                onChanged: (v) {
                  setDialogState(() => notifBattery = v);
                  setState(() {});
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Load shedding aktif'),
                value: notifLoad,
                onChanged: (v) {
                  setDialogState(() => notifLoad = v);
                  setState(() {});
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('ESP32 offline'),
                value: notifEsp,
                onChanged: (v) {
                  setDialogState(() => notifEsp = v);
                  setState(() {});
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Reconnect Wi-Fi gagal'),
                value: notifWifi,
                onChanged: (v) {
                  setDialogState(() => notifWifi = v);
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Selesai', style: TextStyle(color: primary)),
            ),
          ],
        ),
      ),
    );
  }

  void showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bantuan', style: TextStyle(color: primary)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ESP32 offline?'),
            Text('Cek Wi-Fi lalu nyalakan ulang perangkat.'),
            Divider(),
            Text('Kipas tidak menyala?'),
            Text('Periksa mode AUTO atau MANUAL.'),
            Divider(),
            Text('Prediksi error?'),
            Text('Pastikan data sensor masuk dengan normal.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup', style: TextStyle(color: primary)),
          ),
        ],
      ),
    );
  }

  void confirmLogout() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Keluar', style: TextStyle(color: primary)),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari akun?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('Ya, Keluar'),
          ),
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: primary, width: 0.5),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFD9E1F1),
          child: Icon(icon, color: primary),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: primary),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // PROFIL PENGGUNA
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: primary,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  title: Text(
                    'Zahra Aulia',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Pengelola\nzahraaulia@ith.ac.id',
                    style: TextStyle(color: primary),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: primary),
                    onPressed: () {
                      showInfo(
                        'Informasi Akun',
                        'Nama: Zahra Aulia\n'
                        'Role: Pengelola\n'
                        'Email: zahraaulia@ith.ac.id',
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // PENGATURAN SISTEM
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SISTEM SMART MIKRO-GRID',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: Colors.green, size: 12),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'ESP32 Online - 192.168.1.42',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Text(
                            'ONLINE',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Mode Sistem',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAuto
                                    ? primary
                                    : const Color(0xFFD9E1F1),
                                foregroundColor:
                                    isAuto ? Colors.white : primary,
                              ),
                              onPressed: () {
                                setState(() => isAuto = true);
                              },
                              child: const Text('AUTO'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !isAuto
                                    ? primary
                                    : const Color(0xFFD9E1F1),
                                foregroundColor:
                                    !isAuto ? Colors.white : primary,
                              ),
                              onPressed: () {
                                setState(() => isAuto = false);
                              },
                              child: const Text('MANUAL'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Batas krisis baterai',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${batteryLimit.round()}%',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: batteryLimit,
                        min: 10,
                        max: 80,
                        activeColor: primary,
                        onChanged: (value) {
                          setState(() => batteryLimit = value);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // MENU AKUN
              menuItem(
                Icons.person_outline,
                'Informasi Akun',
                () => showInfo(
                  'Informasi Akun',
                  'Nama: Zahra Aulia\n'
                  'Role: Pengelola\n'
                  'Email: zahraaulia@ith.ac.id',
                ),
              ),

              menuItem(
                Icons.settings_outlined,
                'Pengaturan Sistem',
                showSystemSettings,
              ),

              menuItem(
                Icons.notifications_none,
                'Notifikasi',
                showNotifications,
              ),

              menuItem(
                Icons.help_outline,
                'Bantuan',
                showHelp,
              ),

              menuItem(
                Icons.logout,
                'Keluar',
                confirmLogout,
              ),

              const SizedBox(height: 15),

              const Text(
                'Energi Bersih, Masa Depan Lebih Baik',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}