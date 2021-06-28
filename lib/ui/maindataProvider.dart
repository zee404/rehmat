import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehmat/core/models/bloodrequest.dart';
import 'package:rehmat/core/models/userDetails.dart';
import 'package:rehmat/core/services/database.dart';
import 'package:rehmat/core/viewmodels/baseViewModel.dart';
import 'package:rehmat/ui/baseView.dart';
import 'package:rehmat/ui/views/home.dart';

class MainDataProvider extends StatefulWidget {
  bool isDonorView;
  MainDataProvider({
    this.isDonorView = true,
  });
  @override
  _MainDataProviderState createState() => _MainDataProviderState();
}

class _MainDataProviderState extends State<MainDataProvider> {
  @override
  Widget build(BuildContext context) {
    User _user = BaseViewModel().getUser;

    StreamProvider userDataProvider;
    StreamProvider allUserProvider;
    StreamProvider allRequesProvider;
    try {
      userDataProvider = StreamProvider<UserDetails>.value(
          value: DataBaseService()
              .getCurrentUserDetails(_user != null ? _user.uid : null));
      allUserProvider = StreamProvider<List<UserDetails>>.value(
          value: DataBaseService().getAllUsers());
      allRequesProvider = StreamProvider<List<BloodRequest>>.value(
          value: DataBaseService().getAllRequest());
    } catch (error) {
      print('----------------------------error in mainm data provider');
    }
    return MultiProvider(
      providers: [
        userDataProvider,
        allUserProvider,
        allRequesProvider,
      ],
      child: BaseView<BaseViewModel>(
        onModelReady: (model) {},
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(
              isDonorView: widget.isDonorView,
            ),
          );
        },
      ),
    );
  }
}
