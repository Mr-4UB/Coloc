import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/demande.dart';

final CollectionReference myCollection =
    Firestore.instance.collection('coloco1');

class FirestoreService {
  Future<Demande> createDemande(String demandebudget, String demandedetails,
      String demandedate, String demandetime, String demandetype) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());

      final Demande demande = new Demande(
          demandebudget, demandedetails, demandedate, demandetime, demandetype);
      final Map<String, dynamic> data = demande.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Demande.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getDemandeList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}
