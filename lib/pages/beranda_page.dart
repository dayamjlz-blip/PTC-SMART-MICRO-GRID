import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/utils/app_colors.dart';
import '../models/user_role.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  bool isAutoMode = true;
  bool isKipasOn = false;
  bool isLampuOn = false;

  @override
  Widget build(BuildContext context) {
    bool isAdmin = UserSession.currentRole == UserRole.admin;

    return Scaffold(
      backgroundColor: FigmaColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER PROFILE & ROLE BADGE ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAdmin ? "Halo, Admin Daya" : "Halo, Pengguna",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: FigmaColors.textPrimary,
                        ),
                      ),
                      Text(
                        isAdmin
                            ? "Mode Pengelola Mikro Grid"
                            : "Mode Pemantauan Sistem",
                        style: const TextStyle(
                          fontSize: 12,
                          color: FigmaColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  // Badge Role
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isAdmin
                          ? FigmaColors.primary.withOpacity(0.15)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isAdmin ? "ADMIN" : "USER",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isAdmin ? FigmaColors.primary : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- TOGGLE AUTO / MANUAL (HANYA AKTIF UNTUK ADMIN) ---
              if (isAdmin) ...[
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: FigmaColors.cardBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isAutoMode = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isAutoMode
                                  ? FigmaColors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "AUTO (EMS)",
                                style: TextStyle(
                                  color: isAutoMode
                                      ? Colors.white
                                      : FigmaColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isAutoMode = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: !isAutoMode
                                  ? FigmaColors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "MANUAL",
                                style: TextStyle(
                                  color: !isAutoMode
                                      ? Colors.white
                                      : FigmaColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // --- KONTROL RELAY (KIPAS & LAMPU) ---
              Card(
                color: FigmaColors.cardBackground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Kipas Control Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Relay Kipas Pendingin",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: FigmaColors.textPrimary,
                            ),
                          ),
                          Switch(
                            value: isKipasOn,
                            onChanged: (isAdmin && !isAutoMode)
                                ? (val) => setState(() => isKipasOn = val)
                                : null,
                            activeColor: FigmaColors.primary,
                          ),
                        ],
                      ),
                      const Divider(),
                      // Lampu Control Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Relay Penerangan Lampu",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: FigmaColors.textPrimary,
                            ),
                          ),
                          Switch(
                            value: isLampuOn,
                            onChanged: (isAdmin && !isAutoMode)
                                ? (val) => setState(() => isLampuOn = val)
                                : null,
                            activeColor: FigmaColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
