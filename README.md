# Portafolio · Aplicaciones Móviles Multiplataforma

Repositorio con los laboratorios del curso **Aplicaciones Móviles Multiplataforma** (5.º ciclo, 2026-2, Tecsup), desarrollados con **Dart** y **Flutter**.

**Autor:** Rony Quintana

## Contenido

Cada semana tiene su propia carpeta `SEMANAxx/`. Las semanas se van completando a lo largo del ciclo.

| Semana | Tema | Contenido | Estado |
|:------:|------|-----------|:------:|
| [01](SEMANA01/) | Introducción a Dart y Flutter | [`Lab01.dart`](SEMANA01/Lab01.dart) (Hello World en Dart) y [`flutter_application_1`](SEMANA01/Laboratorio01/flutter_application_1/), el proyecto base de Flutter (contador) | Con código |
| [02](SEMANA02/) | Manejo de clases en Dart | Herencia, constructores con nombre, clases abstractas y polimorfismo. Se resolvió en una guía de Word que no se versiona; la carpeta aún no tiene código | Guía resuelta |
| [03](SEMANA03/) | Mixins en Dart | Ejercicios de control de acceso, calculadora, empleados, inventario y votación. Se resolvieron en una guía de Word que no se versiona; la carpeta solo tiene el proyecto base [`flutter_application_1`](SEMANA03/Laboratorio03/flutter_application_1/) | Guía resuelta |
| [06](SEMANA06/) | Diseño de un calendario en Flutter | [`flutter_application_6`](SEMANA06/flutter_application_6/): diseño visual de un calendario con `Row` y `Column` | Con código |

Las semanas 04, 05 y 07 a 16 ya tienen su carpeta creada y se irán llenando conforme avance el curso.

## Estructura

```
.
├── SEMANA01/
│   ├── Lab01.dart
│   └── Laboratorio01/flutter_application_1/
├── SEMANA02/Laboratorio02/
├── SEMANA03/Laboratorio03/flutter_application_1/
├── SEMANA04/ … SEMANA16/          (por completar)
└── SEMANA06/flutter_application_6/
```

## Laboratorio destacado: calendario (Semana 6)

El enunciado pedía **solo el diseño** de un calendario, usando principalmente `Row` y `Column`, sin funcionalidad, base de datos ni navegación entre meses. Se evaluaba con 20 puntos: diseño visual y personalización, uso de `Row`/`Column`, organización de elementos, eventos con día destacado, y orden del código.

Lo que incluye la solución:

- **Calendario de octubre de 2026** con cuadrícula de días, día actual destacado y eventos marcados por tipo (clase, reunión, proyecto y festivo), cada uno con su color e ícono.
- **Tarjetas complementarias:** encabezado con paisaje dibujado con `CustomPainter`, leyenda de tipos de evento, próximos eventos y una tarjeta de motivación.
- **Estilo de vidrio** (*glassmorphism*) sobre un fondo con degradados difuminados, tipografía **Poppins** y Material 3.
- **Emulador de teléfono:** en pantallas anchas la app se muestra dentro de un teléfono simulado de 393 × 852; en pantallas angostas ocupa toda la pantalla sin marco.
- Se puede ejecutar en Flutter Web desde el navegador, sin dispositivo móvil.

Código organizado por widget en [`lib/`](SEMANA06/flutter_application_6/lib/): `main.dart`, `app_theme.dart`, `calendar_data.dart`, `calendar_card.dart`, `header_banner.dart`, `side_panels.dart`, `bottom_nav.dart` y `phone_emulator.dart`.

## Cómo ejecutar un proyecto

Requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (los proyectos usan Dart `^3.13`) y `flutter doctor` sin errores.

```bash
cd SEMANA06/flutter_application_6
flutter pub get
flutter run -d chrome      # navegador
flutter run -d windows     # escritorio Windows
```

El mismo procedimiento sirve para `flutter_application_1` de las semanas 1 y 3. Para ver los dispositivos disponibles, usa `flutter devices`.

## Tecnologías

- [Dart](https://dart.dev/)
- [Flutter](https://flutter.dev/) con Material 3
- Tipografía Poppins (incluida en `assets/fonts/` del proyecto de la semana 6)

## Archivos que no se versionan

El [`.gitignore`](.gitignore) excluye del repositorio:

- El instalador del SDK de Flutter (`flutter_windows_*.zip`), que pesa cerca de 1,7 GB y se descarga desde flutter.dev.
- Los documentos de Word (`*.doc`, `*.docx`) con las guías y entregables de los laboratorios.

Cada proyecto de Flutter trae además su propio `.gitignore`, que excluye `build/`, `.dart_tool/` y otros archivos generados.
