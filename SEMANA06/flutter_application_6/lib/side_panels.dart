import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'calendar_data.dart';

// ---------------------------------------------------------------------------
// Próximos eventos
// ---------------------------------------------------------------------------

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final upcoming = upcomingEntries();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconTile(icon: Icons.event_note_rounded),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Próximos eventos',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: poppins(17, weight: FontWeight.w700),
                ),
              ),
              Text(
                'Ver todo',
                style: poppins(12.5, weight: FontWeight.w600, color: AppColors.blue),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: AppColors.blue,
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < upcoming.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            _UpcomingTile(entry: upcoming[i]),
          ],
        ],
      ),
    );
  }
}

class _UpcomingTile extends StatelessWidget {
  const _UpcomingTile({required this.entry});

  final CalendarEntry entry;

  @override
  Widget build(BuildContext context) {
    final kind = entry.kind;
    final isHoliday = kind == EntryKind.festivo;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isHoliday ? AppColors.roseSoft : Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isHoliday ? AppColors.roseLine : AppColors.line,
        ),
      ),
      child: Row(
        children: [
          // Insignia con la fecha.
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: kind.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  '${entry.day}',
                  style: poppins(
                    19,
                    weight: FontWeight.w800,
                    color: kind.color,
                    height: 1.1,
                  ),
                ),
                Text(
                  entry.weekday.toUpperCase(),
                  style: poppins(
                    10,
                    weight: FontWeight.w600,
                    color: kind.color,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: poppins(14.5, weight: FontWeight.w600, height: 1.25),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.muted,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '${entry.time}  ·  ${kind.label}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppins(
                          12,
                          weight: FontWeight.w400,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: kind.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kind.color.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(kind.icon, size: 19, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Leyenda de colores
// ---------------------------------------------------------------------------

class LegendCard extends StatelessWidget {
  const LegendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconTile(icon: Icons.palette_outlined, color: AppColors.violet),
              const SizedBox(width: 10),
              Text('Leyenda', style: poppins(17, weight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 18,
            runSpacing: 12,
            children: [
              for (final kind in [
                EntryKind.clase,
                EntryKind.reunion,
                EntryKind.proyecto,
              ])
                _LegendItem(
                  swatch: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: kind.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  label: kind.label,
                ),
              _LegendItem(
                swatch: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.roseSoft,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.roseLine),
                  ),
                  child: const Icon(
                    Icons.celebration_rounded,
                    size: 12,
                    color: AppColors.rose,
                  ),
                ),
                label: 'Festivo',
              ),
              _LegendItem(
                swatch: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: kBlueGradient,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
                label: 'Hoy',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.swatch, required this.label});

  final Widget swatch;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        swatch,
        const SizedBox(width: 8),
        Text(
          label,
          style: poppins(13, weight: FontWeight.w500, color: AppColors.muted),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tarjeta motivacional
// ---------------------------------------------------------------------------

class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = kToday / kDaysInMonth;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.indigo, AppColors.violet, Color(0xFFA78BFA)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.violet.withValues(alpha: 0.32),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            Positioned(
              top: -36,
              right: -30,
              child: _Circle(size: 140, alpha: 0.12),
            ),
            Positioned(
              bottom: -50,
              left: -30,
              child: _Circle(size: 120, alpha: 0.09),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Tú puedes!',
                          style: poppins(
                            26,
                            weight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Cada día es una nueva oportunidad para acercarte a tu meta. '
                          '¡Sigue avanzando!',
                          style: poppins(
                            13,
                            weight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Avance del mes',
                                style: poppins(
                                  12,
                                  weight: FontWeight.w500,
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                            ),
                            Text(
                              '${(progress * 100).round()}%',
                              style: poppins(
                                12,
                                weight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 7,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.18),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.size, required this.alpha});

  final double size;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: alpha),
      ),
    );
  }
}
