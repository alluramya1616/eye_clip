import 'package:flutter/material.dart';
import '../pages/landing_page.dart';
import '../pages/detection_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => LandingPage(),
  '/detection': (context) => DetectionPage(),
};
