import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rehmat/core/viewmodels/registerViewModel.dart';
import 'package:rehmat/ui/baseView.dart';
//

import './home.dart';

class RegisterPage extends StatefulWidget {
  // final FirebaseAuth appAuth;
  // RegisterPage(this.appAuth);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  List<String> _bloodGroup = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String _selected = '';
  bool _categorySelected = false;
  Position position;

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    print(Position);
    print('-------------------------inside get current position in map view ' +
        res.toString());
    setState(() {
      position = res;
      // _child = mapWidget();
    });

    print(position.latitude);
    print(position.longitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      systemNavigationBarColor: Colors.black, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return BaseView<RegisterViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(1000, 221, 46, 68),
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "Register",
              style: TextStyle(
                fontSize: 60.0,
                fontFamily: "SouthernAire",
                color: Colors.white,
              ),
            ),
          ),
          body: ClipRRect(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0)),
            child: Container(
              height: 800.0,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Form(
                      key: formkey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Name',
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Color.fromARGB(1000, 221, 46, 68),
                                ),
                              ),
                              validator: (value) => value.isEmpty
                                  ? "Name field can't be empty"
                                  : null,
                              onSaved: (value) => _name = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Email ID',
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Color.fromARGB(1000, 221, 46, 68),
                                ),
                              ),
                              validator: (value) => value.isEmpty
                                  ? "Email ID field can't be empty"
                                  : null,
                              onSaved: (value) => _email = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                icon: Icon(
                                  FontAwesomeIcons.userLock,
                                  color: Color.fromARGB(1000, 221, 46, 68),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) => value.isEmpty
                                  ? "Password field can't be empty"
                                  : null,
                              onSaved: (value) => _password = value,
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: DropdownButton(
                                    hint: Text(
                                      'Please choose a Blood Group',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(1000, 221, 46, 68),
                                      ),
                                    ),
                                    iconSize: 40.0,
                                    items: _bloodGroup.map((val) {
                                      return new DropdownMenuItem<String>(
                                        value: val,
                                        child: new Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selected = newValue;
                                        this._categorySelected = true;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  _selected,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Color.fromARGB(1000, 221, 46, 68),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (formkey.currentState.validate()) {
                                formkey.currentState.save();
                                print('------------------email is ' +
                                    position.toString());

                                bool result =
                                    await model.registerWithEmailAndPassword(
                                        _name,
                                        _password,
                                        _selected,
                                        _email,
                                        new GeoPoint(position.latitude,
                                            position.longitude));
                                if (result) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                } else {}
                              }

                              // validate_submit(context);
                            },
                            textColor: Colors.white,
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            color: Color.fromARGB(1000, 221, 46, 68),
                            child: Text("REGISTER"),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
