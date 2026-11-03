import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/utils/figma_colors.dart';

class FigmaAnalisisPage extends StatefulWidget {
  const FigmaAnalisisPage({super.key});

  @override
  State<FigmaAnalisisPage> createState() => _FigmaAnalisisPageState();
}

class _FigmaAnalisisPageState extends State<FigmaAnalisisPage> {
  int tabIndex = 0;

  final List<String> tabs = ['Hari ini', '7 hari', 'Bulan ini'];

  // Data contoh per tab (ganti dengan data asli nanti)
  final List<List<String>> labels = [
    ['06', '08', '10', '12', '14', '16', '18'],
    ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
    ['1', '5', '10', '15', '20', '25', '30'],
  ];

  final List<List<double>> produksi = [
    [0.3, 0.7, 1.2, 1.6, 1.4, 0.9, 0.4],
    [1.1, 1.3, 0.9, 1.5, 1.4, 1.0, 1.2],
    [1.0, 1.2, 1.4, 1.3, 1.6, 1.5, 1.7],
  ];

  final List<List<double>> konsumsi = [
    [0.5, 0.6, 0.9, 1.0, 0.9, 1.1, 0.8],
    [0.8, 0.9, 1.0, 1.2, 1.1, 0.7, 0.9],
    [0.9, 1.0, 1.1, 1.0, 1.2, 1.1, 1.3],
  ];

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
                'Daya riil vs prediksi AI dan riwayat SoC',
                style: TextStyle(color: FigmaColors.grey),
              ),
              const SizedBox(height: 16),
              _tabToggle(),
              const SizedBox(height: 16),
              _card(
                title: 'Produksi Energi (kW)',
                child: SizedBox(height: 200, child: _lineChart()),
              ),
              const SizedBox(height: 16),
              _card(
                title: 'Konsumsi Beban (kW)',
                child: SizedBox(height: 200, child: _barChart()),
              ),
              const SizedBox(height: 16),
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Unduh data (segera hadir)')),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Unduh CSV / Excel'),
                ),
              ),
            ],
          ),
        ),
      ),
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
            color: Colors.black.withOpacity(0.15),
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

  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  FlTitlesData _titles() {
    const style = TextStyle(fontSize: 11, color: FigmaColors.grey);
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
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

  Widget _lineChart() {
    final data = produksi[tabIndex];
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 2,
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: _titles(),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < data.length; i++)
                FlSpot(i.toDouble(), data[i]),
            ],
            isCurved: true,
            color: FigmaColors.blueMedium,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: FigmaColors.blueLight.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _barChart() {
    final data = konsumsi[tabIndex];
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 2,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: _titles(),
        barGroups: [
          for (int i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i],
                  width: 18,
                  color: FigmaColors.blueDark,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
        ],
      ),
    );
  }
}