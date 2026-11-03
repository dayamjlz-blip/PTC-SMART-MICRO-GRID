import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profil_mahasiswa/main.dart';

void main() {
  testWidgets('Aplikasi Smart Micro-Grid dapat dibuka',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SmartMicroGridApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}