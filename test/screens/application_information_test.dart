import 'package:cam_scanner/screens/application_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper.dart';

void main() {
  testWidgets('ApplicationInformation builds without problem',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ApplicationInformation()));
  });
}
