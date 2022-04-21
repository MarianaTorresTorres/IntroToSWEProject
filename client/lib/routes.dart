import 'package:flutter/widgets.dart';
import 'package:client/nav.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Navigation.routeName: (context) => const Navigation(userData: null),
};
