
import 'package:flutter/material.dart';

class PenggunaModelAiPage extends StatelessWidget {
  const PenggunaModelAiPage({super.key});

  static const Color navy = Color(0xFF20345F);
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
                'Prediksi Daya',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Random Forest Regressor • model_rf.joblib',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(height: 14),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Hasil prediksi'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _predictionBox(
                            'Prediksi berikutnya (PPred)',
                            '1,71 W',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _predictionBox(
                            'Daya aktual saat ini',
                            '1,62 W',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Selisih 0,09 W • tren meningkat',
                      style: TextStyle(
                        color: green,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
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
                    _heading('Aktual vs prediksi (W)'),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 175,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _PredictionChartPainter(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Legend(color: navy, text: 'Sensor nyata'),
                        SizedBox(width: 18),
                        _Legend(
                          color: Color(0xFF91A8CC),
                          text: 'Prediksi AI',
                          dashed: true,
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
                    _heading('Variabel masukan model'),
                    const SizedBox(height: 10),
                    const _VariableRow('Intensitas cahaya (LDR)', '0–100 %'),
                    const _VariableRow('Suhu udara (DHT22)', '°C'),
                    const _VariableRow('Tegangan panel', 'V'),
                    const _VariableRow('Arus panel', 'mA'),
                    const _VariableRow(
                      'Keluaran',
                      'PPred (W)',
                      last: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Akurasi model pada data uji'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _metricBox('R²', '0,93')),
                        const SizedBox(width: 8),
                        Expanded(child: _metricBox('MAE', '0,07 W')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RMSE',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          '0,11 W',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Prediksi energi berbasis Machine Learning',
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
        color: Colors.white.withValues(alpha: 0.95),
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

  static Widget _predictionBox(String title, String value) {
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
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _metricBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
        ],
      ),
    );
  }
}

class _VariableRow extends StatelessWidget {
  final String title;
  final String value;
  final bool last;

  const _VariableRow(
    this.title,
    this.value, {
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFE1E5ED)),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: PenggunaModelAiPage.navy,
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
  final bool dashed;

  const _Legend({
    required this.color,
    required this.text,
    this.dashed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          height: 4,
          child: CustomPaint(
            painter: _LegendPainter(color: color, dashed: dashed),
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

class _LegendPainter extends CustomPainter {
  final Color color;
  final bool dashed;

  _LegendPainter({required this.color, required this.dashed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5;

    if (!dashed) {
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    } else {
      for (double x = 0; x < size.width; x += 5) {
        canvas.drawLine(
          Offset(x, size.height / 2),
          Offset(x + 3, size.height / 2),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LegendPainter oldDelegate) => false;
}

class _PredictionChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const left = 25.0;
    const top = 12.0;
    const bottom = 25.0;

    final width = size.width - left - 8;
    final height = size.height - top - bottom;

    final gridPaint = Paint()
      ..color = const Color(0xFFDCE2EC)
      ..strokeWidth = 1;

    for (int i = 0; i <= 2; i++) {
      final y = top + height * i / 2;
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

    final actual = [0.35, 0.95, 1.65, 1.92, 1.55, 0.95, 0.25];
    final predicted = [0.32, 1.02, 1.72, 1.82, 1.48, 0.88, 0.30];

    Path makePath(List<double> values) {
      final path = Path();

      for (int i = 0; i < values.length; i++) {
        final x = left + width * i / (values.length - 1);
        final y = top + height * (1 - values[i] / 2);

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      return path;
    }

    final actualPaint = Paint()
      ..color = PenggunaModelAiPage.navy
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final predictedPaint = Paint()
      ..color = const Color(0xFF91A8CC)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(makePath(actual), actualPaint);

    final predictedPath = makePath(predicted);
    final dashedPath = Path();

    for (final metric in predictedPath.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final end = (distance + 5).clamp(0.0, metric.length);
        dashedPath.addPath(
          metric.extractPath(distance, end),
          Offset.zero,
        );
        distance += 8;
      }
    }

    canvas.drawPath(dashedPath, predictedPaint);

    const hours = ['06', '08', '10', '12', '14', '16', '18'];

    for (int i = 0; i < hours.length; i++) {
      final x = left + width * i / (hours.length - 1);
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
  bool shouldRepaint(covariant _PredictionChartPainter oldDelegate) =>
      false;
}
