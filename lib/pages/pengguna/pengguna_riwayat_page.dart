import 'package:flutter/material.dart';

class PenggunaRiwayatPage extends StatefulWidget {
  const PenggunaRiwayatPage({super.key});

  @override
  State<PenggunaRiwayatPage> createState() =>
      _PenggunaRiwayatPageState();
}

class _PenggunaRiwayatPageState
    extends State<PenggunaRiwayatPage> {
  final TextEditingController _searchController =
      TextEditingController();

  static const Color navy = Color(0xFF20345F);
  static const Color blue = Color(0xFF2456A6);
  static const Color green = Color(0xFF279B69);

  String _searchQuery = '';

  DateTime _focusedMonth = DateTime(2026, 11);
  DateTime? _selectedDate;

  final List<Map<String, dynamic>> _history = [
    {
      'lampu': 'ON',
      'kipas': 'OFF',
      'tanggal': '18 Nov',
      'jam': '09:00',
      'date': DateTime(2026, 11, 18),
      'daya': '1,62 W',
      'soc': 64,
    },
    {
      'lampu': 'ON',
      'kipas': 'OFF',
      'tanggal': '18 Nov',
      'jam': '08:55',
      'date': DateTime(2026, 11, 18),
      'daya': '1,55 W',
      'soc': 63,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '18 Nov',
      'jam': '08:50',
      'date': DateTime(2026, 11, 18),
      'daya': '1,48 W',
      'soc': 62,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '17 Nov',
      'jam': '16:30',
      'date': DateTime(2026, 11, 17),
      'daya': '0,82 W',
      'soc': 48,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '17 Nov',
      'jam': '12:00',
      'date': DateTime(2026, 11, 17),
      'daya': '1,90 W',
      'soc': 71,
    },
    {
      'lampu': 'ON',
      'kipas': 'OFF',
      'tanggal': '16 Nov',
      'jam': '09:10',
      'date': DateTime(2026, 11, 16),
      'daya': '1,20 W',
      'soc': 55,
    },
    {
      'lampu': 'ON',
      'kipas': 'ON',
      'tanggal': '15 Nov',
      'jam': '14:20',
      'date': DateTime(2026, 11, 15),
      'daya': '1,74 W',
      'soc': 68,
    },
  ];

  final List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  final List<String> _weekDays = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  final List<String> _fullWeekDays = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  DateTime get _today {
    return DateTime.now();
  }

  String get _monthTitle {
    return '${_monthNames[_focusedMonth.month - 1]} '
        '${_focusedMonth.year}';
  }

  bool _hasHistory(int day) {
    return _history.any((item) {
      final date = item['date'] as DateTime;

      return date.year == _focusedMonth.year &&
          date.month == _focusedMonth.month &&
          date.day == day;
    });
  }

  List<Map<String, dynamic>> get _filteredHistory {
    return _history.where((item) {
      final query = _searchQuery.toLowerCase();

      final matchesSearch =
          item['lampu'].toString().toLowerCase().contains(query) ||
          item['kipas'].toString().toLowerCase().contains(query) ||
          item['tanggal'].toString().toLowerCase().contains(query) ||
          item['daya'].toString().toLowerCase().contains(query);

      final date = item['date'] as DateTime;

      final matchesDate = _selectedDate == null ||
          _sameDay(date, _selectedDate!);

      return matchesSearch && matchesDate;
    }).toList();
  }

  String _formatSelectedDate() {
    if (_selectedDate == null) {
      return 'Semua tanggal';
    }

    final weekday = _fullWeekDays[_selectedDate!.weekday - 1];
    final month = _monthNames[_selectedDate!.month - 1];

    return '$weekday, ${_selectedDate!.day} $month '
        '${_selectedDate!.year}';
  }

  void _changeMonth(int amount) {
    setState(() {
      _focusedMonth = DateTime(
        _focusedMonth.year,
        _focusedMonth.month + amount,
      );

      _selectedDate = null;
    });
  }

  void _selectDate(int day) {
    setState(() {
      _selectedDate = DateTime(
        _focusedMonth.year,
        _focusedMonth.month,
        day,
      );
    });
  }

  void _showAllDates() {
    setState(() {
      _selectedDate = null;
    });
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
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Log telemetri berurutan dari yang terbaru',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 14),

              // PENCARIAN
              _buildSearch(),

              const SizedBox(height: 12),

              // KALENDER
              _buildCalendar(),

              const SizedBox(height: 12),

              // TANGGAL TERPILIH
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatSelectedDate(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _showAllDates,
                    child: const Text(
                      'Semua tanggal',
                      style: TextStyle(
                        color: blue,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                '${_filteredHistory.length} data riwayat ditemukan',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 10),

              // DAFTAR RIWAYAT
              ..._filteredHistory.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: _historyCard(item),
                ),
              ),

              if (_filteredHistory.isEmpty)
                _emptyHistory(),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  'Riwayat bersifat baca saja, tanpa tombol hapus.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PENCARIAN
  Widget _buildSearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
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
          prefixIcon: Icon(
            Icons.search,
            color: blue,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // KALENDER
  Widget _buildCalendar() {
    final firstDay = DateTime(
      _focusedMonth.year,
      _focusedMonth.month,
      1,
    );

    final totalDays = DateTime(
      _focusedMonth.year,
      _focusedMonth.month + 1,
      0,
    ).day;

    final startOffset = firstDay.weekday - 1;
    final totalCells = ((startOffset + totalDays + 6) ~/ 7) * 7;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER BULAN
          Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => _changeMonth(-1),
                icon: const Icon(
                  Icons.chevron_left,
                  color: blue,
                  size: 25,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    _monthTitle,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => _changeMonth(1),
                icon: const Icon(
                  Icons.chevron_right,
                  color: blue,
                  size: 25,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // NAMA HARI
          Row(
            children: List.generate(7, (index) {
              return Expanded(
                child: Center(
                  child: Text(
                    _weekDays[index],
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 7),

          // TANGGAL
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 2,
              crossAxisSpacing: 1,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final day = index - startOffset + 1;

              if (day < 1 || day > totalDays) {
                return const SizedBox();
              }

              final date = DateTime(
                _focusedMonth.year,
                _focusedMonth.month,
                day,
              );

              final isSelected = _selectedDate != null &&
                  _sameDay(date, _selectedDate!);

              final isToday = _sameDay(date, _today);
              final hasHistory = _hasHistory(day);

              return InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => _selectDate(day),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? blue : Colors.transparent,
                        shape: BoxShape.circle,
                        border: isToday && !isSelected
                            ? Border.all(
                                color: blue,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected || isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : navy,
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: hasHistory
                            ? blue
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 7),

          // KETERANGAN
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 14,
            runSpacing: 5,
            children: [
              _calendarLegend(
                color: blue,
                label: 'Ada riwayat',
              ),
              _calendarLegend(
                color: Colors.white,
                border: true,
                label: 'Hari ini',
              ),
              _calendarLegend(
                color: blue,
                label: 'Dipilih',
                isSelected: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calendarLegend({
    required Color color,
    required String label,
    bool border = false,
    bool isSelected = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: border
                ? Border.all(color: blue, width: 1.3)
                : null,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // KARTU RIWAYAT
  Widget _historyCard(Map<String, dynamic> item) {
    final int soc = item['soc'] as int;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE7ECF5),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.memory,
              color: Color(0xFF5578B5),
              size: 22,
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

  // RIWAYAT KOSONG
  Widget _emptyHistory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
          SizedBox(height: 5),
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
    );
  }
}