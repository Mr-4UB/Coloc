import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String email;
  String fullName;
  String phoneNumber;
  Timestamp accountCreated;

  User({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.accountCreated,
  });
}
