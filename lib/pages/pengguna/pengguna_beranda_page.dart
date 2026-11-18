
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monitoring Utama',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Rabu, 18 November 2026 • Data monitoring',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(height: 14),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Status sistem'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _statusChip('ESP32 Online', green),
                        _statusChip('Mode: Otomatis EMS', navy),
                        _statusChip('Proteksi baterai normal', green),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sistem Smart Micro-Grid sedang berjalan. '
                      'Status energi ditampilkan secara berkala.',
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

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Panel surya • INA219-1'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _valueBox(
                            'Tegangan',
                            '5,82 V',
                            Icons.bolt,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _valueBox(
                            'Arus',
                            '0,28 A',
                            Icons.electric_bolt,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daya keluaran aktual',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '1,62 W',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Baterai • INA219-2'),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        SizedBox(
                          width: 92,
                          height: 92,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SizedBox(
                                width: 82,
                                height: 82,
                                child: CircularProgressIndicator(
                                  value: 0.62,
                                  strokeWidth: 8,
                                  backgroundColor: Color(0xFFE1E7F1),
                                  valueColor:
                                      AlwaysStoppedAnimation(navy),
                                ),
                              ),
                              const Text(
                                '62%',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: navy,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            children: [
                              _InfoRow('Tegangan', '3,86 V'),
                              _InfoRow('Arus', '0,12 A'),
                              _InfoRow(
                                'Status',
                                'Charging',
                                valueColor: green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Lingkungan'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _valueBox(
                            'Suhu sekitar • DHT22',
                            '31,2 °C',
                            Icons.thermostat,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _valueBox(
                            'Cahaya • LDR',
                            '74 %',
                            Icons.wb_sunny_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Status beban'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _relayBox('Relay lampu', 'Menyala', true),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _relayBox('Relay kipas', 'Mati', false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Hanya indikator. Pengguna tidak dapat mengubah '
                      'status beban.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Daya produksi vs daya beban (W)'),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _EnergyChartPainter(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Legend(color: navy, text: 'Produksi panel'),
                        SizedBox(width: 18),
                        _Legend(
                          color: Color(0xFFE59A21),
                          text: 'Beban terpakai',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
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

  static Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  static Widget _heading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: navy,
      ),
    );
  }

  static Widget _statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  static Widget _valueBox(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Icon(icon, size: 15, color: blue),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _relayBox(String title, String status, bool active) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: active ? green : Colors.blueGrey,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            status,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _InfoRow(
    this.title,
    this.value, {
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: valueColor ?? PenggunaBerandaPage.navy,
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 13,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: Colors.black54),
        ),
      ],
    );
  }
}

class _EnergyChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const left = 24.0;
    const top = 10.0;
    const bottom = 25.0;

    final chartWidth = size.width - left - 8;
    final chartHeight = size.height - top - bottom;

    final gridPaint = Paint()
      ..color = const Color(0xFFDCE2EC)
      ..strokeWidth = 1;

    final productionPaint = Paint()
      ..color = PenggunaBerandaPage.navy
      ..strokeWidth = 2.5
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
          style: const TextStyle(fontSize: 9, color: Colors.black54),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      painter.paint(canvas, Offset(3, y - 6));
    }

    final production = [0.3, 0.9, 1.6, 1.9, 1.5, 0.9, 0.2];
    final load = [0.6, 0.8, 0.85, 0.8, 0.75, 0.85, 0.65];

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
          style: const TextStyle(fontSize: 9, color: Colors.black54),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      painter.paint(canvas, Offset(x - 6, size.height - 16));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
