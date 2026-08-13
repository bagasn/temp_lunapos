import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  /// Get all documents from a collection.
  Future<List<Map<String, dynamic>>> getAll(String collectionPath) async {
    final snapshot = await _firestore.collection(collectionPath).get();
    return snapshot.docs.map((d) => d.data()).toList();
  }

  /// Stream all documents from a collection.
  Stream<List<Map<String, dynamic>>> streamAll(String collectionPath) {
    return _firestore
        .collection(collectionPath)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((d) => {'id': d.id, ...d.data()}).toList(),
        );
  }

  /// Add a single document.
  Future<String> addDocument(
    String collectionPath,
    Map<String, dynamic> data,
  ) async {
    final ref = await _firestore.collection(collectionPath).add(data);
    return ref.id;
  }

  /// Set a document with a specific ID.
  Future<void> setDocument(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(collectionPath)
        .doc(documentId)
        .set(data, SetOptions(merge: true));
  }

  /// Update specific fields of a document.
  Future<void> updateDocument(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionPath).doc(documentId).update(data);
  }

  /// Delete a document.
  Future<void> deleteDocument(String collectionPath, String documentId) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  /// Stream a single document.
  Stream<Map<String, dynamic>?> streamDocument(
    String collectionPath,
    String documentId,
  ) {
    return _firestore
        .collection(collectionPath)
        .doc(documentId)
        .snapshots()
        .map((snap) => snap.exists ? {'id': snap.id, ...snap.data()!} : null);
  }
}

@module
abstract class FirebaseModule {
  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
