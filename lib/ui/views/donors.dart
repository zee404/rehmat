import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rehmat/core/models/userDetails.dart';
import 'package:rehmat/ui/utils/customWaveIndicator.dart';

//

class DonorsPage extends StatefulWidget {
  @override
  _DonorsPageState createState() => _DonorsPageState();
}

class _DonorsPageState extends State<DonorsPage> {
  List<String> donors = [];
  List<String> bloodgroup = [];
  Widget _child;

  @override
  void initState() {
    _child = WaveIndicator();

    // getDonors();
    super.initState();
  }

  Future<Null> getDonors() async {
    await FirebaseFirestore.instance
        .collection('User Details')
        .get()
        .then((document) {
      if (document.docs.isNotEmpty) {
        for (int i = 0; i < document.docs.length; ++i) {
          donors.add(document.docs[i].data()['name']);
          bloodgroup.add(document.docs[i].data()['bloodgroup']);
        }
      }
    });
    setState(() {
      _child = myWidget();
    });
  }

  Widget myWidget() {
    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 221, 46, 68),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Donors",
          style: TextStyle(
            fontSize: 50.0,
            fontFamily: "SouthernAire",
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.reply,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: donors.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(donors[index]),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.message),
                          onPressed: () {},
                          color: Color.fromARGB(1000, 221, 46, 68),
                        ),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    child: Text(
                      bloodgroup[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color.fromARGB(1000, 221, 46, 68),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () {},
                    color: Color.fromARGB(1000, 221, 46, 68),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _allUsers = Provider.of<List<UserDetails>>(context);
    if (_allUsers != null) {
      return Scaffold(
        backgroundColor: Color.fromARGB(1000, 221, 46, 68),
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Donors",
            style: TextStyle(
              fontSize: 50.0,
              fontFamily: "SouthernAire",
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.reply,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _allUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_allUsers[index].name),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () {},
                            color: Color.fromARGB(1000, 221, 46, 68),
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        _allUsers[index].bloodGroup,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color.fromARGB(1000, 221, 46, 68),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () {},
                      color: Color.fromARGB(1000, 221, 46, 68),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return WaveIndicator();
    }
  }
}
