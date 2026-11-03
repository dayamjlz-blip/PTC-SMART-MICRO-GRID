import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_mikro_grid/main.dart';

void main() {
  testWidgets('Aplikasi Smart Micro-Grid dapat dibuka',
      (WidgetTester tester) async {
    // Sesuaikan dengan nama kelas di main.dart yaitu MyApp
    await tester.pumpWidget(const SmartMicroGridApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
