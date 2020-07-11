import 'package:colocs/models/utilisateur.dart';
import 'package:colocs/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier {
  User _currentUser = User();

  User get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";
    try {
      FirebaseUser _firebaseUser = await _auth.currentUser();
      _currentUser.uid = _firebaseUser.uid;
      _currentUser.email = _firebaseUser.email;
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";
    try {
      await _auth.signOut();
      _currentUser = User();

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String email, String password, String fullname,
      String phoneNumber) async {
    String retVal = "error";
    User _user = User();
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.fullName = fullname;
      _user.phoneNumber = phoneNumber;
      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }

  Future<String> loginUser(String email, String password) async {
    String retVal = "error";
    try {
      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _currentUser.uid = _authResult.user.uid;
      _currentUser.email = _authResult.user.email;
      retVal = "success";
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }
}
