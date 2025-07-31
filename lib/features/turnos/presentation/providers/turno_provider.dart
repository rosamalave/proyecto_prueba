import 'package:flutter/foundation.dart';
//import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/turno.dart';
import '../../domain/usecases/obtener_todos_los_turnos.dart';
import '../../data/repositories/turno_repository_impl.dart';
//import '../../../../failures/failure.dart';
//import '../widgets/turno_list_item.dart';

// Estados para el provider
enum TurnoEstado {
  initial,
  loading,
  loaded,
  error,
}

// Provider principal del estado de turnos
class TurnoProvider extends ChangeNotifier {
  final ObtenerTodosLosTurnos _obtenerTodosLosTurnos;
  
  TurnoProvider(this._obtenerTodosLosTurnos);

  TurnoEstado _estado = TurnoEstado.initial;
  List<Turno> _turnos = [];
  String? _errorMensaje;

  // Getters
  TurnoEstado get estado => _estado;
  List<Turno> get turnos => _turnos;
  String? get errorMensaje => _errorMensaje;
  bool get estaCargando => _estado == TurnoEstado.loading;
  bool get tieneError => _estado == TurnoEstado.error;

  // Cargar todos los turnos
  Future<void> cargarTurnos() async {
    _estado = TurnoEstado.loading;
    _errorMensaje = null;
    notifyListeners();
    
    final result = await _obtenerTodosLosTurnos();
    
    result.fold(
      (failure) {
        _estado = TurnoEstado.error;
        _errorMensaje = failure.mensaje;
        notifyListeners();
      },
      (turnos) {
        _estado = TurnoEstado.loaded;
        _turnos = turnos;
        notifyListeners();
      },
    );
  }

  // Refrescar turnos
  Future<void> refrescarTurnos() async {
    await cargarTurnos();
  }

  // Obtener turno por ID
  Turno? obtenerTurnoPorId(String id) {
    try {
      return _turnos.firstWhere((turno) => turno.id == id);
    } catch (e) {
      return null;
    }
  }

  // Filtrar turnos por estado
  List<Turno> filtrarTurnosPorEstado(String estado) {
    return _turnos.where((turno) => turno.estado == estado).toList();
  }

  // Filtrar turnos por fecha
  List<Turno> filtrarTurnosPorFecha(DateTime fecha) {
    return _turnos.where((turno) {
      final turnoFecha = DateTime(
        turno.fechaInicio.year,
        turno.fechaInicio.month,
        turno.fechaInicio.day,
      );
      final fechaFiltro = DateTime(
        fecha.year,
        fecha.month,
        fecha.day,
      );
      return turnoFecha.isAtSameMomentAs(fechaFiltro);
    }).toList();
  }

  // Filtrar turnos por zona
  List<Turno> filtrarTurnosPorZona(String zona) {
    return _turnos.where((turno) => turno.zona == zona).toList();
  }

  // Filtrar turnos por rol requerido
  List<Turno> filtrarTurnosPorRol(String rol) {
    return _turnos.where((turno) => turno.rolRequerido == rol).toList();
  }

  // Obtener turnos abiertos
  List<Turno> get turnosAbiertos => filtrarTurnosPorEstado('abierto');

  // Obtener turnos cerrados
  List<Turno> get turnosCerrados => filtrarTurnosPorEstado('cerrado');

  // Obtener turnos cancelados
  List<Turno> get turnosCancelados => filtrarTurnosPorEstado('cancelado');

  // Obtener turnos de hoy
  List<Turno> get turnosDeHoy {
    final hoy = DateTime.now();
    return filtrarTurnosPorFecha(hoy);
  }

  // Obtener turnos de esta semana
  List<Turno> get turnosDeEstaSemana {
    final ahora = DateTime.now();
    final inicioSemana = ahora.subtract(Duration(days: ahora.weekday - 1));
    final finSemana = inicioSemana.add(const Duration(days: 6));
    
    return _turnos.where((turno) {
      return turno.fechaInicio.isAfter(inicioSemana.subtract(const Duration(days: 1))) &&
             turno.fechaInicio.isBefore(finSemana.add(const Duration(days: 1)));
    }).toList();
  }

  // Limpiar estado
  void limpiarEstado() {
    _estado = TurnoEstado.initial;
    _turnos = [];
    _errorMensaje = null;
    notifyListeners();
  }

  // Limpiar error
  void limpiarError() {
    if (_estado == TurnoEstado.error) {
      _estado = TurnoEstado.initial;
      _errorMensaje = null;
      notifyListeners();
    }
  }
}

// Factory para crear el provider
class TurnoProviderFactory {
  static TurnoProvider crear() {
    final firestore = FirebaseFirestore.instance;
    final repository = TurnoRepositoryImpl(firestore: firestore);
    final useCase = ObtenerTodosLosTurnos(repository);
    return TurnoProvider(useCase);
  }
}
