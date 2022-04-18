import 'package:flutter/widgets.dart';
import 'package:client/components/nav.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Navigation.routeName: (context) => Navigation(),
};
