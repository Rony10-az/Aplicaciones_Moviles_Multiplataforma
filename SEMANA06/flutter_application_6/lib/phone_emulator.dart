import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_theme.dart';

// Tamaño lógico de la pantalla del teléfono simulado (tipo iPhone 15).
const double kPhoneWidth = 393;
const double kPhoneHeight = 852;

const double _bezel = 12;
const double _bodyWidth = kPhoneWidth + _bezel * 2;
const double _bodyHeight = kPhoneHeight + _bezel * 2;
const double _statusBarHeight = 54;
const double _homeIndicatorHeight = 30;

// Panel de herramientas a la derecha (y un espacio igual a la izquierda para
// que el teléfono quede centrado).
const double _toolbarWidth = 56;
const double _toolbarGap = 18;
const double _sideSpace = _toolbarWidth + _toolbarGap;
const double _captionHeight = 40;

// Muestra la app dentro de un teléfono. Si la ventana es angosta (un celular
// real), deja la app a pantalla completa sin marco.
class PhoneEmulator extends StatelessWidget {
  const PhoneEmulator({super.key, required this.child});

  final Widget child;

  static const double _minWidth = 500;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _minWidth) return child;

        const stageWidth = _bodyWidth + _sideSpace * 2;
        const stageHeight = _bodyHeight + _captionHeight;
        final scale = math.min(
          1.0,
          math.min(
            (constraints.maxWidth - 32) / stageWidth,
            (constraints.maxHeight - 32) / stageHeight,
          ),
        );

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const _StageBackground(),
              Center(
                child: SizedBox(
                  width: stageWidth * scale,
                  height: stageHeight * scale,
                  child: FittedBox(
                    child: SizedBox(
                      width: stageWidth,
                      height: stageHeight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: _sideSpace,
                            top: 0,
                            child: _PhoneBody(child: child),
                          ),
                          const Positioned(
                            right: 0,
                            top: 150,
                            child: _Toolbar(),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Center(child: _Caption(scale: scale)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Fondo del escenario
// ---------------------------------------------------------------------------

class _StageBackground extends StatelessWidget {
  const _StageBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD5E2FF), Color(0xFFE8ECFF), Color(0xFFE2D9FF)],
            ),
          ),
        ),
        Positioned(
          top: -160,
          left: -140,
          child: _Glow(size: 560, color: AppColors.blue),
        ),
        Positioned(
          bottom: -200,
          right: -120,
          child: _Glow(size: 620, color: AppColors.violet),
        ),
        Positioned(
          top: 200,
          right: 260,
          child: _Glow(size: 380, color: const Color(0xFF38BDF8)),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.32), color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cuerpo del teléfono
// ---------------------------------------------------------------------------

class _PhoneBody extends StatelessWidget {
  const _PhoneBody({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const bodyRadius = BorderRadius.all(Radius.circular(64));
    const screenRadius = BorderRadius.all(Radius.circular(52));

    return SizedBox(
      width: _bodyWidth,
      height: _bodyHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Botones laterales.
          const Positioned(left: -3.5, top: 108, child: _SideButton(height: 28)),
          const Positioned(left: -3.5, top: 168, child: _SideButton(height: 54)),
          const Positioned(left: -3.5, top: 236, child: _SideButton(height: 54)),
          const Positioned(right: -3.5, top: 200, child: _SideButton(height: 92)),
          Container(
            padding: const EdgeInsets.all(_bezel),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0E19),
              borderRadius: bodyRadius,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF14286E).withValues(alpha: 0.35),
                  blurRadius: 80,
                  offset: const Offset(0, 40),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.20),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: bodyRadius,
              border: Border.all(color: const Color(0xFF3B445C), width: 2),
            ),
            child: ClipRRect(
              borderRadius: screenRadius,
              child: Stack(
                children: [
                  // La app ve una pantalla de teléfono con sus márgenes seguros.
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      size: const Size(kPhoneWidth, kPhoneHeight),
                      padding: const EdgeInsets.only(
                        top: _statusBarHeight,
                        bottom: _homeIndicatorHeight,
                      ),
                      viewPadding: const EdgeInsets.only(
                        top: _statusBarHeight,
                        bottom: _homeIndicatorHeight,
                      ),
                    ),
                    child: child,
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: _statusBarHeight,
                    child: _StatusBar(),
                  ),
                  const Positioned(
                    top: 11,
                    left: 0,
                    right: 0,
                    child: Center(child: _DynamicIsland()),
                  ),
                  const Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(child: _HomeIndicator()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  const _SideButton({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.5,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2B3348),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 30, 0),
      child: Row(
        children: [
          Text(
            '9:41',
            style: poppins(15, weight: FontWeight.w600, height: 1),
          ),
          const Spacer(),
          const Icon(Icons.signal_cellular_alt_rounded, size: 18, color: AppColors.ink),
          const SizedBox(width: 5),
          const Icon(Icons.wifi_rounded, size: 18, color: AppColors.ink),
          const SizedBox(width: 6),
          const _Battery(),
        ],
      ),
    );
  }
}

class _Battery extends StatelessWidget {
  const _Battery();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 25,
          height: 12.5,
          padding: const EdgeInsets.all(1.6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.ink.withValues(alpha: 0.45)),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Container(
          width: 1.8,
          height: 4.5,
          margin: const EdgeInsets.only(left: 1),
          decoration: BoxDecoration(
            color: AppColors.ink.withValues(alpha: 0.45),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
          ),
        ),
      ],
    );
  }
}

class _DynamicIsland extends StatelessWidget {
  const _DynamicIsland();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      height: 34,
      padding: const EdgeInsets.only(right: 12),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 11,
        height: 11,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [Color(0xFF2A3B7A), Color(0xFF0A0F24)],
          ),
          border: Border.all(color: const Color(0xFF1B2140)),
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 5,
      decoration: BoxDecoration(
        color: AppColors.ink.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Barra de herramientas del emulador (solo visual)
// ---------------------------------------------------------------------------

class _Toolbar extends StatelessWidget {
  const _Toolbar();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 28,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: _toolbarWidth - 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _ToolButton(icon: Icons.power_settings_new_rounded),
            const _ToolButton(icon: Icons.volume_up_rounded),
            const _ToolButton(icon: Icons.volume_down_rounded),
            const _ToolDivider(),
            const _ToolButton(icon: Icons.screen_rotation_rounded),
            const _ToolButton(icon: Icons.photo_camera_outlined),
            const _ToolButton(icon: Icons.zoom_in_rounded),
            const _ToolDivider(),
            const _ToolButton(icon: Icons.more_horiz_rounded),
          ],
        ),
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Icon(icon, size: 22, color: AppColors.muted),
    );
  }
}

class _ToolDivider extends StatelessWidget {
  const _ToolDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: AppColors.line,
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.smartphone_rounded, size: 15, color: AppColors.blue),
          const SizedBox(width: 6),
          Text(
            '${kPhoneWidth.toInt()} × ${kPhoneHeight.toInt()}  ·  ${(scale * 100).round()}%',
            style: poppins(12, weight: FontWeight.w600, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
