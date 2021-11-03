import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  String? id = '';
  String? name = '';
  String? email = '';
  String? password = '';
  String? confirmPassword = '';

  UserApp({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
  });

  UserApp.fromDocument(DocumentSnapshot<Object?> document) {
    id = document.id;
    name = document['name'] as String;
    email = document['email'] as String;
  }

  DocumentReference get firestoreReference =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference =>
      firestoreReference.collection('cart');

  Future<void> saveData() async {
    await firestoreReference.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
