import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'calendar_data.dart';

// Tarjeta principal: título, días de la semana y cuadrícula del mes.
class CalendarCard extends StatelessWidget {
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    final weeks = _buildWeeks();

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      child: Column(
        children: [
          const _CardTitle(),
          const SizedBox(height: 16),
          const _WeekdayRow(),
          const SizedBox(height: 8),
          for (var w = 0; w < weeks.length; w++) ...[
            if (w > 0) const SizedBox(height: 8),
            Row(
              children: [
                for (var d = 0; d < 7; d++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.5),
                      child: _DayCell(
                        day: weeks[w][d].day,
                        inMonth: weeks[w][d].inMonth,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

typedef _DayInfo = ({int day, bool inMonth});

// Arma la cuadrícula del mes (semanas de lunes a domingo), completando con
// los días del mes anterior y siguiente.
List<List<_DayInfo>> _buildWeeks() {
  final offset = DateTime(kYear, kMonth, 1).weekday - 1;
  final daysInPrevMonth = DateTime(kYear, kMonth, 0).day;
  final weekCount = ((offset + kDaysInMonth) / 7).ceil();

  return [
    for (var w = 0; w < weekCount; w++)
      [
        for (var d = 0; d < 7; d++)
          () {
            final day = w * 7 + d - offset + 1;
            if (day < 1) return (day: daysInPrevMonth + day, inMonth: false);
            if (day > kDaysInMonth) {
              return (day: day - kDaysInMonth, inMonth: false);
            }
            return (day: day, inMonth: true);
          }(),
      ],
  ];
}

class _CardTitle extends StatelessWidget {
  const _CardTitle();

  @override
  Widget build(BuildContext context) {
    final weekday = kWeekdayShort[DateTime(kYear, kMonth, kToday).weekday - 1];

    return Row(
      children: [
        const IconTile(icon: Icons.grid_view_rounded),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Vista mensual',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: poppins(17, weight: FontWeight.w700),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.blue.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.today_rounded, size: 15, color: AppColors.blue),
              const SizedBox(width: 6),
              Text(
                '$weekday $kToday',
                style: poppins(12.5, weight: FontWeight.w600, color: AppColors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeekdayRow extends StatelessWidget {
  const _WeekdayRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < kWeekdayShort.length; i++)
          Expanded(
            child: Center(
              child: Text(
                kWeekdayShort[i],
                style: poppins(
                  12.5,
                  weight: FontWeight.w600,
                  color: i >= 5 ? AppColors.indigo : AppColors.muted,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day, required this.inMonth});

  final int day;
  final bool inMonth;

  @override
  Widget build(BuildContext context) {
    final entries = inMonth ? entriesOn(day) : const <CalendarEntry>[];
    final holiday =
        entries.where((e) => e.kind == EntryKind.festivo).firstOrNull;
    final events = entries.where((e) => e.kind != EntryKind.festivo).toList();
    final isToday = inMonth && day == kToday;
    final radius = BorderRadius.circular(16);

    final BoxDecoration decoration;
    if (isToday) {
      decoration = BoxDecoration(
        borderRadius: radius,
        gradient: kBlueGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withValues(alpha: 0.45),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      );
    } else if (holiday != null) {
      decoration = BoxDecoration(
        color: AppColors.roseSoft,
        borderRadius: radius,
        border: Border.all(color: AppColors.roseLine),
        boxShadow: [
          BoxShadow(
            color: AppColors.rose.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } else if (inMonth) {
      decoration = BoxDecoration(
        color: Colors.white,
        borderRadius: radius,
        border: Border.all(color: AppColors.line),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDeep.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        color: Colors.white.withValues(alpha: 0.30),
        borderRadius: radius,
      );
    }

    final Color numberColor = isToday
        ? Colors.white
        : holiday != null
            ? AppColors.rose
            : inMonth
                ? AppColors.ink
                : AppColors.faint.withValues(alpha: 0.75);

    return LayoutBuilder(
      builder: (context, constraints) {
        final Widget indicator;
        if (isToday) {
          indicator = Text(
            'Hoy',
            style: poppins(9, weight: FontWeight.w700, color: Colors.white, height: 1),
          );
        } else if (holiday != null) {
          // Ícono y nombre corto del festivo (se reduce si no cabe en la celda).
          indicator = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.celebration_rounded, size: 12, color: AppColors.rose),
              const SizedBox(height: 1),
              SizedBox(
                width: constraints.maxWidth - 6,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    holiday.shortTitle,
                    style: poppins(
                      8.5,
                      weight: FontWeight.w700,
                      color: AppColors.rose,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (events.isNotEmpty) {
          indicator = _Dots(events: events, size: 5.5);
        } else {
          indicator = const SizedBox(height: 5.5);
        }

        // Ícono pequeño en la esquina: estrella en "Hoy", tipo en días con evento.
        final IconData? cornerIcon = isToday
            ? Icons.star_rounded
            : events.isNotEmpty
                ? events.first.kind.icon
                : null;
        final Color cornerColor =
            isToday ? Colors.white : (events.firstOrNull?.kind.color ?? Colors.transparent);

        return AspectRatio(
          aspectRatio: 0.72,
          child: Container(
            decoration: decoration,
            padding: const EdgeInsets.all(2),
            child: Stack(
              children: [
                Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$day',
                          style: poppins(
                            15,
                            weight: (isToday || holiday != null)
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: numberColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        indicator,
                      ],
                    ),
                  ),
                ),
                if (cornerIcon != null)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Icon(cornerIcon, size: 10, color: cornerColor),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Puntos de color: azul = clase, naranja = reunión, verde = proyecto.
class _Dots extends StatelessWidget {
  const _Dots({required this.events, required this.size});

  final List<CalendarEntry> events;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final e in events)
          Container(
            width: size,
            height: size,
            margin: EdgeInsets.only(right: size > 6 ? 4 : 2),
            decoration: BoxDecoration(
              color: e.kind.color,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
