import 'package:flutter/material.dart';

import 'routes.dart';

class Application extends StatelessWidget {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.brown,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightTheme,
      routes: routes,
      initialRoute: '/dashboard',
      themeMode: ThemeMode.light,
    );
  }
}
