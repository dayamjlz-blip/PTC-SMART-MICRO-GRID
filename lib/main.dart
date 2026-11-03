import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/pages/figma_welcome_page.dart';
import 'package:smart_mikro_grid/pages/akun_page.dart';

void main() {
  runApp(const SmartMicroGridApp());
}

class SmartMicroGridApp extends StatelessWidget {
  const SmartMicroGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Micro-Grid',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AkunPage(),
    );
  }
}