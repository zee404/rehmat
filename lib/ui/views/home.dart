import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rehmat/core/models/userDetails.dart';
import 'package:rehmat/ui/utils/customWaveIndicator.dart';
import 'package:rehmat/ui/views/appDrawer.dart';
import 'package:rehmat/ui/views/donorMapView.dart';
import 'package:rehmat/ui/views/register.dart';

//pages import
import './auth.dart';
import './mapView.dart';
import 'campaigns.dart';
import 'donors.dart';
//utils import

class HomePage extends StatefulWidget {
  bool isDonorView;
  HomePage({
    this.isDonorView = true,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // _child = WaveIndicator();
    // _loadCurrentUser();
    // _fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDonorView = false;
    final _currentUser = Provider.of<UserDetails>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      systemNavigationBarColor: Colors.black, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    if (_currentUser != null) {
      return Scaffold(
        backgroundColor: Color.fromARGB(1000, 221, 46, 68),
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: InkWell(
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 60.0,
                fontFamily: "SouthernAire",
                color: Colors.white,
              ),
            ),
            onTap: () {
              setState(() {
                isDonorView = !isDonorView;
              });
              print(
                  '------------------------donor view in on tap in home view ' +
                      isDonorView.toString());
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  isDonorView = true;
                });
              },
              child: Icon(Icons.block_outlined),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: ClipRRect(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0)),
          child: Container(
            height: 800.0,
            width: double.infinity,
            color: Colors.white,
            child: isDonorView == true ? DonorMapView() : MapView(),
          ),
        ),
      );
    } else {
      return RegisterPage();
    }
  }

  // Widget _myWidget() {
  //   return Scaffold(
  //     backgroundColor: Color.fromARGB(1000, 221, 46, 68),
  //     appBar: AppBar(
  //       elevation: 0.0,
  //       centerTitle: true,
  //       backgroundColor: Colors.transparent,
  //       title: Text(
  //         "Home",
  //         style: TextStyle(
  //           fontSize: 60.0,
  //           fontFamily: "SouthernAire",
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //     drawer: Drawer(
  //       child: ListView(
  //         padding: const EdgeInsets.all(0.0),
  //         children: <Widget>[
  //           UserAccountsDrawerHeader(
  //             decoration: BoxDecoration(
  //               color: Color.fromARGB(1000, 221, 46, 68),
  //             ),
  //             accountName: Text(
  //               currentUser == null ? "" : _name,
  //               style: TextStyle(
  //                 fontSize: 22.0,
  //               ),
  //             ),
  //             accountEmail: Text(currentUser == null ? "" : _email),
  //             currentAccountPicture: CircleAvatar(
  //               backgroundColor: Colors.white,
  //               child: Text(
  //                 currentUser == null ? "" : _bloodgrp,
  //                 style: TextStyle(
  //                   fontSize: 30.0,
  //                   color: Colors.black54,
  //                   fontFamily: 'SouthernAire',
  //                 ),
  //               ),
  //             ),
  //           ),
  //           ListTile(
  //             title: Text("Home"),
  //             leading: Icon(
  //               FontAwesomeIcons.home,
  //               color: Color.fromARGB(1000, 221, 46, 68),
  //             ),
  //             onTap: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => HomePage()));
  //             },
  //           ),
  //           ListTile(
  //             title: Text("Blood Donors"),
  //             leading: Icon(
  //               FontAwesomeIcons.handshake,
  //               color: Color.fromARGB(1000, 221, 46, 68),
  //             ),
  //             onTap: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => DonorsPage()));
  //             },
  //           ),
  //           ListTile(
  //             title: Text("Blood Requests"),
  //             leading: Icon(
  //               FontAwesomeIcons.burn,
  //               color: Color.fromARGB(1000, 221, 46, 68),
  //             ),
  //             onTap: () {
  //               //
  //             },
  //           ),
  //           ListTile(
  //             title: Text("Campaigns"),
  //             leading: Icon(
  //               FontAwesomeIcons.ribbon,
  //               color: Color.fromARGB(1000, 221, 46, 68),
  //             ),
  //             onTap: () {
  //               // Navigator.push(context,
  //               //     MaterialPageRoute(builder: (context) => CampaignsPage()));
  //             },
  //           ),
  //           ListTile(
  //             title: Text("Logout"),
  //             leading: Icon(
  //               FontAwesomeIcons.signOutAlt,
  //               color: Color.fromARGB(1000, 221, 46, 68),
  //             ),
  //             onTap: () async {
  //               await FirebaseAuth.instance.signOut();
  //               Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => AuthPage(FirebaseAuth.instance)));
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //     body: ClipRRect(
  //       borderRadius: new BorderRadius.only(
  //           topLeft: const Radius.circular(40.0),
  //           topRight: const Radius.circular(40.0)),
  //       child: Container(
  //         height: 800.0,
  //         width: double.infinity,
  //         color: Colors.white,
  //         child: MapView(),
  //       ),
  //     ),
  //   );
  // }

}
