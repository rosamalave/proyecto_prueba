// lib/data/repositories/turno_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/turno.dart';
import '../../domain/repositories/turno_repository.dart';
import '../../../../failures/failure.dart';
import '../models/turno_model.dart';

class TurnoRepositoryImpl implements TurnoRepository {
  final FirebaseFirestore firestore;

  TurnoRepositoryImpl({required this.firestore});

  @override
  Future<Either<Failure, List<Turno>>> obtenerTodosLosTurnos() async {
    try {
      final snapshot = await firestore.collection('turno').get();
      final turnos = snapshot.docs
          .map((doc) => TurnoModel.fromMap(doc.data(), doc.id) as Turno)
          .toList();
      return Right(turnos);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Turno>> obtenerTurnoPorId(String id) async {
    try {
      final doc = await firestore.collection('turno').doc(id).get();
      if (doc.exists) {
        final turno = TurnoModel.fromMap(doc.data()!, doc.id);
        return Right(turno);
      } else {
        return Left(ServerFailure('Turno no encontrado'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> crearTurno(Turno turno) async {
    try {
      final model = TurnoModel(
        id: turno.id,
        rolRequerido: turno.rolRequerido,
        zona: turno.zona,
        fechaInicio: turno.fechaInicio,
        fechaFin: turno.fechaFin,
        duracionHoras: turno.duracionHoras,
        pagoOfrecido: turno.pagoOfrecido,
        notas: turno.notas,
        estado: turno.estado,
        tipo: turno.tipo,
        fechaCreacion: turno.fechaCreacion,
        fechaActualizacion: turno.fechaActualizacion,
      );
      await firestore.collection('turno').doc(turno.id).set(model.toMap());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> actualizarTurno(Turno turno) async {
    try {
      final model = TurnoModel(
        id: turno.id,
        rolRequerido: turno.rolRequerido,
        zona: turno.zona,
        fechaInicio: turno.fechaInicio,
        fechaFin: turno.fechaFin,
        duracionHoras: turno.duracionHoras,
        pagoOfrecido: turno.pagoOfrecido,
        notas: turno.notas,
        estado: turno.estado,
        tipo: turno.tipo,
        fechaCreacion: turno.fechaCreacion,
        fechaActualizacion: turno.fechaActualizacion,
      );
      await firestore.collection('turno').doc(turno.id).update(model.toMap());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> eliminarTurno(String id) async {
    try {
      await firestore.collection('turno').doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}