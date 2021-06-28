import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rehmat/core/models/userDetails.dart';
import 'package:rehmat/core/services/auth.dart';
import 'package:rehmat/core/services/database.dart';
import 'package:rehmat/core/services/navigationService.dart';
import 'package:rehmat/core/viewmodels/baseViewModel.dart';

import '../../locator.dart';

class RegisterViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<bool> registerWithEmailAndPassword(String name, String password,
      String bloodgroup, String email, GeoPoint location) async {
    print('--------------------------inside reg functioin inregview model');
    User user =
        await AuthService().handleSignUpwithEmailAndPassword(email, password);

    if (user != null) {
      DataBaseService().addNewUser(UserDetails(
              uid: user.uid,
              email: email,
              name: name,
              bloodGroup: bloodgroup,
              location: location)
          .toMap());
      print('-----------------------user added successfuly ');
      return true;
    }
    {
      print('----------------user not added ');
      return false;
    }
  }
}
