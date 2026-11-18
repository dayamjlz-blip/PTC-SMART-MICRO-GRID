import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';
import 'package:smart_mikro_grid/utils/figma_colors.dart';

class AdminBerandaPage extends StatefulWidget {
  final User? account;

  const AdminBerandaPage({super.key, this.account});

  @override
  State<AdminBerandaPage> createState() => _AdminBerandaPageState();
}

class _AdminBerandaPageState extends State<AdminBerandaPage> {
  static const Color primaryNavy = Color(0xFF1E3A8A);
  static const Color darkSlate = Color(0xFF0F172A);
  static const Color mutedSlate = Color(0xFF64748B);

  bool isAutoMode = true;
  bool isKipasOn = false; // Relay 1 (GPIO 26): Kipas DC — Beban Sekunder
  bool isLampuOn = true; // Relay 2 (GPIO 27): Lampu LED — Beban Prioritas

  // Nilai telemetri awal (akan terhubung ke Firebase & ESP32 pada tahap integrasi)
  final double panelPowerW = 1.62;
  final double panelVolt = 5.62;
  final double panelCurrentMa = 288;

  final double socPercent = 76;
  final double batteryVolt = 4.02;
  final double loadCurrentMa = 140;
  final double criticalSocLimit = 30;

  final double lightPercent = 68;
  final double airTempC = 31.2;
  final double pPredW = 1.48;

  @override
  Widget build(BuildContext context) {
    final String adminName = widget.account?.name ?? 'Admin Daya';
    final bool isShedding = isAutoMode && (socPercent <= criticalSocLimit + 10);

    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(gradient: FigmaColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER PROFIL, STATUS ESP32 & BADGE ROLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo, $adminName',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: darkSlate,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Row(
                            children: [
                              Icon(Icons.circle, color: Colors.green, size: 10),
                              SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'ESP32 Online - 192.168.1.42 • Tiap 5 dtk',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: mutedSlate,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: primaryNavy,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'ADMIN',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 2. TOGGLE MODE OPERASI: AUTO (EMS) / MANUAL (FR9)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => isAutoMode = true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Mode AUTO aktif: Kendali beban diserahkan ke EMS.',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              color:
                                  isAutoMode ? primaryNavy : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'AUTO (EMS)',
                                style: TextStyle(
                                  color: isAutoMode ? Colors.white : mutedSlate,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => isAutoMode = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Mode MANUAL aktif: Sakelar Relay 1 & 2 dibuka.',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              color: !isAutoMode
                                  ? primaryNavy
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'MANUAL',
                                style: TextStyle(
                                  color:
                                      !isAutoMode ? Colors.white : mutedSlate,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // 3. KARTU KAPASITAS BATERAI LI-ION 18650 (INA219 & SoC)
                _whiteCard(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 82,
                        height: 82,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: socPercent / 100,
                              strokeWidth: 9,
                              backgroundColor: Colors.grey.shade200,
                              color: socPercent <= criticalSocLimit
                                  ? Colors.red
                                  : primaryNavy,
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${socPercent.toInt()}%',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: darkSlate,
                                    ),
                                  ),
                                  const Text(
                                    'SoC',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: mutedSlate,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'BATERAI LI-ION 18650',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: primaryNavy,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _metricRow(
                              'Tegangan',
                              '${batteryVolt.toStringAsFixed(2)} V',
                            ),
                            const SizedBox(height: 5),
                            _metricRow(
                              'Arus Beban',
                              '${loadCurrentMa.toInt()} mA',
                            ),
                            const SizedBox(height: 5),
                            _metricRow(
                              'Batas Kritis',
                              '${criticalSocLimit.toInt()}% (Aman)',
                              valueColor: Colors.green.shade700,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 4. KARTU PANEL SURYA (INA219 PANEL)
                _whiteCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PANEL SURYA (INA219)',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: primaryNavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${panelPowerW.toStringAsFixed(2)} W',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkSlate,
                        ),
                      ),
                      const Divider(height: 16),
                      _metricRow(
                        'Tegangan Panel',
                        '${panelVolt.toStringAsFixed(2)} V',
                      ),
                      const SizedBox(height: 6),
                      _metricRow(
                        'Arus Panel',
                        '${panelCurrentMa.toInt()} mA',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 5. KARTU SENSOR LINGKUNGAN (LDR & DHT22)
                Row(
                  children: [
                    Expanded(
                      child: _whiteCard(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.orange,
                              size: 26,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${lightPercent.toInt()}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: darkSlate,
                              ),
                            ),
                            const Text(
                              'Cahaya (LDR)',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: mutedSlate,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _whiteCard(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.thermostat_outlined,
                              color: primaryNavy,
                              size: 26,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${airTempC.toStringAsFixed(1)} °C',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: darkSlate,
                              ),
                            ),
                            const Text(
                              'Suhu Udara (DHT22)',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: mutedSlate,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // 6. KARTU PREDIKSI AI (30 MENIT) & STATUS KEPUTUSAN EMS
                _whiteCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'AI RANDOM FOREST • 30 MENIT',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: primaryNavy,
                            ),
                          ),
                          Text(
                            'EMS AKTIF',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Prediksi Daya (Ppred): ${pPredW.toStringAsFixed(2)} W',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: darkSlate,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isShedding
                            ? 'Keputusan EMS: Predictive load shedding aktif — Relay 1 (Kipas) diputus untuk proteksi baterai.'
                            : 'Keputusan EMS: Suplai daya & kapasitas baterai aman, beban beroperasi normal.',
                        style: const TextStyle(
                          fontSize: 12,
                          color: mutedSlate,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 7. KARTU KONTROL RELAY (KIPAS DC & LAMPU LED — FR12)
                _whiteCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'KONTROL BEBAN (RELAY)',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: primaryNavy,
                            ),
                          ),
                          Text(
                            isAutoMode
                                ? 'Terkunci (Mode AUTO)'
                                : 'Aktif (Mode MANUAL)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isAutoMode
                                  ? Colors.orange.shade800
                                  : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Relay 1: Kipas DC (Beban Sekunder - GPIO 26)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Relay 1 — Kipas DC (Sekunder)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: darkSlate,
                                    fontSize: 13.5,
                                  ),
                                ),
                                Text(
                                  'GPIO 26 • Diputus lebih awal saat SoC kritis',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: mutedSlate,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isKipasOn,
                            onChanged: !isAutoMode
                                ? (val) => setState(() => isKipasOn = val)
                                : null,
                            activeColor: primaryNavy,
                          ),
                        ],
                      ),
                      const Divider(),
                      // Relay 2: Lampu LED (Beban Prioritas - GPIO 27)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Relay 2 — Lampu LED (Prioritas)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: darkSlate,
                                    fontSize: 13.5,
                                  ),
                                ),
                                Text(
                                  'GPIO 27 • Beban utama yang dipertahankan',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: mutedSlate,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isLampuOn,
                            onChanged: !isAutoMode
                                ? (val) => setState(() => isLampuOn = val)
                                : null,
                            activeColor: primaryNavy,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _whiteCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _metricRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, color: mutedSlate),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: valueColor ?? darkSlate,
          ),
        ),
      ],
    );
  }
}
