//nouvelle demande.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/demande.dart';
import '../services/firestoreservice.dart';

class NvDemande extends StatefulWidget {
  NvDemande();
  @override
  _NvDemandeState createState() => _NvDemandeState();
}

class _NvDemandeState extends State<NvDemande> {
  String demandebudget, demandedetails, demandedate, demandetime;

  getdemandebudget(demandebudget) {
    this.demandebudget = demandebudget;
  }

  getdemandedetails(demandedetails) {
    this.demandedetails = demandedetails;
  }

  getdemandedate(demandedate) {
    this.demandedate = demandedate;
  }

  getdemandetime(demandetime) {
    this.demandetime = demandetime;
  }

  int _mydemandetype = 0;
  String demandeVal;
  void _handledemandetype(int value) {
    setState(() {
      _mydemandetype = value;
      switch (_mydemandetype) {
        case 1:
          demandeVal = 'appartement';
          break;
        case 2:
          demandeVal = 'maison';
          break;
        case 3:
          demandeVal = 'garsoniere';
          break;
        case 4:
          demandeVal = 'chambre';
          break;
        case 5:
          demandeVal = 'autres';
          break;
      }
    });
  }

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('coloco1').document('demandebudget');
    Map<String, dynamic> demandes = {
      "demandebudget": demandebudget,
      "demandedetails": demandedetails,
      "demandedate": demandedate,
      "demandetime": demandetime,
      "demandetype": demandeVal,
    };

    ds.setData(demandes).whenComplete(() {
      print("demande updated");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _demandebudgetController,
                    onChanged: (String budget) {
                      getdemandebudget(budget);
                    },
                    decoration: InputDecoration(labelText: "Budget: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    //controller: _demandedetailsController,
                    decoration: InputDecoration(labelText: "Details: "),
                    onChanged: (String demandedetails) {
                      getdemandedetails(demandedetails);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _demandedateController,
                    decoration: InputDecoration(labelText: "Date: "),
                    onChanged: (String demandedate) {
                      getdemandedate(demandedate);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _demandetimeController,
                    decoration: InputDecoration(labelText: "Time: "),
                    onChanged: (String demandetime) {
                      getdemandetime(demandetime);
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    'Select Demande Type:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _mydemandetype,
                          onChanged: _handledemandetype,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Appartement',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _mydemandetype,
                          onChanged: _handledemandetype,
                          activeColor: Color(0xfffb537f),
                        ),
                        Text(
                          'Maison',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _mydemandetype,
                          onChanged: _handledemandetype,
                          activeColor: Color(0xff4caf50),
                        ),
                        Text(
                          'Garsoniere',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _mydemandetype,
                          onChanged: _handledemandetype,
                          activeColor: Color(0xff9962d0),
                        ),
                        Text(
                          'Chambre',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 5,
                          groupValue: _mydemandetype,
                          onChanged: _handledemandetype,
                          activeColor: Color(0xff0dc8f5),
                        ),
                        Text(
                          'Autres',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        color: Color(0xFFFA7397),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Color(0xFFFDDE42)),
                        )),
                    // This button results in adding the contact to the database
                    RaisedButton(
                        color: Color(0xFFFA7397),
                        onPressed: () {
                          createData();
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Color(0xFFFDDE42)),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myAppBar() {
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
                      Navigator.pop(context);
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Nouvelle Demande',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
