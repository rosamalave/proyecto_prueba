
import 'package:dartz/dartz.dart';
import '../entities/turno.dart';
import '../../../../failures/failure.dart';

abstract class TurnoRepository {
  Future<Either<Failure, List<Turno>>> obtenerTodosLosTurnos();

  Future<Either<Failure, Turno>> obtenerTurnoPorId(String id);

  Future<Either<Failure, void>> crearTurno(Turno recurso);

  Future<Either<Failure, void>> actualizarTurno(Turno recurso);

  Future<Either<Failure, void>> eliminarTurno(String id);
}