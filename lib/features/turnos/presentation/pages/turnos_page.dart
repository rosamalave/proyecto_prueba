import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../core/presentation/widgets/error_widget.dart';
import '../providers/turno_provider.dart';
import '../widgets/turno_list_item.dart';

class TurnosPage extends StatefulWidget {
  const TurnosPage({super.key});

  @override
  State<TurnosPage> createState() => _TurnosPageState();
}

class _TurnosPageState extends State<TurnosPage> {
  late TurnoProvider _turnoProvider;

  @override
  void initState() {
    super.initState();
    _turnoProvider = TurnoProviderFactory.crear();
    _turnoProvider.addListener(_onProviderChanged);
    _cargarTurnos();
  }

  @override
  void dispose() {
    _turnoProvider.removeListener(_onProviderChanged);
    super.dispose();
  }

  void _onProviderChanged() {
    setState(() {});
  }

  Future<void> _cargarTurnos() async {
    await _turnoProvider.cargarTurnos();
  }

  Future<void> _refrescarTurnos() async {
    await _turnoProvider.refrescarTurnos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos Disponibles'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refrescarTurnos,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_turnoProvider.estaCargando) {
      return const LoadingWidget(mensaje: 'Cargando turnos...');
    }

    if (_turnoProvider.tieneError) {
      return CustomErrorWidget(
        mensaje: _turnoProvider.errorMensaje ?? 'Error desconocido',
        onRetry: _cargarTurnos,
        titulo: 'Error al cargar turnos',
        icono: Icons.schedule,
      );
    }

    if (_turnoProvider.turnos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.schedule,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No hay turnos disponibles',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refrescarTurnos,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _turnoProvider.turnos.length,
        itemBuilder: (context, index) {
          final turno = _turnoProvider.turnos[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TurnoListItem(turno: turno),
          );
        },
      ),
    );
  }
} 