import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colocs/models/offre.dart';
import 'package:colocs/models/utilisateur.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class OurDatabase {
  final Firestore _firestore = Firestore.instance;

  Future<String> createUser(User user) async {
    String retVal = "error";
    try {
      await _firestore.collection("users").document(user.uid).setData({
        'fullName': user.fullName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> createOffre(Offre offre, BuildContext cntx, String uid) async {
    String retVal = "error";
    try {
      String filename = offre.image.path.split('/').last;
      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(offre.image);

      StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

      var downloadUrl = await storageSnapshot.ref.getDownloadURL();

      await _firestore.collection("offres").document(offre.oid).setData({
        'uid': uid,
        'adresseX': offre.adresseX,
        'adresseY': offre.adresseY,
        'prix': offre.prix,
        'capacite': offre.capacite,
        'superficie': offre.superficie,
        'supplimentaires': offre.supplimentaires,
        'image': downloadUrl,
        'dateCreation': Timestamp.now(),
      });

      if (uploadTask.isComplete) {
        var url = downloadUrl.toString();
        print("opération effectué avec succes !");
        Scaffold.of(cntx).showSnackBar(
            SnackBar(content: Text('opération effectué avec succes !')));
      }

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
