import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/turno.dart';

class TurnoModel extends Turno {
  TurnoModel({
    required super.id,
    required super.rolRequerido,
    required super.zona,
    required super.fechaInicio,
    required super.fechaFin,
    required super.duracionHoras,
    required super.pagoOfrecido,
    required super.notas,
    required super.estado,
    required super.tipo,
    required super.fechaCreacion,
    required super.fechaActualizacion,
  });

  /// Convierte un documento Firestore a un modelo TurnoModel
  factory TurnoModel.fromMap(Map<String, dynamic> map, String id) {
    return TurnoModel(
      id: id,
      rolRequerido: map['rolRequerido'],
      zona: map['zona'],
      fechaInicio: (map['fechaInicio'] as Timestamp).toDate(),
      fechaFin: (map['fechaFin'] as Timestamp).toDate(),
      duracionHoras: map['duracionHoras'].toDouble(),
      pagoOfrecido: map['pagoOfrecido'].toDouble(),
      notas: map['notas'],
      estado: map['estado'],
      tipo: map['tipo'],
      fechaCreacion: (map['fechaCreacion'] as Timestamp).toDate(),
      fechaActualizacion: (map['fechaActualizacion'] as Timestamp).toDate(),
    );
  }

  /// Convierte el modelo Turno a un mapa para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'rolRequerido': rolRequerido,
      'zona': zona,
      'fechaInicio': Timestamp.fromDate(fechaInicio),
      'fechaFin': Timestamp.fromDate(fechaFin),
      'duracionHoras': duracionHoras,
      'pagoOfrecido': pagoOfrecido,
      'notas': notas,
      'estado': estado,
      'tipo': tipo,
      'fechaCreacion': Timestamp.fromDate(fechaCreacion),
      'fechaActualizacion': Timestamp.fromDate(fechaActualizacion),
    };
  }
}