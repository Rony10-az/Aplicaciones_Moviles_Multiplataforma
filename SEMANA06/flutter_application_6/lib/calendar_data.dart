import 'package:flutter/material.dart';

// Datos de ejemplo: solo sirven para mostrar el diseño (sin lógica ni persistencia).

const int kYear = 2026;
const int kMonth = 10;
const int kToday = 12; // día actual destacado
const String kMonthName = 'Octubre';
const List<String> kWeekdayShort = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

final int kDaysInMonth = DateTime(kYear, kMonth + 1, 0).day;

enum EntryKind {
  clase('Clase', Color(0xFF3B82F6), Icons.school_rounded),
  reunion('Reunión', Color(0xFFF97316), Icons.groups_rounded),
  proyecto('Proyecto', Color(0xFF10B981), Icons.rocket_launch_rounded),
  festivo('Festivo', Color(0xFFE11D48), Icons.celebration_rounded);

  const EntryKind(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;
}

class CalendarEntry {
  const CalendarEntry(
    this.day,
    this.title,
    this.time,
    this.kind, {
    String? shortTitle,
  }) : shortTitle = shortTitle ?? title;

  final int day;
  final String title;
  final String shortTitle; // versión corta para las celdas del calendario
  final String time;
  final EntryKind kind;

  String get weekday => kWeekdayShort[DateTime(kYear, kMonth, day).weekday - 1];
}

const List<CalendarEntry> kEntries = [
  CalendarEntry(2, 'Aplicaciones Móviles', '08:00 – 10:00', EntryKind.clase),
  CalendarEntry(
    4,
    'San Francisco de Asís',
    'Todo el día',
    EntryKind.festivo,
    shortTitle: 'Francisco',
  ),
  CalendarEntry(6, 'Reunión de equipo', '10:00', EntryKind.reunion),
  CalendarEntry(9, 'Entrega Sprint 1', '23:59', EntryKind.proyecto),
  CalendarEntry(
    11,
    'Día de la Niña',
    'Todo el día',
    EntryKind.festivo,
    shortTitle: 'Niña',
  ),
  CalendarEntry(14, 'Taller de Flutter', '08:00 – 10:00', EntryKind.clase),
  CalendarEntry(15, 'Asesoría de proyecto', '16:00', EntryKind.reunion),
  CalendarEntry(16, 'Presentación de avance', '11:00', EntryKind.proyecto),
  CalendarEntry(20, 'Exposición grupal', '14:00', EntryKind.clase),
  CalendarEntry(20, 'Coordinación de equipo', '17:00', EntryKind.reunion),
  CalendarEntry(22, 'Revisión de código', '15:00', EntryKind.proyecto),
  CalendarEntry(
    25,
    'Día del Artista',
    'Todo el día',
    EntryKind.festivo,
    shortTitle: 'Artista',
  ),
  CalendarEntry(28, 'Evaluación parcial', '09:00', EntryKind.clase),
  CalendarEntry(
    31,
    'Día de la Canción Criolla',
    'Todo el día',
    EntryKind.festivo,
    shortTitle: 'Criolla',
  ),
];

List<CalendarEntry> entriesOn(int day) =>
    kEntries.where((e) => e.day == day).toList();

// Los próximos 3 eventos después de hoy y el siguiente festivo.
List<CalendarEntry> upcomingEntries() {
  final after = kEntries.where((e) => e.day > kToday);
  final events = after.where((e) => e.kind != EntryKind.festivo).take(3);
  final holiday = after.where((e) => e.kind == EntryKind.festivo).take(1);
  return [...events, ...holiday]..sort((a, b) => a.day.compareTo(b.day));
}
