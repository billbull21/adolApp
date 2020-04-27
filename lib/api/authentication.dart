import 'package:adolapp/helpers/validator.dart';
import 'package:adolapp/models/custom_error_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<DocumentSnapshot> signIn(String email, String password);

  Future<void> signUp(String username, String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<DocumentSnapshot> signIn(String email, String password) async {
    final result = await _firebaseAuth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((currentUser) => Firestore.instance
                .collection("users")
                .document(currentUser.user.uid)
                .get()
                .then((onValue) => currentUser.user.isEmailVerified ? onValue : throw(CustomErrorModels(message: "Unauthorized", code: "401")))
                .catchError((onError) {
              firebaseAuthErrorHandling(onError);
              throw (onError);
            }))
        .catchError((onError) {
      firebaseAuthErrorHandling(onError);
      throw (onError);
    });
    return result;
  }

  Future<void> signUp(String username, String email, String password) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((authResult) {
      Firestore.instance
          .collection("users")
          .document(authResult.user.uid)
          .setData(
            {
              "uid": authResult.user.uid,
              "username": username,
              "email": email,
            },
          )
          .then((onValue) => onValue)
          .catchError((err) => firebaseAuthErrorHandling(err));
    }).catchError((err) => firebaseAuthErrorHandling(err));
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
