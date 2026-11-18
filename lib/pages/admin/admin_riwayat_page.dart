import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _LogItem {
  final String kategori;
  final String judul;
  final String deskripsi;
  final String waktu;
  final String status;
  final IconData icon;
  final Color color;

  const _LogItem({
    required this.kategori,
    required this.judul,
    required this.deskripsi,
    required this.waktu,
    required this.status,
    required this.icon,
    required this.color,
  });
}

class AdminRiwayatPage extends StatefulWidget {
  const AdminRiwayatPage({super.key});

  @override
  State<AdminRiwayatPage> createState() => _AdminRiwayatPageState();
}

class _AdminRiwayatPageState extends State<AdminRiwayatPage> {
  String selectedFilter = 'Semua';
  final List<String> filters = ['Semua', 'ESP32', 'EMS', 'RF'];

  static const List<_LogItem> _logs = [
    _LogItem(
      kategori: 'ESP32',
      judul: 'Telemetri Sensor Terkirim',
      deskripsi:
          'Data INA219 (2x), LDR & DHT22 diterima server (interval 5 dtk)',
      waktu: 'Hari ini • 13:42',
      status: 'Sukses',
      icon: Icons.sensors_rounded,
      color: Color(0xFF00A65A),
    ),
    _LogItem(
      kategori: 'RF',
      judul: 'Prediksi Daya 30 Menit Menurun',
      deskripsi: 'Estimasi suplai surya Ppred = 0,94 W (awan terdeteksi)',
      waktu: 'Hari ini • 13:35',
      status: 'Sukses',
      icon: Icons.show_chart_rounded,
      color: Color(0xFF00A65A),
    ),
    _LogItem(
      kategori: 'EMS',
      judul: 'Relay 1 (Kipas DC) Diputus Otomatis',
      deskripsi:
          'Predictive load shedding aktif — proteksi baterai Li-ion 18650',
      waktu: 'Hari ini • 13:30',
      status: 'Peringatan',
      icon: Icons.bolt_rounded,
      color: Color(0xFFF59E0B),
    ),
    _LogItem(
      kategori: 'ESP32',
      judul: 'Koneksi Wi-Fi Terputus Sementara',
      deskripsi: 'Mencoba menghubungkan ulang ke jaringan lokal...',
      waktu: 'Hari ini • 11:30',
      status: 'Gagal',
      icon: Icons.wifi_off_rounded,
      color: Color(0xFFE53935),
    ),
    _LogItem(
      kategori: 'ESP32',
      judul: 'Auto-Reconnect Wi-Fi Berhasil',
      deskripsi: 'Perangkat kembali terhubung di IP 192.168.1.42',
      waktu: 'Hari ini • 11:35',
      status: 'Sukses',
      icon: Icons.wifi_rounded,
      color: Color(0xFF00A65A),
    ),
    _LogItem(
      kategori: 'EMS',
      judul: 'Relay 2 (Lampu LED) Dipertahankan ON',
      deskripsi: 'Beban prioritas tetap menyala, tegangan baterai aman',
      waktu: 'Hari ini • 09:15',
      status: 'Sukses',
      icon: Icons.lightbulb_outline_rounded,
      color: Color(0xFF00A65A),
    ),
  ];

  String _generateLogCsv(List<_LogItem> items) {
    final buffer = StringBuffer();
    buffer.writeln('Kategori,Waktu,Kejadian,Detail,Status');
    for (final item in items) {
      final cleanTitle = item.judul.replaceAll(',', ';');
      final cleanDesc = item.deskripsi.replaceAll(',', ';');
      buffer.writeln(
        '${item.kategori},${item.waktu},$cleanTitle,$cleanDesc,${item.status}',
      );
    }
    return buffer.toString();
  }

  void _showExportCsvDialog(List<_LogItem> items) {
    final csvData = _generateLogCsv(items);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          'Laporan Log CSV ($selectedFilter)',
          style: const TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
            fontSize: 16.5,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Menampilkan ${items.length} catatan aktivitas siap diekspor:',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Text(
                  csvData,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: csvData));
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Data CSV ($selectedFilter) berhasil disalin ke clipboard.',
                  ),
                  backgroundColor: const Color(0xFF00A65A),
                ),
              );
            },
            icon: const Icon(Icons.copy_rounded, size: 17),
            label: const Text('Salin CSV'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<_LogItem> filteredLogs = selectedFilter == 'Semua'
        ? _logs
        : _logs.where((log) => log.kategori == selectedFilter).toList();

    final int countSukses =
        _logs.where((item) => item.status == 'Sukses').length;
    final int countPeringatan =
        _logs.where((item) => item.status == 'Peringatan').length;
    final int countGagal = _logs.where((item) => item.status == 'Gagal').length;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAF1FB),
              Color(0xFF31487A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Judul & Tombol Refresh
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 12, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log Aktivitas Sistem',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Rekam jejak telemetri ESP32, keputusan EMS & AI',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      tooltip: 'Muat ulang log',
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Color(0xFF1E3A8A),
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Log aktivitas terbaru dimuat.'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // 2. Baris Status Koneksi ESP32
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPill(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Color(0xFF00A65A),
                            size: 9,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'ESP32 Online • 192.168.1.42',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w600,
                              fontSize: 10.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPill(
                      child: const Text(
                        'Interval 5 detik',
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w600,
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Kartu Ringkasan Status (Sukses, Peringatan, Gagal)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSummaryChip(
                        label: 'Sukses',
                        count: countSukses,
                        color: const Color(0xFF00A65A),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildSummaryChip(
                        label: 'Peringatan',
                        count: countPeringatan,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildSummaryChip(
                        label: 'Gagal',
                        count: countGagal,
                        color: const Color(0xFFE53935),
                      ),
                    ),
                  ],
                ),
              ),

              // 4. Tab Filter Kategori (FR15)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: filters.map((filter) {
                      final bool isActive = selectedFilter == filter;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedFilter = filter),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF1E3A8A)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                filter,
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF334155),
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
              const SizedBox(height: 12),

              // 5. Daftar Kartu Log Aktivitas (FR14)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final item = filteredLogs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF1FB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              item.icon,
                              color: const Color(0xFF1E3A8A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.kategori,
                                        style: const TextStyle(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E3A8A),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      item.waktu,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  item.judul,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item.deskripsi,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF475569),
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: item.color, width: 1.1),
                            ),
                            child: Text(
                              item.status,
                              style: TextStyle(
                                color: item.color,
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

              // 6. Tombol Unduh Log CSV (FR16)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    onPressed: () => _showExportCsvDialog(filteredLogs),
                    icon: const Icon(
                      Icons.download_rounded,
                      color: Color(0xFF1E3A8A),
                      size: 20,
                    ),
                    label: const Text(
                      'Unduh Log CSV',
                      style: TextStyle(
                        color: Color(0xFF1E3A8A),
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
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

  Widget _buildSummaryChip({
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: child,
    );
  }
}
