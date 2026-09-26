import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_6/main.dart';

void setViewSize(WidgetTester tester, double width, double height) {
  tester.view.physicalSize = Size(width, height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void expectCalendarContent() {
  expect(find.text('Octubre 2026'), findsOneWidget);
  expect(find.text('Lun'), findsOneWidget);
  expect(find.text('Dom'), findsOneWidget);
  expect(find.text('Hoy'), findsWidgets);
  expect(find.text('Leyenda'), findsOneWidget);
  expect(find.text('Próximos eventos'), findsOneWidget);
  expect(find.text('¡Tú puedes!'), findsOneWidget);
}

void main() {
  testWidgets('En pantalla ancha se muestra dentro del teléfono simulado', (tester) async {
    setViewSize(tester, 1280, 1000);

    await tester.pumpWidget(const CalendarApp());

    expect(find.text('9:41'), findsOneWidget); // barra de estado del emulador
    expectCalendarContent();
  });

  testWidgets('En un celular real se muestra a pantalla completa, sin marco', (tester) async {
    setViewSize(tester, 393, 852);

    await tester.pumpWidget(const CalendarApp());

    expect(find.text('9:41'), findsNothing);
    expectCalendarContent();
  });

  // Teléfono angosto y grande (sin marco) y ventanas de tablet y escritorio (con marco).
  for (final width in [320.0, 360.0, 412.0, 720.0, 1280.0]) {
    testWidgets('Sin overflow con ancho de ${width.toInt()} px', (tester) async {
      setViewSize(tester, width, 900);

      await tester.pumpWidget(const CalendarApp());

      expect(tester.takeException(), isNull);
    });
  }
}
