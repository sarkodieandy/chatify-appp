import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NavigationServices {
  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  void removeAndNavigateToRoute(String route) {
    navigatorKey.currentState?.popAndPushNamed(route);
  }

  void NavigateToRoute(String route) {
    navigatorKey.currentState?.pushNamed(route);
  }

  void NavigateToPage(Widget page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }

  void goBack() {
    navigatorKey.currentState?.pop();
    GetIt.instance.registerSingleton<NavigationServices>(
      NavigationServices(),
    );
  }

  getCurrentRoute() {}

  // function that will allow us to go back to our pages
}
