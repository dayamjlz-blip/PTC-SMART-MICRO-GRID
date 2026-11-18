import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';

class AdminModelAiPage extends StatelessWidget {
  final User? account;

  const AdminModelAiPage({super.key, this.account});

  @override
  Widget build(BuildContext context) {
    final String adminName = account?.name ?? 'Muh Nurhidayah';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8FAFC), // Putih terang di atas
            Color(0xFF31487A), // Biru gradien di bawah
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Profil & Status Role Admin
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(0xFF28467A),
                          child: Text(
                            'MN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$adminName (Admin)',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const Text(
                              '241011029 • Ilmu Komputer ITH',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'KHUSUS ADMIN',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Status ESP32 & Interval Pembaruan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPill(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '● ESP32 Online  ',
                              style: TextStyle(
                                color: Color(0xFF00A65A),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            TextSpan(
                              text: '192.168.1.42',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildPill(
                      child: const Text(
                        'Diperbarui tiap 5 detik',
                        style: TextStyle(color: Colors.black54, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Judul Utama Halaman
                const Text(
                  'Evaluasi Model AI & Arsitektur',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Audit kinerja Random Forest Regressor (FR17) dan alur EMS 2 lapis',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const SizedBox(height: 16),

                // BAGIAN 1: METRIK KINERJA MODEL AI (FR17 & NFR10)
                const Text(
                  'METRIK EVALUASI MODEL AI (FR17)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                _buildCardContainer(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Model Aktif: model_rf.joblib',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.shade300),
                          ),
                          child: Text(
                            'Target SRS: R² ≥ 0,80',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricBox(
                            label: 'MAE',
                            value: '0,084 W',
                            desc: 'Rata-rata selisih',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMetricBox(
                            label: 'RMSE',
                            value: '0,112 W',
                            desc: 'Galat kuadrat',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMetricBox(
                            label: 'R² Score',
                            value: '0,84',
                            desc: 'Determinasi',
                            highlight: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Digunakan Admin untuk memvalidasi kelayakan prediksi daya 30 menit ke depan sebelum memicu pemutusan beban EMS.',
                      style: TextStyle(fontSize: 10.5, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // BAGIAN 2: ARSITEKTUR SISTEM 2 LAPIS
                const Center(
                  child: Text(
                    'ALUR SISTEM • ARSITEKTUR 2 LAPIS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Kartu 1: ESP32 - MATA (Baca sensor aktual)
                _buildCardContainer(
                  children: const [
                    Text(
                      'ESP32 • MATA',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Akuisisi Data Sensor',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '2× INA219 (panel & baterai), LDR (intensitas cahaya),\nDHT22 (suhu udara). Kirim JSON tiap 5 detik via HTTP POST.',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const Center(
                  child: Icon(
                    Icons.arrow_downward,
                    size: 18,
                    color: Color(0xFF28467A),
                  ),
                ),
                const SizedBox(height: 8),

                // Kartu 2: LAPIS 1 - ML (Random Forest Regressor)
                _buildCardContainer(
                  children: const [
                    Text(
                      'LAPIS 1 • MACHINE LEARNING',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFD97706),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Random Forest Regressor',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'model_rf.joblib (Scikit-Learn) di server memprediksi\npotensi daya panel surya 30 menit ke depan (Ppred).',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const Center(
                  child: Icon(
                    Icons.arrow_downward,
                    size: 18,
                    color: Color(0xFF28467A),
                  ),
                ),
                const SizedBox(height: 8),

                // Kartu 3: LAPIS 2 - EMS (Aturan berbasis rule)
                _buildCardContainer(
                  children: const [
                    Text(
                      'LAPIS 2 • ENERGY MANAGEMENT SYSTEM',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFD97706),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rule-Based EMS & Histeresis',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Jika SoC baterai mendekati batas kritis dan Ppred turun,\naktifkan predictive load shedding untuk proteksi Li-ion 18650.',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const Center(
                  child: Icon(
                    Icons.arrow_downward,
                    size: 18,
                    color: Color(0xFF28467A),
                  ),
                ),
                const SizedBox(height: 8),

                // Kartu 4: ESP32 - TANGAN (Eksekusi relay sesuai GPIO)
                _buildCardContainer(
                  children: const [
                    Text(
                      'ESP32 • TANGAN',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Eksekusi Relay Beban',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Terima instruksi JSON: putus Relay 1 (Kipas DC - GPIO 26),\npertahankan Relay 2 (Lampu LED - GPIO 27).',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // BAGIAN 3: FITUR INPUT & OUTPUT MODEL
                const Text(
                  'FITUR INPUT & OUTPUT MODEL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _buildCardContainer(
                  children: [
                    _buildIoRow('Rata-rata cahaya (LDR)', '%'),
                    const Divider(height: 16),
                    _buildIoRow('Tren perubahan cahaya', 'Δ LDR'),
                    const Divider(height: 16),
                    _buildIoRow('Suhu udara sekitar (DHT22)', '°C'),
                    const Divider(height: 16),
                    _buildIoRow('Riwayat daya panel (INA219)', 'W'),
                    const Divider(height: 16),
                    _buildIoRow('Variabel waktu diurnal', 'Jam'),
                    const Divider(height: 16),
                    _buildIoRow('Output: Prediksi 30 menit (Ppred)', 'W'),
                    const SizedBox(height: 8),
                    const Text(
                      'SoC baterai sengaja tidak dijadikan input ML, melainkan digabungkan pada Lapisan 2 (EMS) untuk keputusan pemutusan beban.',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // BAGIAN 4: DATA & PEMBAGIAN DATASET
                const Text(
                  'DATA & PEMBAGIAN DATASET',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _buildCardContainer(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 70,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 8,
                              ),
                              color: const Color(0xFF00A65A),
                              child: const Text(
                                'Latih 70%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 4,
                              ),
                              color: const Color(0xFF10B981),
                              child: const Text(
                                '15%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 4,
                              ),
                              color: const Color(0xFFF59E0B),
                              child: const Text(
                                '15%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dibagi kronologis (Time-Series Split)',
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                        Text(
                          'Valid.   Uji',
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    _buildIoRow('Dataset Pelatihan', 'Log Sensor Maket ESP32'),
                    const Divider(height: 16),
                    _buildIoRow(
                        'Algoritma Regresi', 'Random Forest (Scikit-Learn)'),
                    const Divider(height: 16),
                    _buildIoRow('Standar Kelayakan SRS', 'R² ≥ 0,80 (NFR10)'),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricBox({
    required String label,
    required String value,
    required String desc,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFEAF1FB) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlight ? const Color(0xFF1E3A8A) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9.5, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildPill({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildCardContainer({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildIoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
