import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart' show Mock;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

Widget buildTestableWidget(
  Widget widget, {
  List<NavigatorObserver> navigatorObserver,
      Map<String, WidgetBuilder> routes,
}) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
      home: widget,
      navigatorObservers: navigatorObserver ?? [],
      routes: routes ?? {},
    ),
  );
}
