import 'package:flutter/material.dart';

class ModelAIPage extends StatelessWidget {
  const ModelAIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8FAFC), // Putih terang di atas
            Color(0xFF31487A) // Biru gradien di bawah
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Profil & Notifikasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFF28467A),
                          child: const Text(
                            'MN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Zahra Aulia (Zahra Aulia)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color(0xFF1F2937)),
                            ),
                            Text(
                              '241011029',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 5),
                        ],
                      ),
                      child: const Icon(Icons.notifications_none,
                          size: 20, color: Color(0xFF1F2937)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Status ESP32 & Diperbarui
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
                                  fontSize: 10),
                            ),
                            TextSpan(
                              text: '192.168.1.42',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 10),
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
                  'Model prediksi & arsitektur',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Machine learning berjalan di server; ESP32 jadi mata dan tangan',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const SizedBox(height: 16),

                const Center(
                  child: Text(
                    'ALUR SISTEM • ARSITEKTUR 2 LAPIS',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                ),
                const SizedBox(height: 12),

                // Kartu 1: ESP32 - MATA (Baca sensor)
                _buildCardContainer(
                  children: [
                    const Text('ESP32 • MATA',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Baca sensor',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937))),
                    const SizedBox(height: 6),
                    const Text(
                      'INA219 (arus/tegangan), BH1750 (iradiasi),\nDS18B20/DHT22 (suhu). Kirim JSON via HTTP POST.',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const Center(
                    child: Icon(Icons.arrow_downward,
                        size: 18, color: Color(0xFF28467A))),
                const SizedBox(height: 8),

                // Kartu 2: LAPIS 1 - ML (Random Forest Regressor)
                _buildCardContainer(
                  children: [
                    const Text('LAPIS 1 • ML',
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFD97706),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Random Forest Regressor',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937))),
                    const SizedBox(height: 6),
                    const Text(
                      'model.pkl (Scikit-Learn) di server meramal daya panel\n2 jam ke depan (Ppred).',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const Center(
                    child: Icon(Icons.arrow_downward,
                        size: 18, color: Color(0xFF28467A))),
                const SizedBox(height: 8),

                // Kartu 3: LAPIS 2 - EMS (Aturan berbasis rule)
                _buildCardContainer(
                  children: [
                    const Text('LAPIS 2 • EMS',
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFD97706),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Aturan berbasis rule',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937))),
                    const SizedBox(height: 6),
                    const Text(
                      'Jika SoC mendekati batas kritis 30% dan Ppred turun,\njalankan predictive load shedding.',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const Center(
                    child: Icon(Icons.arrow_downward,
                        size: 18, color: Color(0xFF28467A))),
                const SizedBox(height: 8),

                // Kartu 4: ESP32 - TANGAN (Eksekusi relay)
                _buildCardContainer(
                  children: [
                    const Text('ESP32 • TANGAN',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Eksekusi relay',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937))),
                    const SizedBox(height: 6),
                    const Text(
                      'Terima instruksi JSON: putus Relay 2 (Kipas DC),\nperlahankan Relay 1 (Lampu LED).',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Bagian: FITUR INPUT & OUTPUT
                const Text(
                  'FITUR INPUT & OUTPUT',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(height: 10),
                _buildCardContainer(
                  children: [
                    _buildIoRow('Intensitas iradiasi', 'W/m²'),
                    const Divider(height: 16),
                    _buildIoRow('Suhu udara lingkungan', '°C'),
                    const Divider(height: 16),
                    _buildIoRow('Suhu panel surya', '°C'),
                    const Divider(height: 16),
                    _buildIoRow('Riwayat daya panel', 'W'),
                    const Divider(height: 16),
                    _buildIoRow('Output: estimasi daya (Ppred)', 'W'),
                    const SizedBox(height: 8),
                    const Text(
                      'Variabel jam dan bulan tidak dipakai. SoC baterai sengaja tidak masuk ML, hanya dipakai EMS.',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Bagian: DATA & PEMBAGIAN DATASET
                const Text(
                  'DATA & PEMBAGIAN DATASET',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(height: 10),
                _buildCardContainer(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                color: const Color(0xFF00A65A),
                                child: const Text('Latih 70%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)))),
                        Expanded(
                            flex: 15,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                color: const Color(0xFF10B981),
                                child: const Text('15%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)))),
                        Expanded(
                            flex: 15,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                color: const Color(0xFFF59E0B),
                                child: const Text('15%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Dibagi kronologis',
                            style:
                                TextStyle(fontSize: 10, color: Colors.black54)),
                        Text('Valid.    Uji',
                            style:
                                TextStyle(fontSize: 10, color: Colors.black54)),
                      ],
                    ),
                    const Divider(height: 20),
                    _buildIoRow('Tahap 1 - data sekunder', 'Applied Energy'),
                    const Divider(height: 16),
                    _buildIoRow('Tahap 2 - data primer', 'Sensor maket'),
                    const Divider(height: 16),
                    _buildIoRow('Acuan akurasi', 'R² = 0,93'),
                    const SizedBox(height: 8),
                    const Text(
                      'Tariq et al., 2026 - DOI 10.1016/j.apenergy.2026.127685',
                      style: TextStyle(fontSize: 9, color: Colors.black45),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pembantu Pill header
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
              offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  // Widget pembantu Container Kartu Utama
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
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  // Widget baris Input & Output
  Widget _buildIoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w500)),
        Text(value,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
