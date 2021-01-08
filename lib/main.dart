import 'package:cam_scanner/di_setup.dart';
import 'package:flutter/material.dart';

import 'application.dart';

void main() {
  /// Start dependency injection before starting the application
  /// with this dependency injection I can separate logic from UI
  /// making the code more testable and easy to read.
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(Application());
}