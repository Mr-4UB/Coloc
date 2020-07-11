import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../views/demandescreen.dart';
import '../models/demande.dart';

class Listdemandes extends StatefulWidget {
  @override
  _ListdemandesState createState() => new _ListdemandesState();
}

class _ListdemandesState extends State<Listdemandes> {
  List<Demande> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> Demandes;

  @override
  void initState() {
    super.initState();

    items = new List();

    Demandes?.cancel();
    Demandes = fireServ.getDemandeList().listen((QuerySnapshot snapshot) {
      final List<Demande> demandes = snapshot.documents
          .map((documentSnapshot) => Demande.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = demandes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(children: <Widget>[
                    // The containers in the background
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Material(
                              color: Colors.white,
                              elevation: 14.0,
                              shadowColor: Color(0x802196F3),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      DemandeType(
                                          '${items[index].demandetype}'),
                                      Text(
                                        '${items[index].demandebudget}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${items[index].demandedate}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${items[index].demandetime}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]);
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFA7397),
        child: Icon(
          FontAwesomeIcons.listUl,
          color: Color(0xFFFDDE42),
        ),
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) => DemandeScreen()),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DemandeScreen(Demande('', '', '', '', '')),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }

  Widget DemandeType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'appartement':
        iconval = FontAwesomeIcons.building;
        colorval = Color(0xff4158ba);
        break;
      case 'maison':
        iconval = FontAwesomeIcons.home;
        colorval = Color(0xfffb537f);
        break;
      case 'garsoniere':
        iconval = FontAwesomeIcons.home;
        colorval = Color(0xff4caf50);
        break;
      case 'chambre':
        iconval = FontAwesomeIcons.hotel;
        colorval = Color(0xff9962d0);
        break;
      default:
        iconval = FontAwesomeIcons.tasks;
        colorval = Color(0xff0dc8f5);
      //
    }
    return CircleAvatar(
      backgroundColor: colorval,
      child: Icon(iconval, color: Colors.white, size: 20.0),
    );
  }

  Widget _myAppBar(context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFFFA7397),
              const Color(0xFFFDDE42),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Les Demandes',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
