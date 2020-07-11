import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Offre {
  String oid;
  String uid;
  String adresseX;
  String adresseY;
  String capacite;
  String superficie;
  String prix;
  String tele;
  List supplimentaires;
  File image;
  Timestamp dateCreation;

  Offre(
      {this.oid,
      this.uid,
      this.adresseX,
      this.adresseY,
      this.tele,
      this.capacite,
      this.superficie,
      this.prix,
      this.supplimentaires,
      this.image,
      this.dateCreation});
}
