import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'bottom_nav.dart';
import 'calendar_card.dart';
import 'header_banner.dart';
import 'phone_emulator.dart';
import 'side_panels.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendario',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const _PhoneScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
      ),
      // En pantallas anchas la app se muestra dentro de un teléfono simulado.
      builder: (context, child) => PhoneEmulator(child: child!),
      home: const CalendarScreen(),
    );
  }
}

// Comportamiento de scroll de celular: se arrastra con el mouse y no hay barra.
class _PhoneScrollBehavior extends MaterialScrollBehavior {
  const _PhoneScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SoftBackground(),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              // Espacio inferior para que la barra de navegación no tape el contenido.
              padding: EdgeInsets.fromLTRB(16, 16, 16, 96 + bottomInset),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: const Column(
                    children: [
                      HeaderBanner(),
                      SizedBox(height: 18),
                      CalendarCard(),
                      SizedBox(height: 18),
                      LegendCard(),
                      SizedBox(height: 18),
                      UpcomingCard(),
                      SizedBox(height: 18),
                      MotivationCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: bottomInset + 6,
            child: const BottomNav(),
          ),
        ],
      ),
    );
  }
}

// Fondo claro con manchas de color difuminadas (las tarjetas de vidrio las
// desenfocan al pasar por encima).
class _SoftBackground extends StatelessWidget {
  const _SoftBackground();

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
              colors: [Color(0xFFE8EFFF), Color(0xFFF5F7FF), Color(0xFFF1ECFF)],
            ),
          ),
        ),
        const Positioned(
          top: -140,
          left: -120,
          child: _Blob(size: 460, color: AppColors.blue),
        ),
        const Positioned(
          top: 320,
          right: -160,
          child: _Blob(size: 520, color: AppColors.violet),
        ),
        const Positioned(
          bottom: -180,
          left: 80,
          child: _Blob(size: 460, color: Color(0xFF38BDF8)),
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

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
          colors: [color.withValues(alpha: 0.30), color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}
