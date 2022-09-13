import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_trivy/models/user_model.dart';

enum AuthState { authenticating, authenticated, error, logout }

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fstore = FirebaseFirestore.instance;

  User? user;
  late UserModel userModel;
  String? errorMsg;

  AuthCubit() : super(AuthState.authenticating) {
    user = _auth.currentUser;
    if (user == null) {
      emit(AuthState.logout);
    } else {
      emit(AuthState.authenticating);
      _fstore.collection('users').doc(user!.uid).get().then((value) {
        userModel = userModelFromJSON(value.data()!);
        emit(AuthState.authenticated);
      }).onError((error, stackTrace) {
        errorMsg = error.toString();
        emit(AuthState.error);
      });
    }
  }
  void signUpWithEmail(String name, String email, String password) async {
    emit(AuthState.authenticating);
    user = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userModel = UserModel(uid: value.user!.uid, name: name, email: email);
      _fstore
          .collection('users')
          .doc(value.user!.uid)
          .set(userModel.userModelToJSON())
          .then((value) {
        emit(AuthState.authenticated);
      }).onError((error, stackTrace) {
        errorMsg = error.toString();
        emit(AuthState.error);
      });
      return value.user;
    }).onError((error, stackTrace) {
      errorMsg = error.toString();
      emit(AuthState.error);
      return null;
    });
  }

  void signInWithEmail(String email, String password) async {
    emit(AuthState.authenticating);
    try {
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        return _fstore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          userModel = userModelFromJSON(value.data()!);

          emit(AuthState.authenticated);
          return userCredential.user;
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMsg = 'No user found for that email.';
        emit(AuthState.error);
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Wrong password provided for that user.';
        emit(AuthState.error);
      }
    }
  }

  void logout() async {
    return await _auth.signOut().then((value) {
      emit(AuthState.logout);
    }).onError((error, stackTrace) {
      errorMsg = error.toString();
      emit(AuthState.error);
    });
  }
}
