import 'package:cam_scanner/screens/application_information.dart';
import 'package:cam_scanner/screens/doc_scan_screen.dart';

import 'screens/dashboard_screen.dart';

final routes = {
  '/dashboard': (_) => DashboardScreen(),
  '/doc-scan': (_) => DocScanScreen(),
  '/info': (_) => ApplicationInformation(),
};