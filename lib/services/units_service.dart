import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnify/models/lesson.dart';
import 'package:learnify/models/unit.dart';
import '../models/progress_lesson.dart';

class UnitsService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtener las unidades de firestore
  static Future<List<Unit>> obtenerUnidades() async {
    final snapshot = await _db.collection('unidades').orderBy('orden').get();

    List<Unit> unidades = [];

    for (var doc in snapshot.docs) {
      // Obtener lecciones de cada unidad
      final leccionesSnapshot = await _db
          .collection('unidades/${doc.id}/lecciones')
          .orderBy('orden')
          .get();

      final lecciones = leccionesSnapshot.docs.map((lDoc) {
        return Lesson.fromFirestore(lDoc.id, lDoc.data());
      }).toList();

      unidades.add(
        Unit.fromFirestore(doc.id, doc.data(), lecciones),
      );
    }

    return unidades;
  }

  // Obtener progreso del usuario para todas las lecciones
  static Future<Map<String, ProgressLesson>> obtenerProgresoUsuario(
      String userId) async {
    final snapshot =
        await _db.collection('usuarios/$userId/progreso_lecciones').get();

    return {
      for (var doc in snapshot.docs)
        doc.id: ProgressLesson.fromFirestore(doc.id, doc.data())
    };
  }

  // Unir contenido + progreso
  static Future<List<Unit>> obtenerUnidadesConProgreso(String userId) async {
    final unidades = await obtenerUnidades();
    final progreso = await obtenerProgresoUsuario(userId);

    for (var unidad in unidades) {
      for (var i = 0; i < unidad.lecciones.length; i++) {
        final leccion = unidad.lecciones[i];
        final progresoLeccion = progreso[leccion.id];

        if (progresoLeccion != null) {
          unidad.lecciones[i] = leccion.copyWith(
            completada: progresoLeccion.completada,
          );
        }
      }
    }
    return unidades;
  }

  // Marcar lección como completada
  static Future<void> completarLeccion(
      String userId, Lesson leccion, int intentos) async {
    final ref =
        _db.collection('usuarios/$userId/progreso_lecciones').doc(leccion.id);

    final puntos = ProgressLesson.calcularPuntos(leccion, intentos: intentos);

    await ref.set({
      'lessonId': leccion.id,
      'userId': userId,
      'completada': true,
      'intentos': intentos,
      'puntuacion': puntos,
      'ultimaVez': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
