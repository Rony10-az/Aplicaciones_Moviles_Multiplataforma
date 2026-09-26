import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

class AppColors {
  static const ink = Color(0xFF1B2545);
  static const muted = Color(0xFF6C7A99);
  static const faint = Color(0xFFB3BDD3);
  static const line = Color(0xFFE4EAF7);

  static const blue = Color(0xFF3B82F6);
  static const blueDeep = Color(0xFF1D4ED8);
  static const indigo = Color(0xFF6366F1);
  static const violet = Color(0xFF8B5CF6);

  static const rose = Color(0xFFE11D48);
  static const roseSoft = Color(0xFFFFF0F3);
  static const roseLine = Color(0xFFFFC7D2);
}

// Degradado azul → índigo usado en "Hoy" y en detalles destacados.
const LinearGradient kBlueGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.blue, AppColors.indigo],
);

TextStyle poppins(
  double size, {
  FontWeight weight = FontWeight.w500,
  Color color = AppColors.ink,
  double? height,
  double? letterSpacing,
}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

// Tarjeta de vidrio ligero: fondo translúcido, desenfoque, borde claro y sombra suave.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 26,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDeep.withValues(alpha: 0.10),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: borderRadius,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.85),
                width: 1.2,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Recuadro con ícono para los títulos de las tarjetas.
class IconTile extends StatelessWidget {
  const IconTile({super.key, required this.icon, this.color = AppColors.blue});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 21, color: color),
    );
  }
}
