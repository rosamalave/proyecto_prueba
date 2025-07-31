import 'package:dartz/dartz.dart';
import '../repositories/turno_repository.dart';
import '../entities/turno.dart';
import '../../../../failures/failure.dart';

class ObtenerTodosLosTurnos {
  final TurnoRepository repository;

  ObtenerTodosLosTurnos(this.repository);

  Future<Either<Failure, List<Turno>>> call() {
    return repository.obtenerTodosLosTurnos();
  }
}
