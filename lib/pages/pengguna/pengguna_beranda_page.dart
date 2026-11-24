import 'package:flutter/material.dart';

class PenggunaBerandaPage extends StatelessWidget {
  const PenggunaBerandaPage({super.key});

  static const Color navy = Color(0xFF20345F);
  static const Color blue = Color(0xFF6E8FCB);
  static const Color green = Color(0xFF279B69);

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
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monitoring Utama',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Rabu, 18 November 2026 • Data monitoring',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 16),

              // STATUS SISTEM
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Status sistem'),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _statusChip('ESP32 Online', green),
                        _statusChip('Mode: Otomatis EMS', navy),
                        _statusChip(
                          'Proteksi baterai normal',
                          green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Sistem Smart Micro-Grid sedang berjalan. '
                      'Status energi ditampilkan secara berkala.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // BATERAI INA219-2
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Baterai • INA219-2'),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          height: 105,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SizedBox(
                                width: 96,
                                height: 96,
                                child: CircularProgressIndicator(
                                  value: 0.62,
                                  strokeWidth: 9,
                                  backgroundColor: Color(0xFFE1E7F1),
                                  valueColor:
                                      AlwaysStoppedAnimation(navy),
                                ),
                              ),
                              const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '62%',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: navy,
                                    ),
                                  ),
                                  Text(
                                    'SoC',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Column(
                            children: [
                              _SensorRow(
                                'Tegangan',
                                '3,86 V',
                              ),
                              _SensorRow(
                                'Arus',
                                '0,12 A',
                              ),
                              _SensorRow(
                                'Status',
                                'Charging',
                                valueColor: green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Batas kritis',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            '30% (Aman)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // PANEL SURYA INA219-1
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Panel Surya • INA219-1'),
                    const SizedBox(height: 12),
                    const Text(
                      '1,62 W',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    const Text(
                      'Daya keluaran aktual',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: Color(0xFFE1E5ED)),
                    const _SensorRow(
                      'Tegangan panel',
                      '5,82 V',
                    ),
                    const _SensorRow(
                      'Arus panel',
                      '0,28 A',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // LINGKUNGAN
              Row(
                children: [
                  Expanded(
                    child: _environmentCard(
                      icon: Icons.wb_sunny_outlined,
                      iconColor: const Color(0xFFE5A52A),
                      value: '74%',
                      label: 'Cahaya (LDR)',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _environmentCard(
                      icon: Icons.thermostat,
                      iconColor: blue,
                      value: '31,2 °C',
                      label: 'Suhu udara (DHT22)',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // STATUS BEBAN
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Status beban'),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _relayBox(
                            'Relay lampu',
                            'Menyala',
                            true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _relayBox(
                            'Relay kipas',
                            'Mati',
                            false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Pengguna hanya dapat melihat status beban. '
                      'Pengaturan relay hanya tersedia untuk Admin.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // GRAFIK DAYA
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading(
                      'Daya produksi vs daya beban (W)',
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _EnergyChartPainter(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Legend(
                          color: navy,
                          text: 'Produksi panel',
                        ),
                        SizedBox(width: 20),
                        _Legend(
                          color: Color(0xFFE59A21),
                          text: 'Beban terpakai',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Center(
                child: Text(
                  'Energi bersih, masa depan lebih baik',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // KARTU UTAMA
  static Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(19),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.07),
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  // JUDUL KARTU
  static Widget _heading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: navy,
      ),
    );
  }

  // STATUS CHIP
  static Widget _statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  // KARTU LINGKUNGAN
  static Widget _environmentCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      height: 135,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.06),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 27,
          ),
          const SizedBox(height: 9),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // STATUS RELAY
  static Widget _relayBox(
    String title,
    String status,
    bool active,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 11,
                color: active ? green : Colors.blueGrey,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// BARIS INFORMASI SENSOR
class _SensorRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _SensorRow(
    this.title,
    this.value, {
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: valueColor ?? PenggunaBerandaPage.navy,
            ),
          ),
        ],
      ),
    );
  }
}

// LEGENDA GRAFIK
class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

// GRAFIK ENERGI
class _EnergyChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const left = 25.0;
    const top = 12.0;
    const bottom = 27.0;

    final chartWidth = size.width - left - 8;
    final chartHeight = size.height - top - bottom;

    final gridPaint = Paint()
      ..color = const Color(0xFFDCE2EC)
      ..strokeWidth = 1;

    final productionPaint = Paint()
      ..color = PenggunaBerandaPage.navy
      ..strokeWidth = 2.7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final loadPaint = Paint()
      ..color = const Color(0xFFE59A21)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i <= 2; i++) {
      final y = top + chartHeight * i / 2;

      canvas.drawLine(
        Offset(left, y),
        Offset(size.width - 5, y),
        gridPaint,
      );

      final painter = TextPainter(
        text: TextSpan(
          text: '${2 - i}',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      painter.paint(canvas, Offset(3, y - 6));
    }

    final production = [
      0.3, 0.9, 1.6, 1.9, 1.5, 0.9, 0.2,
    ];

    final load = [
      0.6, 0.8, 0.85, 0.8, 0.75, 0.85, 0.65,
    ];

    Path makePath(List<double> values) {
      final path = Path();

      for (int i = 0; i < values.length; i++) {
        final x = left + chartWidth * i / (values.length - 1);
        final y = top + chartHeight * (1 - values[i] / 2);

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      return path;
    }

    canvas.drawPath(makePath(production), productionPaint);
    canvas.drawPath(makePath(load), loadPaint);

    const hours = ['06', '08', '10', '12', '14', '16', '18'];

    for (int i = 0; i < hours.length; i++) {
      final x = left + chartWidth * i / (hours.length - 1);

      final painter = TextPainter(
        text: TextSpan(
          text: hours[i],
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      painter.paint(
        canvas,
        Offset(x - 6, size.height - 17),
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}