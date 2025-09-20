
import '../models/unit.dart';
import '../models/lesson.dart';

/// Datos iniciales para poblar Firestore (seeding)
class UnitsSeed {
  static List<Unit> get unidades => [
        Unit(
          id: 'unidad_1',
          nombre: 'Fundamentos',
          descripcion: 'Aprende los conceptos básicos del idioma.',
          orden: 1,
          lecciones: [
            Lesson(
              id: 'unidad_1_leccion_1',
              titulo: 'Saludos',
              orden: 1,
              descripcion: 'Aprende a saludar y presentarte.',
            ),
            Lesson(
              id: 'unidad_1_leccion_2',
              titulo: 'Presentaciones',
              orden: 2,
              descripcion: 'Aprende a decir tu nombre y preguntar el de otros.',
              prerequisitos: ['unidad_1_leccion_1'],
            ),
          ],
        ),
        Unit(
          id: 'unidad_2',
          nombre: 'Gramática básica',
          descripcion: 'Construye frases simples y útiles.',
          orden: 2,
          bloqueada: true,
          lecciones: [
            Lesson(
              id: 'unidad_2_leccion_1',
              titulo: 'Artículos y sustantivos',
              orden: 1,
              descripcion:
                  'Aprende el uso de artículos definidos e indefinidos.',
            ),
            Lesson(
              id: 'unidad_2_leccion_2',
              titulo: 'Verbos básicos',
              orden: 2,
              descripcion: 'Aprende los verbos más comunes en presente.',
              prerequisitos: ['unidad_2_leccion_1'],
            ),
          ],
        ),
      ];
}
