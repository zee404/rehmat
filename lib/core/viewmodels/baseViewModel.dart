import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rehmat/core/enums/viewstate.dart';
import 'package:rehmat/core/services/auth.dart';
import 'package:rehmat/core/services/navigationService.dart';
import 'package:rehmat/locator.dart';
import 'package:rehmat/core/constants/route_paths.dart' as routes;

class BaseViewModel extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool iscompleted = false;
  ViewState _state = ViewState.Idle;
  final NavigationService _navigationService = locator<NavigationService>();

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setSignedIn(bool value) {
    iscompleted = value;
    notifyListeners();
  }

  bool isSignedIn() {
    return iscompleted;
  }

  User get getUser {
    User baseUser;
    baseUser = FirebaseAuth.instance.currentUser;
    // print('current user in baseview model ' + baseUser.toString());
    return baseUser;
  }

  void signOut() async {
    print('insids Signout in base view model ****************************');
    setState(ViewState.Busy);
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
      AuthService().signOut();
    } else {
      AuthService().signOut();
    }
    setState(ViewState.Idle);

    _navigationService.navigateTo(routes.LoginRoute);
  }
}
