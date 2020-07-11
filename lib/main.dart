import 'dart:async';

import 'package:colocs/views/lsdemandescreen.dart';
import 'package:colocs/views/root/root.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'views/demandescreen.dart';
import 'models/demande.dart';
//import 'models/demande.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Coloc',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: OurRoot(),
    );
  }
}
