import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Récupérer tous les documents d'une collection
  Stream<QuerySnapshot> getCollection(String collectionPath) {
    return _db.collection(collectionPath).snapshots();
  }

  // Récupérer un document unique
  Future<DocumentSnapshot> getDocument(String collectionPath, String documentId) {
    return _db.collection(collectionPath).doc(documentId).get();
  }

  // Récupérer les leçons pour une langue spécifique
  Stream<QuerySnapshot> getLessonsForLanguage(String languageId) {
    return _db
        .collection('lessons')
        .where('languageId', isEqualTo: languageId)
        .orderBy('level')
        .snapshots();
  }
  
  // Ajouter un document à une collection (utile pour les contributions)
  Future<DocumentReference> addDocument(String collectionPath, Map<String, dynamic> data) async {
    return await _db.collection(collectionPath).add(data);
  }
}
