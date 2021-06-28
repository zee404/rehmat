import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rehmat/core/models/userDetails.dart';
import 'package:rehmat/core/viewmodels/baseViewModel.dart';
import 'package:rehmat/ui/baseView.dart';
import 'package:rehmat/ui/maindataProvider.dart';
import 'package:rehmat/ui/views/auth.dart';

import 'donors.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<UserDetails>(context);
    return BaseView<BaseViewModel>(
      builder: (context, model, child) => Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              accountName: Text(
                _currentUser.name,
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              accountEmail: Text(_currentUser.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _currentUser.bloodGroup,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black54,
                    fontFamily: 'SouthernAire',
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(
                FontAwesomeIcons.home,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainDataProvider(
                              isDonorView: true,
                            )));
              },
            ),
            ListTile(
              title: Text("Blood Donors"),
              leading: Icon(
                FontAwesomeIcons.handshake,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DonorsPage()));
              },
            ),
            ListTile(
              title: Text("Blood Requests"),
              leading: Icon(
                FontAwesomeIcons.burn,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainDataProvider(
                              isDonorView: false,
                            )));
              },
            ),
            ListTile(
              title: Text("Campaigns"),
              leading: Icon(
                FontAwesomeIcons.ribbon,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => CampaignsPage()));
              },
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () async {
                model.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthPage(FirebaseAuth.instance)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
