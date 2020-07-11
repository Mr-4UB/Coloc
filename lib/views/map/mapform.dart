import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colocs/models/offre.dart';
import 'package:colocs/views/offre/nvOffre.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Coloc',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  double clickedLat = 0;
  double clickedLong = 0;

  List<Marker> allMarkers = [];

  var offres = new List<Offre>();

  @override
  void initState() {
    Firestore.instance
        .collection('offres')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((result) {
        offres.add(new Offre(
            oid: result.data['oid'],
            adresseX: result.data['adresseX'],
            adresseY: result.data['adresseY'],
            capacite: result.data['capacite'],
            superficie: result.data['superficie'],
            prix: result.data['prix']));
        print("prix" + result.data['prix']);
      });
    });
    print('${offres}');
    offres.forEach((Offre off) {
      allMarkers.add(Marker(
          markerId: MarkerId('${off.oid}'),
          position:
              LatLng(double.parse(off.adresseX), double.parse(off.adresseY)),
          infoWindow: InfoWindow(title: '${off.prix}MAD'),
          // ignore: deprecated_member_use
          icon: BitmapDescriptor.fromAsset("images/logo.png")));
    });
    if (allMarkers.isEmpty) {}

    // TODO: implement initState
    super.initState();
    print('test');
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
      ),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _builderfunction(),
        ],
      ),
    );
  }

  Widget _builderfunction() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: offres
              .map(
                (Offre offre) => _boxes(
                    "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",
                    offre.adresseX,
                    offre.adresseY,
                    offre.prix,
                    offre.superficie,
                    offre.capacite,
                    offre.tele),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _boxes(String _image, String addressx, String addressy, String prix,
      String superf, String cap, String tele) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(double.parse(addressx), double.parse(addressy));
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(prix, superf, cap, tele),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(prix, superf, cap, tele) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Prix ${prix.toString()} MAD",
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "Superficie : ${superf} m2",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 19.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Capacité : ${cap} personnes",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 19.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Téléphone:${tele}",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 19.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _googlemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        onTap: (LatLng) {
          clickedLat = LatLng.latitude;
          clickedLong = LatLng.longitude;
          var router = new MaterialPageRoute(
              builder: (BuildContext context) =>
                  AddOffre(x: clickedLat, y: clickedLong));
          Navigator.of(context).push(router);
        },
        initialCameraPosition:
            CameraPosition(target: LatLng(32.375510, -6.318743), zoom: 12.0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(allMarkers),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
