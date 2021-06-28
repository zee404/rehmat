import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    print("---------> Navigation Service reached and navigating to  : " +
        routeName.toString());
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateToWithoutReplacement(String routeName) {
    print("---------> Navigation Service reached and navigating to  : " +
        routeName.toString());
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithPopandPushName(String routeName) {
    print("---------> Navigation Service reached and navigating to  : " +
        routeName.toString());
    return navigatorKey.currentState.popAndPushNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
