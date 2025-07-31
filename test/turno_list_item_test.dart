import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_prueba/features/turnos/presentation/widgets/turno_list_item.dart';
import 'package:proyecto_prueba/features/turnos/domain/entities/turno.dart';

void main() {
  group('TurnoListItem Widget', () {
    // Datos de ejemplo
    final ejemplo = Turno(
      id: '1',
      rolRequerido: 'Camarero',
      zona: 'Sala Principal',
      fechaInicio: DateTime(2024, 6, 1, 10, 0),
      fechaFin: DateTime(2024, 6, 1, 14, 0),
      duracionHoras: 4.0,
      pagoOfrecido: 25.0,
      notas: 'Experiencia en restaurantes de alta cocina requerida',
      estado: 'abierto',
      tipo: 'Tiempo completo',
      fechaCreacion: DateTime(2024, 5, 30),
      fechaActualizacion: DateTime(2024, 5, 30),
    );

    testWidgets('Muestra los datos principales del turno', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TurnoListItem(turno: ejemplo),
          ),
        ),
      );

      expect(find.text('Camarero'), findsOneWidget);
      expect(find.text('Sala Principal'), findsOneWidget);
      expect(find.text('4.0h'), findsOneWidget);
      expect(find.text(' 25.00'), findsOneWidget);
      expect(find.text('Tiempo completo'), findsOneWidget);
      expect(find.textContaining('Experiencia en restaurantes'), findsOneWidget);
      expect(find.text('Abierto'), findsOneWidget);
    });
  });
} 