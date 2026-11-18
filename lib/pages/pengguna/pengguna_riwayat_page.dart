
import 'package:flutter/material.dart';

class PenggunaRiwayatPage extends StatefulWidget {
  const PenggunaRiwayatPage({super.key});

  @override
  State<PenggunaRiwayatPage> createState() =>
      _PenggunaRiwayatPageState();
}

class _PenggunaRiwayatPageState extends State<PenggunaRiwayatPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _selectedDate = 'Semua tanggal';
  String _searchQuery = '';

  static const Color navy = Color(0xFF20345F);
  static const Color green = Color(0xFF279B69);

  final List<Map<String, dynamic>> _history = [
    {
      'lampu': 'ON',
      'kipas': 'OFF',
      'tanggal': '18 Nov',
      'jam': '09:00',
      'daya': '1,62 W',
      'soc': 64,
    },
    {
      'lampu': 'ON',
      'kipas': 'OFF',
      'tanggal': '18 Nov',
      'jam': '08:55',
      'daya': '1,55 W',
      'soc': 63,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '18 Nov',
      'jam': '08:50',
      'daya': '1,48 W',
      'soc': 62,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '17 Nov',
      'jam': '16:30',
      'daya': '0,82 W',
      'soc': 48,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '17 Nov',
      'jam': '12:00',
      'daya': '1,90 W',
      'soc': 71,
    },
    {
      'lampu': 'ON',
      'kipas': 'OFF',
      'tanggal': '16 Nov',
      'jam': '09:10',
      'daya': '1,20 W',
      'soc': 55,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '15 Nov',
      'jam': '14:20',
      'daya': '1,74 W',
      'soc': 68,
    },
  ];

  List<Map<String, dynamic>> get _filteredHistory {
    return _history.where((item) {
      final query = _searchQuery.toLowerCase();

      final matchesSearch =
          item['lampu'].toString().toLowerCase().contains(query) ||
          item['kipas'].toString().toLowerCase().contains(query) ||
          item['tanggal'].toString().toLowerCase().contains(query) ||
          item['daya'].toString().toLowerCase().contains(query);

      final matchesDate = _selectedDate == 'Semua tanggal' ||
          item['tanggal'] == _selectedDate;

      return matchesSearch && matchesDate;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                'Riwayat',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Log telemetri berurutan dari yang terbaru',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(height: 14),

              // PENCARIAN
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: navy.withValues(alpha: 0.07),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Cari log (mis. Kipas OFF)',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF5277B7),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // FILTER TANGGAL
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDate,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: navy,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Semua tanggal',
                        child: Text('Semua tanggal'),
                      ),
                      DropdownMenuItem(
                        value: '18 Nov',
                        child: Text('18 November 2026'),
                      ),
                      DropdownMenuItem(
                        value: '17 Nov',
                        child: Text('17 November 2026'),
                      ),
                      DropdownMenuItem(
                        value: '16 Nov',
                        child: Text('16 November 2026'),
                      ),
                      DropdownMenuItem(
                        value: '15 Nov',
                        child: Text('15 November 2026'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedDate = value;
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // DAFTAR RIWAYAT
              ..._filteredHistory.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: _historyCard(item),
                ),
              ),

              if (_filteredHistory.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.history,
                        size: 35,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Riwayat tidak ditemukan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Coba gunakan kata kunci atau tanggal lain.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Riwayat bersifat baca saja, tanpa tombol hapus.',
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyCard(Map<String, dynamic> item) {
    final int soc = item['soc'] as int;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: const Color(0xFFE7ECF5),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.memory,
              color: Color(0xFF5578B5),
              size: 21,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lampu ${item['lampu']} · Kipas ${item['kipas']}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${item['tanggal']} · ${item['jam']} · '
                  'Daya ${item['daya']} · SoC $soc%',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: soc >= 60
                  ? const Color(0xFFE0F3E9)
                  : const Color(0xFFEDF0F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$soc%',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: soc >= 60 ? green : navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
