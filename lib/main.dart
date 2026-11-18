import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/pages/autentikasi/figma_welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Micro-Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1E3A8A),
      ),
      home: const FigmaWelcomePage(),
    );
  }
}
