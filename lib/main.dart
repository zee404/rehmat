import 'package:flutter/material.dart';
import 'package:rehmat/locator.dart';
import 'package:rehmat/ui/maindataProvider.dart';
import 'package:rehmat/ui/views/splash.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp myApp = await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeShare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "GoogleSans",
        primarySwatch: Colors.red,
      ),
      home: MainDataProvider(),
    );
  }
}
