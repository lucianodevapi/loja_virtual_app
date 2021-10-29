import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_app/helpers/firebase_errors.dart';
import 'package:loja_virtual_app/models/user_app.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get isLoggedIn => userLogged.id!.isNotEmpty;

  late UserApp userLogged;

  UserManager() {
    _loadCurrentUser();
  }

  Future<void> signIn({
    required UserApp userApp,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: userApp.email!,
        password: userApp.password!,
      );
      //await Future.delayed(const Duration(seconds: 3));
      _loadCurrentUser(firebaseUser: userCredential.user);
      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(
        getErrorString(error.code),
      );
    }
    loading = false;
  }

  Future<void> signUp({
    required UserApp userApp,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      debugPrint('$userApp.email - $userApp.password');
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: userApp.email!, password: userApp.password!);
      userApp.id = userCredential.user!.uid;
      userLogged = userApp;
      await userApp.saveData();
      //_loadCurrentUser(user: userCredential.user);
      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(
        getErrorString(error.code),
      );
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    userLogged = UserApp(
      id: '',
      name: '',
      email: '',
      password: '',
      confirmPassword: '',
    );
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser!;
    if (currentUser.uid.isNotEmpty) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      userLogged = UserApp.fromDocument(docUser);
      //debugPrint(userLogged.name);
      notifyListeners();
    }
  }
}
