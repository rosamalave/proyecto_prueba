class Turno {
  final String id;         // Identificador único
  final String rolRequerido;
  final String zona; //zona del local a cubrir, puede ser null
  final DateTime fechaInicio; //fecha del turno
  final DateTime fechaFin; //fecha de fin del turno
  final double duracionHoras;
  final double pagoOfrecido;
  final String notas;
  final String estado; // ej. 'abierto', 'cerrado', 'cancelado', 'borrador'
  final String tipo;
  final DateTime fechaCreacion;  // Fecha de creación
  final DateTime fechaActualizacion;  // Fecha de última actualización

  Turno({
    required this.id,
    required this.rolRequerido,
    required this.zona,
    required this.fechaInicio,
    required this.fechaFin,
    required this.duracionHoras,
    required this.pagoOfrecido,
    required this.notas,
    required this.estado,
    required this.tipo,
    required this.fechaCreacion,
    required this.fechaActualizacion,
  });

  // Método ejemplo para validar que el id no esté vacío
  bool isValid() {
    return id.isNotEmpty;
  }

  // Método para actualizar la fecha de actualización
  Turno copyWith({
    String? id,
    String? rolRequerido,
    String? zona,
    DateTime? fechaInicio,
    DateTime? fechaFin,
    double? duracionHoras,
    double? pagoOfrecido,
    String? notas,
    String? estado,
    String? tipo,
    DateTime? fechaCreacion,
    DateTime? fechaActualizacion,
  }) {
    return Turno(
      id: id ?? this.id,
      rolRequerido: rolRequerido ?? this.rolRequerido,
      zona: zona ?? this.zona,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      duracionHoras: duracionHoras ?? this.duracionHoras,
      pagoOfrecido: pagoOfrecido ?? this.pagoOfrecido,
      notas: notas ?? this.notas,
      estado: estado ?? this.estado,
      tipo: tipo ?? this.tipo,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
    );
  }
}