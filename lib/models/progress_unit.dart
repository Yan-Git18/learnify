
class ProgressUnit {
  final String unidadId;          
  final String userId;             
  final bool completada;           
  final int leccionesCompletadas;  
  final int totalLecciones;        

  ProgressUnit({
    required this.unidadId,
    required this.userId,
    required this.completada,
    required this.leccionesCompletadas,
    required this.totalLecciones,
  });

  // Crear progreso desde Firestore
  factory ProgressUnit.fromFirestore(String id, Map<String, dynamic> data) {
    return ProgressUnit(
      unidadId: data['unidadId'] ?? '',
      userId: data['userId'] ?? '',
      completada: data['completada'] ?? false,
      leccionesCompletadas: data['leccionesCompletadas'] ?? 0,
      totalLecciones: data['totalLecciones'] ?? 0,
    );
  }

  // Convertir progreso a Map para guardar en Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'unidadId': unidadId,
      'userId': userId,
      'completada': completada,
      'leccionesCompletadas': leccionesCompletadas,
      'totalLecciones': totalLecciones,
    };
  }

  // Calcular progreso como porcentaje
  double get progreso {
    if (totalLecciones == 0) return 0.0;
    return leccionesCompletadas / totalLecciones;
  }

  int get porcentajeProgreso => (progreso * 100).round();

  // Crear una copia modificada
  ProgressUnit copyWith({
    String? unidadId,
    String? userId,
    bool? completada,
    int? leccionesCompletadas,
    int? totalLecciones,
  }) {
    return ProgressUnit(
      unidadId: unidadId ?? this.unidadId,
      userId: userId ?? this.userId,
      completada: completada ?? this.completada,
      leccionesCompletadas: leccionesCompletadas ?? this.leccionesCompletadas,
      totalLecciones: totalLecciones ?? this.totalLecciones,
    );
  }

  @override
  String toString() =>
      'ProgressUnit{unidadId: $unidadId, progreso: $porcentajeProgreso %, completada: $completada}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressUnit &&
          runtimeType == other.runtimeType &&
          unidadId == other.unidadId &&
          userId == other.userId;

  @override
  int get hashCode => unidadId.hashCode ^ userId.hashCode;
}
