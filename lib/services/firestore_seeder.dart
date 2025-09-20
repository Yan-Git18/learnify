import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnify/data/units_seed.dart';


class FirestoreSeeder {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> subirUnidades() async {
    for (var unidad in UnitsSeed.unidades) {
      final unidadRef = _db.collection('unidades').doc(unidad.id);

      await unidadRef.set(unidad.toFirestore());

      // Subir lecciones dentro de la unidad
      for (var leccion in unidad.lecciones) {
        await unidadRef
            .collection('lecciones')
            .doc(leccion.id)
            .set(leccion.toFirestore());
      }
    }
    print("✅ Datos de unidades y lecciones subidos correctamente");
  }
}
