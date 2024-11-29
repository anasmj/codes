import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_patient_libs/src/services/base.service.dart';

class FirebaseCRUD {
  ///take collection name from outside
  FirebaseCRUD({required this.collection});
  final String collection;

  CollectionReference get _collection =>
      FirebaseFirestore.instance.collection(collection);

  Future<String?> create(RawData data) async {
    try {
      DocumentReference docRef = await _collection.add(data);
      return docRef.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getSingle(String id) async {
    try {
      DocumentSnapshot doc = await _collection.doc(id).get();
      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (e) {
      // print("Error reading document: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    try {
      QuerySnapshot querySnapshot = await _collection.get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {...data, 'id': doc.id};
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> update(String id, Map<String, dynamic> data) async {
    try {
      await _collection.doc(id).update(data);
      return true;
    } catch (e) {
      // print("Error updating document: $e");
      rethrow;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await _collection.doc(id).delete();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
