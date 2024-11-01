import 'package:flutter/material.dart';

import '../screens/authentication/login.dart';
import '../screens/home/home_list.dart';

get onGenerateRoute {
  return (RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case LoginScreen.routeName:
            return const LoginScreen();
          case HomeList.routeName:
            return const HomeList();
          case "2":
            return Container();
          default:
            return const Center(
              child: Text("Ruta no encontrada"),
            );
        }
      },
    );
  };
}
