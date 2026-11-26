import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';
import 'package:smart_mikro_grid/pages/autentikasi/figma_welcome_page.dart';

class AdminAkunPage extends StatefulWidget {
  final User? account;

  const AdminAkunPage({super.key, this.account});

  @override
  State<AdminAkunPage> createState() => _AdminAkunPageState();
}

class _AdminAkunPageState extends State<AdminAkunPage> {
  final Color primary = const Color(0xFF31487A);
  final Color lightBlue = const Color(0xFFD9E1F1);

  bool notifBattery = true;
  bool notifLoad = true;
  bool notifEsp = true;
  bool notifWifi = true;

  final List<bool> checklist = [false, false, false, false];

  String get displayName => widget.account?.name ?? 'Admin Smart Micro-Grid';
  String get displayEmail => widget.account?.email ?? 'admin@ith.ac.id';

  // PANEL BAWAH DENGAN EFEK BLUR
  void openPanel({
    required Widget Function(BuildContext, StateSetter) builder,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Tutup panel',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.pop(dialogContext),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.35),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                  child: StatefulBuilder(
                    builder: (context, setPanelState) {
                      return builder(context, setPanelState);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // HEADER PANEL
  Widget panelHeader(
    String title,
    BuildContext panelContext,
  ) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(panelContext),
              icon: Icon(
                Icons.arrow_back,
                color: primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: primary,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: Color(0xFFCCCCCC),
        ),
      ],
    );
  }

  // BARIS MENU
  Widget menuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: primary,
          width: 0.5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 5,
        ),
        leading: CircleAvatar(
          backgroundColor: lightBlue,
          child: Icon(icon, color: primary),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: primary,
          size: 28,
        ),
        onTap: onTap,
      ),
    );
  }

  // BARIS STATUS INFRASTRUKTUR PADA KARTU SISTEM
  Widget statusSystemRow({
    required String title,
    required String subtitle,
    required String statusText,
    required Color statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: statusColor,
            size: 10,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BARIS PARAMETER PROTEKSI PADA KARTU SISTEM
  Widget protectionParamRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // INFORMASI AKUN
  void showAccountInfo() {
    openPanel(
      builder: (context, setPanelState) {
        return panelContainer(
          context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              panelHeader('Informasi Akun', context),
              const SizedBox(height: 18),
              infoRow('Nama', displayName),
              const Divider(),
              infoRow('Role', 'Admin (Pengelola)'),
              const Divider(),
              infoRow('Email', displayEmail),
              const SizedBox(height: 25),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Selesai',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: primary)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PENGATURAN SISTEM
  void showSystemSettings() {
    openPanel(
      builder: (context, setPanelState) {
        final titles = [
          'Hubungkan ESP32',
          'Cek sensor',
          'Pilih mode operasi EMS',
          'Tentukan prioritas beban',
        ];

        final descriptions = [
          'Wi-Fi dan alamat server, lalu uji koneksi',
          'INA219 ×2, LDR, DHT22 terbaca normal',
          'Mode AUTO (prediksi AI) atau MANUAL melalui halaman Beranda',
          'Relay 1 Kipas DC (Sekunder), Relay 2 Lampu LED (Prioritas)',
        ];

        final icons = [
          Icons.wifi,
          Icons.sensors,
          Icons.tune,
          Icons.electrical_services,
        ];

        return panelContainer(
          context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              panelHeader('Pengaturan Sistem', context),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ketuk langkah untuk menandai selesai',
                  style: TextStyle(
                    color: primary,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ...List.generate(4, (index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setPanelState(() {
                          checklist[index] = !checklist[index];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: checklist[index],
                              activeColor: primary,
                              onChanged: (value) {
                                setPanelState(() {
                                  checklist[index] = value ?? false;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titles[index],
                                    style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    descriptions[index],
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              icons[index],
                              color: primary,
                              size: 26,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFCCCCCC),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 12),
              const Text(
                'ESP32 mengirim data tiap 5 detik. '
                'Sistem menggunakan prediksi daya ke depan '
                'untuk membantu pengelolaan beban baterai.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Selesai',
                  style: TextStyle(
                    color: primary,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // NOTIFIKASI
  void showNotifications() {
    openPanel(
      builder: (context, setPanelState) {
        final notificationTitles = [
          'SoC mendekati batas kritis',
          'Load shedding aktif (Relay 1 Kipas OFF)',
          'ESP32 offline',
          'Reconnect Wi-Fi gagal',
        ];

        final notificationValues = [
          notifBattery,
          notifLoad,
          notifEsp,
          notifWifi,
        ];

        final notificationCallbacks = [
          (bool value) => notifBattery = value,
          (bool value) => notifLoad = value,
          (bool value) => notifEsp = value,
          (bool value) => notifWifi = value,
        ];

        return panelContainer(
          context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              panelHeader('Notifikasi', context),
              const SizedBox(height: 15),
              ...List.generate(4, (index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              notificationTitles[index],
                              style: TextStyle(
                                color: primary,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Switch(
                            value: notificationValues[index],
                            activeTrackColor: primary,
                            onChanged: (value) {
                              setPanelState(() {
                                notificationCallbacks[index](value);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFCCCCCC),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Selesai',
                  style: TextStyle(
                    color: primary,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // BANTUAN
  void showHelp() {
    openPanel(
      builder: (context, setPanelState) {
        return panelContainer(
          context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              panelHeader('Bantuan', context),
              helpRow(
                'ESP32 offline?',
                'Cek koneksi Wi-Fi lalu nyalakan ulang perangkat.',
              ),
              helpRow(
                'Relay 1 (Kipas DC) tidak menyala?',
                'Pada mode AUTO, EMS memutus kipas saat SoC mendekati kritis.',
              ),
              helpRow(
                'Prediksi daya (Ppred) turun?',
                'Potensi daya surya ke depan diprediksi menurun.',
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlue,
                    foregroundColor: primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    showInfoDialog(
                      'Hubungi Pengelola',
                      'Silakan hubungi tim pengembang Smart Micro-Grid ITH '
                          'untuk mendapatkan bantuan teknis lebih lanjut.',
                    );
                  },
                  child: const Text(
                    'Hubungi Pengelola',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget helpRow(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            question,
            style: TextStyle(
              color: primary,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            answer,
            style: TextStyle(
              color: primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Divider(
          thickness: 1,
          color: Color(0xFFCCCCCC),
        ),
      ],
    );
  }

  // DIALOG INFORMASI
  void showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: primary),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Tutup',
              style: TextStyle(color: primary),
            ),
          ),
        ],
      ),
    );
  }

  // KELUAR -> Kembali ke layar Welcome
  void confirmLogout() {
    openPanel(
      builder: (panelContext, setPanelState) {
        return panelContainer(
          panelContext,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              panelHeader('Keluar', panelContext),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Anda perlu login lagi untuk memantau dan mengelola sistem.',
                  style: TextStyle(
                    color: primary,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlue,
                    foregroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
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
                  child: const Text(
                    'Ya, Keluar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(panelContext),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // BENTUK PANEL
  Widget panelContainer(
    BuildContext context, {
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 55,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              child,
            ],
          ),
        ),
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
              // PROFIL
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
                    displayName,
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Admin (Pengelola)\n$displayEmail',
                    style: TextStyle(color: primary),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: primary),
                    onPressed: showAccountInfo,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // KARTU STATUS INFRASTRUKTUR & PARAMETER PROTEKSI EMS
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SISTEM SMART MICRO-GRID',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      statusSystemRow(
                        title: 'Node ESP32',
                        subtitle: '192.168.1.42 • Akuisisi tiap 5 detik',
                        statusText: 'ONLINE',
                        statusColor: Colors.green.shade700,
                      ),
                      statusSystemRow(
                        title: 'Server Flask & Model AI',
                        subtitle: 'Random Forest Regressor (Port 5000)',
                        statusText: 'AKTIF',
                        statusColor: Colors.green.shade700,
                      ),
                      statusSystemRow(
                        title: 'Firebase Realtime Database',
                        subtitle: 'Sinkronisasi telemetri & log riwayat',
                        statusText: 'SINKRON',
                        statusColor: primary,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          thickness: 1,
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                      Text(
                        'Parameter Proteksi Baterai (Firmware & EMS)',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      protectionParamRow('Fail-Safe Lokal (ESP32)', '30% SoC'),
                      protectionParamRow('Hard Protection Cut-Off', '10% SoC'),
                      protectionParamRow('Histeresis Pemulihan', '5% SoC'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // MENU AKUN
              menuItem(
                Icons.person_outline,
                'Informasi Akun',
                showAccountInfo,
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

              const SizedBox(height: 20),

              const Text(
                'Energi Bersih, Masa Depan Lebih Baik',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
