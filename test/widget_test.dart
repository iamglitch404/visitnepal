import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visitnepal/main.dart';

void main() {
  testWidgets('VisitNepalApp initializes and renders SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const VisitNepalApp());
    expect(find.byType(VisitNepalApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
