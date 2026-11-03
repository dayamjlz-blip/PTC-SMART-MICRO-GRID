import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/utils/figma_colors.dart';

class FigmaDashboardPage extends StatefulWidget {
  const FigmaDashboardPage({super.key});

  @override
  State<FigmaDashboardPage> createState() => _FigmaDashboardPageState();
}

class _FigmaDashboardPageState extends State<FigmaDashboardPage> {
  bool isAuto = true;
  bool beban1 = true;
  bool beban2 = false;

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
              _header(),
              const SizedBox(height: 16),
              _modeToggle(),
              const SizedBox(height: 16),
              _powerCard(),
              const SizedBox(height: 16),
              _environmentCard(),
              const SizedBox(height: 16),
              _predictionCard(),
              const SizedBox(height: 16),
              _controlCard(),
              const SizedBox(height: 24),
              _logCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _header() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monitoring Utama',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: FigmaColors.blueDark,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Pantau energi micro-grid secara real-time',
          style: TextStyle(color: FigmaColors.grey),
        ),
      ],
    );
  }

  Widget _modeToggle() {
    Widget item(String label, bool active, bool value) {
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => isAuto = value),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: active ? FigmaColors.blueDark : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : FigmaColors.blueDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        item('Otomatis', isAuto, true),
        const SizedBox(width: 8),
        item('Manual', !isAuto, false),
      ],
    );
  }

  Widget _powerCard() {
    Widget row(String label, String value, Color color) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: FigmaColors.grey)),
            Text(value,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    return _card(
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    value: 0.47,
                    strokeWidth: 10,
                    backgroundColor: FigmaColors.blueLightest,
                    color: FigmaColors.blueMedium,
                  ),
                ),
                const Text('47%',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                row('Produksi', '1,42 kW', FigmaColors.green),
                row('Beban', '0,94 kW', FigmaColors.orange),
                row('Defisit', '0,00 kW', FigmaColors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _environmentCard() {
    Widget item(IconData icon, String label) {
      return Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: FigmaColors.blueLightest,
            child: Icon(icon, color: FigmaColors.blueDark),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sumber Lingkungan',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              item(Icons.wb_sunny, 'Cahaya'),
              item(Icons.thermostat, 'Suhu'),
              item(Icons.water_drop, 'Lembap'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _predictionCard() {
    return _card(
      child: Row(
        children: [
          const Icon(Icons.bolt, color: FigmaColors.orange, size: 32),
          const SizedBox(width: 12),
          const Expanded(
            child: Text('Prediksi beban satu jam ke depan'),
          ),
          const Text(
            '0,94 kW',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: FigmaColors.blueDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlCard() {
    return _card(
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Beban 1'),
            value: beban1,
            onChanged: (v) => setState(() => beban1 = v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Beban 2'),
            value: beban2,
            onChanged: (v) => setState(() => beban2 = v),
          ),
        ],
      ),
    );
  }

  Widget _logCard() {
    Widget badge() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: FigmaColors.green.withOpacity(0.35),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Text(
          'Sukses',
          style: TextStyle(
            color: FigmaColors.green,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget item(String time, String source, String message) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              time,
              style: const TextStyle(
                color: FigmaColors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              source,
              style: const TextStyle(
                color: FigmaColors.orange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: FigmaColors.blueDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            badge(),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'LOG TERAKHIR',
              style: TextStyle(
                color: FigmaColors.blueDark,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Lihat semua',
                style: TextStyle(
                  color: FigmaColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        item('14:10:00', 'EMS', 'Relay 2 OFF, predictive load shedding'),
        item('13:42:15', 'ESP32', 'Telemetri INA219 terkirim ke server'),
        item('12:05:51', 'RF', 'Prediksi 2 jam: menurun'),
      ],
    );
  }
}