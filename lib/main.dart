import 'package:flutter/material.dart';
import 'utils/routes.dart';

void main() => runApp(GlaucomaApp());

class GlaucomaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glaucoma Detection',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
