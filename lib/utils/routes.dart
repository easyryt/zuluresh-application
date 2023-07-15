import 'package:flutter/material.dart';
import 'package:zuluresh/utils/route_name.dart';
import 'package:zuluresh/views/choose_location.dart';
import 'package:zuluresh/views/set_location.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.setLocationScreen:
        return MaterialPageRoute(builder: (context) => const SetLocation());
      case RouteName.chooseLocationScreen:
        return MaterialPageRoute(builder: (context) => const ChooseLocation());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Center(
            child: Text("jkl"),
          );
        });
    }
  }
}
