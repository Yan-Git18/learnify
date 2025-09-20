import 'lesson.dart';

class ProgressLesson {
  final String lessonId;   
  final String userId;     
  final bool completada;   
  final int intentos;      
  final int puntuacion;

  ProgressLesson({
    required this.lessonId,
    required this.userId,
    this.completada = false,
    this.intentos = 0,
    this.puntuacion = 0,
  });

  // Crear desde Firestore
  factory ProgressLesson.fromFirestore(String id, Map<String, dynamic> data) {
    return ProgressLesson(
      lessonId: data['lessonId'] ?? '',
      userId: data['userId'] ?? '',
      completada: data['completada'] ?? false,
      intentos: data['intentos'] ?? 0,
      puntuacion: data['puntuacion'] ?? 0,
    );
  }

  // Convertir a Map para guardar en Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'lessonId': lessonId,
      'userId': userId,
      'completada': completada,
      'intentos': intentos,
      'puntuacion': puntuacion,
    };
  }

  // Crear copia modificada
  ProgressLesson copyWith({
    String? lessonId,
    String? userId,
    bool? completada,
    int? intentos,
    int? puntuacion,
  }) {
    return ProgressLesson(
      lessonId: lessonId ?? this.lessonId,
      userId: userId ?? this.userId,
      completada: completada ?? this.completada,
      intentos: intentos ?? this.intentos,
      puntuacion: puntuacion ?? this.puntuacion,
    );
  }

  //Calcular puntos de una lección
  static int calcularPuntos(Lesson lesson, {int intentos = 1}) {
    const int puntosBase = 10;
    final int bonificacion = (lesson.prerequisitos?.length ?? 0) * 2; 
    final int penalizacion = (intentos - 1) * 1;

    return (puntosBase + bonificacion - penalizacion).clamp(0, 100);
  }

  @override
  String toString() =>
      'ProgressLesson{lessonId: $lessonId, completada: $completada, intentos: $intentos, puntuacion: $puntuacion}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressLesson &&
          runtimeType == other.runtimeType &&
          lessonId == other.lessonId &&
          userId == other.userId;

  @override
  int get hashCode => lessonId.hashCode ^ userId.hashCode;
}
