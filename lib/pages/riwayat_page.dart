import 'package:flutter/material.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  String selectedFilter = 'Semua';
  final List<String> filters = ['Semua', 'ESP32', 'EMS', 'RF'];

  // Data disesuaikan dengan Figma
  final List<Map<String, dynamic>> logs = [
    {
      'kategori': 'ESP32',
      'judul': 'Telemetri INA219 terkirim ke\nserver',
      'waktu': 'ESP32 19 Okt 13:42',
      'status': 'Sukses',
      'icon': Icons.memory,
      'color': const Color(0xFF00A65A),
    },
    {
      'kategori': 'RF',
      'judul': 'Prediksi 2 jam menurun',
      'waktu': 'RF 10 Okt 12:05',
      'status': 'Sukses',
      'icon': Icons.show_chart,
      'color': const Color(0xFF00A65A),
    },
    {
      'kategori': 'ESP32',
      'judul': 'Reconnect Wi-Fi setelah sinyal\nlemah',
      'waktu': 'ESP32 19 Okt 11:30',
      'status': 'Gagal',
      'icon': Icons.wifi_off,
      'color': const Color(0xFFE53935),
    },
    {
      'kategori': 'ESP32',
      'judul': 'Auto-reconnect Wi-Fi berhasil',
      'waktu': 'ESP32 19 Okt 11:35',
      'status': 'Sukses',
      'icon': Icons.wifi,
      'color': const Color(0xFF00A65A),
    },
    {
      'kategori': 'EMS',
      'judul': 'Relay 2 ON, pasokan stabil',
      'waktu': 'EMS 19 Okt 09:15',
      'status': 'Sukses',
      'icon': Icons.bolt,
      'color': const Color(0xFF00A65A),
    },
    {
      'kategori': 'EMS',
      'judul': 'SoC mendekati batas 30%,\nmode hemat',
      'waktu': 'EMS 19 Okt 08:00',
      'status': 'Peringatan',
      'icon': Icons.bolt,
      'color': const Color(0xFFF9A825),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredLogs = selectedFilter == 'Semua'
        ? logs
        : logs.where((log) => log['kategori'] == selectedFilter).toList();

    return Scaffold(
      // Agar gradien bisa menutupi seluruh layar termasuk di bawah Appbar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text(
          'Log Aktifitas',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFF1F2937)),
            onPressed: () {},
          ),
        ],
      ),
      // Menerapkan Gradien langsung ke Body (Container) agar tidak tertimpa navigasi
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD9E1F1), // Putih sangat muda di atas
              Color(0xFF31487A), // Biru gradien yang jelas di bawah
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // 1. Baris IP ESP dan Teks Diperbarui
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPill(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'ESP32 Online  ',
                              style: TextStyle(
                                  color: Color(0xFF00A65A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                            TextSpan(
                              text: '192.168.1.42',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildPill(
                      child: const Text(
                        'Diperbarui tiap 5 detik',
                        style: TextStyle(color: Colors.black54, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // 2. Keterangan Kejadian Sistem
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _buildPill(
                    child: const Text(
                      'Kejadian sistem dari ESP32, EMS, dan RF',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                          fontSize: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // 3. Tab Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: filters.map((filter) {
                      final isActive = selectedFilter == filter;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF28467A)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                filter,
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF1F2937),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Daftar Log Aktivitas (Expanded agar bisa di-scroll)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final log = filteredLogs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF0F6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(log['icon'],
                                color: const Color(0xFF4C75B3), size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  log['judul'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  log['waktu'],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: log['color'], width: 1.0),
                            ),
                            child: Text(
                              log['status'],
                              style: TextStyle(
                                color: log['color'],
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // 5. Tombol Unduh (Kini dikunci paksa di bawah Expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_outlined,
                        color: Color(0xFF28467A), size: 20),
                    label: const Text(
                      'Unduh CSV / Excel',
                      style: TextStyle(
                        color: Color(0xFF28467A),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPill({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
