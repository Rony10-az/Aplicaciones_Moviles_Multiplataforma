import 'package:flutter/material.dart';

import 'app_theme.dart';

// Barra de navegación inferior flotante (solo visual).
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  static const _items = [
    (Icons.calendar_month_rounded, 'Calendario'),
    (Icons.checklist_rounded, 'Tareas'),
    (Icons.notifications_none_rounded, 'Avisos'),
    (Icons.person_outline_rounded, 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 30,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          for (var i = 0; i < _items.length; i++)
            Expanded(
              flex: i == 0 ? 2 : 1,
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: i == 0
                    ? BoxDecoration(
                        gradient: kBlueGradient,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blue.withValues(alpha: 0.40),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      )
                    : null,
                child: i == 0
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_items[i].$1, size: 22, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              _items[i].$2,
                              style: poppins(
                                13,
                                weight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Icon(_items[i].$1, size: 24, color: AppColors.muted),
              ),
            ),
        ],
      ),
    );
  }
}
