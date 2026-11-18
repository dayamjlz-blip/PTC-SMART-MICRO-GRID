import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/utils/figma_colors.dart';

class AdminAnalisisPage extends StatefulWidget {
  const AdminAnalisisPage({super.key});

  @override
  State<AdminAnalisisPage> createState() => _AdminAnalisisPageState();
}

class _AdminAnalisisPageState extends State<AdminAnalisisPage> {
  int tabIndex = 0;

  final List<String> tabs = ['Hari ini', '7 hari', 'Bulan ini'];

  // Label sumbu X per rentang waktu
  final List<List<String>> labels = [
    ['06', '08', '10', '12', '14', '16', '18'],
    ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
    ['1', '5', '10', '15', '20', '25', '30'],
  ];

  // Data Daya Riil Terukur INA219 Panel Surya (Watt)
  final List<List<double>> dayaRiil = [
    [0.35, 0.78, 1.25, 1.62, 1.40, 0.92, 0.42],
    [1.15, 1.32, 0.95, 1.54, 1.41, 1.05, 1.28],
    [1.08, 1.24, 1.45, 1.30, 1.60, 1.52, 1.68],
  ];

  // Data Daya Prediksi AI Random Forest 30 Menit ke Depan (Watt)
  final List<List<double>> dayaPrediksiAi = [
    [0.30, 0.72, 1.18, 1.55, 1.35, 0.88, 0.48],
    [1.10, 1.28, 1.02, 1.48, 1.38, 1.10, 1.22],
    [1.05, 1.20, 1.40, 1.34, 1.55, 1.49, 1.63],
  ];

  // Data Riwayat Kapasitas Baterai / SoC (%)
  final List<List<double>> riwayatSoc = [
    [45, 52, 68, 84, 79, 63, 48],
    [62, 70, 54, 81, 76, 58, 72],
    [60, 66, 74, 69, 82, 78, 85],
  ];

  // Membuat string CSV dari tab yang sedang aktif (FR16)
  String _buildCsvContent() {
    final buffer = StringBuffer();
    buffer.writeln('Waktu,Daya_Riil_W,Prediksi_AI_30Mnt_W,SoC_Baterai_Persen');
    for (int i = 0; i < labels[tabIndex].length; i++) {
      buffer.writeln(
        '${labels[tabIndex][i]},'
        '${dayaRiil[tabIndex][i].toStringAsFixed(2)},'
        '${dayaPrediksiAi[tabIndex][i].toStringAsFixed(2)},'
        '${riwayatSoc[tabIndex][i].toInt()}%',
      );
    }
    return buffer.toString();
  }

  void _showCsvExportDialog() {
    final csvText = _buildCsvContent();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Laporan CSV (${tabs[tabIndex]})',
          style: const TextStyle(
            color: FigmaColors.blueDark,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Data telemetri siap diekspor ke penyimpanan perangkat:',
                style: TextStyle(fontSize: 12.5, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  csvText,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
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
              backgroundColor: FigmaColors.blueDark,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Laporan_${tabs[tabIndex].replaceAll(" ", "_")}.csv berhasil disiapkan.',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.check, size: 18),
            label: const Text('Simpan CSV'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(gradient: FigmaColors.backgroundGradient),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              const Text(
                'Analitik',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: FigmaColors.blueDark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Perbandingan daya riil vs prediksi AI dan riwayat SoC',
                style: TextStyle(color: FigmaColors.grey),
              ),
              const SizedBox(height: 16),
              _tabToggle(),
              const SizedBox(height: 16),

              // KARTU 1: GRAFIK GARIS DAYA RIIL VS PREDIKSI AI (FR8)
              _card(
                title: 'Daya Riil vs Prediksi AI 30 Menit (W)',
                subtitle: Row(
                  children: [
                    _legendDot(FigmaColors.blueDark, 'Daya Riil (W)'),
                    const SizedBox(width: 16),
                    _legendDot(Colors.orange.shade700, 'Prediksi AI (Ppred)'),
                  ],
                ),
                child: SizedBox(height: 200, child: _lineChart()),
              ),
              const SizedBox(height: 16),

              // KARTU 2: GRAFIK BATANG RIWAYAT SOC BATERAI (%)
              _card(
                title: 'Riwayat Kapasitas Baterai / SoC (%)',
                subtitle: Row(
                  children: [
                    _legendDot(FigmaColors.blueDark, 'SoC Baterai (%)'),
                    const SizedBox(width: 16),
                    _legendDot(Colors.red, 'Batas Kritis (30%)'),
                  ],
                ),
                child: SizedBox(height: 200, child: _barChart()),
              ),
              const SizedBox(height: 16),

              // TOMBOL EKSPOR CSV (FR16)
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FigmaColors.blueDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _showCsvExportDialog,
                  icon: const Icon(Icons.download_rounded),
                  label: const Text(
                    'Unduh Laporan CSV',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 11.5, color: FigmaColors.grey),
        ),
      ],
    );
  }

  Widget _tabToggle() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = tabIndex == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => tabIndex = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active ? FigmaColors.blueDark : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    color: active ? Colors.white : FigmaColors.blueDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _card({
    required String title,
    Widget? subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: FigmaColors.blueDark,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            subtitle,
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  FlTitlesData _powerTitles() {
    const style = TextStyle(fontSize: 11, color: FigmaColors.grey);
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 34,
          interval: 0.5,
          getTitlesWidget: (value, meta) =>
              Text(value.toStringAsFixed(1), style: style),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final i = value.toInt();
            final list = labels[tabIndex];
            if (i < 0 || i >= list.length) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(list[i], style: style),
            );
          },
        ),
      ),
    );
  }

  FlTitlesData _socTitles() {
    const style = TextStyle(fontSize: 11, color: FigmaColors.grey);
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 36,
          interval: 25,
          getTitlesWidget: (value, meta) =>
              Text('${value.toInt()}%', style: style),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final i = value.toInt();
            final list = labels[tabIndex];
            if (i < 0 || i >= list.length) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(list[i], style: style),
            );
          },
        ),
      ),
    );
  }

  Widget _lineChart() {
    final realData = dayaRiil[tabIndex];
    final predData = dayaPrediksiAi[tabIndex];

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 2.0,
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: _powerTitles(),
        lineBarsData: [
          // Kurva 1: Daya Riil Panel Surya
          LineChartBarData(
            spots: [
              for (int i = 0; i < realData.length; i++)
                FlSpot(i.toDouble(), realData[i]),
            ],
            isCurved: true,
            color: FigmaColors.blueDark,
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: FigmaColors.blueLight.withOpacity(0.25),
            ),
          ),
          // Kurva 2: Prediksi AI 30 Menit (Ppred)
          LineChartBarData(
            spots: [
              for (int i = 0; i < predData.length; i++)
                FlSpot(i.toDouble(), predData[i]),
            ],
            isCurved: true,
            color: Colors.orange.shade700,
            barWidth: 2.5,
            dashArray: [6, 4],
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  Widget _barChart() {
    final data = riwayatSoc[tabIndex];
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 100,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: _socTitles(),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: 30,
              color: Colors.red,
              strokeWidth: 1.5,
              dashArray: [6, 4],
            ),
          ],
        ),
        barGroups: [
          for (int i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i],
                  width: 18,
                  color: data[i] <= 30 ? Colors.red : FigmaColors.blueDark,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
