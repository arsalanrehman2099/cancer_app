import 'package:cancer_spy/models/user.dart';
import 'package:cancer_spy/screens/auth/login_screen.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class UserHelper {
  static const COLLECTION_NAME = 'Users';

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String myId() => _auth.currentUser!.uid.toString();

  bool isLoggedIn() {
    if (_auth.currentUser == null)
      return false;
    else
      return true;
  }

  userSignup(User? user) async {
    var response = {};
    await _auth
        .createUserWithEmailAndPassword(
            email: user!.email!, password: user.password!)
        .then((value) {
      response['error'] = 0;
      user.id = _auth.currentUser?.uid.toString();

      _firestore.collection(COLLECTION_NAME).doc(user.id).set(user.toJson());
    }).catchError(
      (err) {
        response['error'] = 1;
        response['message'] = err.toString();
      },
    );

    return response;
  }

  userLogin(User? user) async {
    var response = {};
    await _auth
        .signInWithEmailAndPassword(
            email: user!.email!, password: user.password!)
        .then((value) {
      response['error'] = 0;
    }).catchError((err) {
      response['error'] = 1;
      response['message'] = err.toString();
    });
    return response;
  }

  userLogout(context) {
    _auth.signOut();
    ConstantManager.screenNavWithClear(
      context,
      LoginScreen(),
    );
  }

  getUserData() async {
    var response = {};
    await _firestore
        .collection(COLLECTION_NAME)
        .doc(myId())
        .get()
        .then((value) {
      response['error'] = 0;
      response['data'] = User().fromJson(value.data()!);
    }).catchError((err) {
      response['error'] = 1;
      response['message'] = err.toString();
    });
    print(response);
    return response;
  }
}
