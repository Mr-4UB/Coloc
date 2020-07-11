import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colocs/views/offre/nvOffre.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  double _width;
  double _height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: _height / 9,
              floating: false,
              pinned: true,
              backgroundColor: Colors.blueAccent,
              //#f02730
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                titlePadding: EdgeInsets.only(top: 30.0),
                title: Center(
                  child: Text(
                    "Student-CoLoCo",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins-regular',
                        fontSize: 22),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                          child: Text(
                            'Ajouter une offre',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 120),
                        ClipOval(
                          child: Material(
                            color: Colors.blueAccent, // button color
                            child: InkWell(
                              splashColor: Colors.blueAccent, // inkwell color
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(Icons.add)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddOffre()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    StreamBuilder<QuerySnapshot>(
                      stream:
                          Firestore.instance.collection("offres").snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return new Text('${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Center(
                                child: new CircularProgressIndicator());
                          default:
                            return Card(
                              child: Column(
                                children: <Widget>[
                                  ListView(
                                    shrinkWrap: true,
                                    children: snapshot.data.documents.map(
                                      (DocumentSnapshot document) {
                                        return itemCard(document['prix'],
                                            document['image'], false);
                                      },
                                    ).toList(),
                                  ),
                                ],
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget itemCard(String title, String imgPath, bool isFavorite) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
            child: Container(
              height: 120.0,
              width: double.infinity,
              //color: Colors.white,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imgPath,
                      fit: BoxFit.cover,
                      width: 150,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 17.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            width: 175.0,
                            child: Text(
                              '22/06/2020 12:00',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.grey,
                                  fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.orange[100],
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange[100],
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange[100],
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange[100],
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange[100],
                            size: 15,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 70.0,
                            child: Center(
                              child: Text(
                                '3000 DH',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 35.0),
                          Container(
                            child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {},
                              textColor: Colors.white,
                              child: Text(
                                'Appelez',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
