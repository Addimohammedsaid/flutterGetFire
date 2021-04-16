import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CloudFirestoreApi {
  final String collection;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // collections is required
  CloudFirestoreApi({@required this.collection});

  // STREAM request
  Stream<QuerySnapshot> getStreamCollection() =>
      firestore.collection(collection).snapshots();

  Stream<DocumentSnapshot> getStreamDocument(id) =>
      firestore.collection(collection).doc(id).snapshots();

  // GET request
  Future<QuerySnapshot> getCollection() =>
      firestore.collection(collection).get();

  Future<DocumentSnapshot> getDocument(id) =>
      firestore.collection(collection).doc(id).get();

  // Post request
  Future<void> postDocument(obj, {id}) async => id != null
      ? await firestore.collection(collection).doc(id).set(obj)
      : await firestore.collection(collection).doc().set(obj);

  // update
  Future<void> updateDocument(obj, id) async =>
      await firestore.collection(collection).doc(id).update(obj);

  // update
  Future<void> deleteDocument(id) async =>
      await firestore.collection(collection).doc(id).delete();

  // other Requests
  // Check If Document Exists
  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = firestore.collection(this.collection);
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkIfFieldExist(dynamic field) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = firestore
          .collection(this.collection)
          .where(field["key"], isEqualTo: field["value"]);

      // get only one document from Firestore
      var doc = await collectionRef.limit(1).get();

      return doc.docs.isEmpty;
    } catch (e) {
      throw e;
    }
  }
}
