import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'calendar_data.dart';

// Encabezado con el mes y año en grande, degradado azul y montañas abstractas.
class HeaderBanner extends StatelessWidget {
  const HeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final events = kEntries.where((e) => e.kind != EntryKind.festivo).length;
    final holidays = kEntries.where((e) => e.kind == EntryKind.festivo).length;
    final remaining = kDaysInMonth - kToday;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E40AF), AppColors.blue, Color(0xFF8AA8FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDeep.withValues(alpha: 0.30),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            const Positioned.fill(child: CustomPaint(painter: _LandscapePainter())),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.30),
                          ),
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Calendario',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: poppins(
                            14,
                            weight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ),
                      const _NavButton(icon: Icons.chevron_left_rounded),
                      const SizedBox(width: 8),
                      const _NavButton(icon: Icons.chevron_right_rounded),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$kMonthName ',
                            style: poppins(
                              60,
                              weight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                          TextSpan(
                            text: '$kYear',
                            style: poppins(
                              60,
                              weight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.78),
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Organiza tus clases, reuniones y proyectos.',
                    style: poppins(
                      14,
                      weight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.86),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Pill(
                        icon: Icons.event_available_rounded,
                        label: '$events eventos',
                      ),
                      _Pill(
                        icon: Icons.celebration_rounded,
                        label: '$holidays festivos',
                      ),
                      _Pill(
                        icon: Icons.hourglass_bottom_rounded,
                        label: '$remaining días restantes',
                      ),
                    ],
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

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.white),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: poppins(12.5, weight: FontWeight.w500, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Paisaje abstracto: sol, círculos suaves y tres capas de montañas.
class _LandscapePainter extends CustomPainter {
  const _LandscapePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    Paint fill(double alpha) => Paint()..color = Colors.white.withValues(alpha: alpha);

    // Sol y anillos.
    canvas.drawCircle(Offset(w * 0.86, h * 0.26), 46, fill(0.10));
    canvas.drawCircle(Offset(w * 0.86, h * 0.26), 28, fill(0.14));
    canvas.drawCircle(
      Offset(w * 0.62, h * 0.10),
      70,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    for (final p in const [
      Offset(0.70, 0.18),
      Offset(0.76, 0.34),
      Offset(0.94, 0.12),
      Offset(0.55, 0.30),
    ]) {
      canvas.drawCircle(Offset(w * p.dx, h * p.dy), 2.5, fill(0.35));
    }

    void ridge(List<Offset> points, double alpha) {
      final path = Path()..moveTo(0, h);
      for (final p in points) {
        path.lineTo(w * p.dx, h * p.dy);
      }
      path
        ..lineTo(w, h)
        ..close();
      canvas.drawPath(path, fill(alpha));
    }

    ridge(const [
      Offset(0, 0.80),
      Offset(0.12, 0.62),
      Offset(0.22, 0.74),
      Offset(0.36, 0.50),
      Offset(0.50, 0.74),
      Offset(0.63, 0.58),
      Offset(0.77, 0.76),
      Offset(0.89, 0.60),
      Offset(1, 0.72),
    ], 0.14);
    ridge(const [
      Offset(0, 0.90),
      Offset(0.10, 0.80),
      Offset(0.26, 0.93),
      Offset(0.41, 0.75),
      Offset(0.56, 0.92),
      Offset(0.71, 0.79),
      Offset(0.86, 0.93),
      Offset(1, 0.82),
    ], 0.20);

    // Colina suave al frente.
    final front = Path()
      ..moveTo(0, h)
      ..lineTo(0, h * 0.94)
      ..cubicTo(w * 0.25, h * 0.86, w * 0.55, h * 1.02, w, h * 0.90)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(front, fill(0.26));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
