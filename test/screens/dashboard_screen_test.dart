import 'dart:io';

import 'package:cam_scanner/model/scanned_document.dart';
import 'package:cam_scanner/screens/dashboard_screen.dart';
import 'package:cam_scanner/screens/doc_viewer_screen.dart';
import 'package:cam_scanner/service/scanned_document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';

import '../helper.dart';

class ScannedDocumentRepositoryMock extends Mock
    implements ScannedDocumentRepository {}

void main() {
  setUp(() {
    GetIt.I.reset(dispose: true);
  });

  testWidgets('Empty DashboardPage show loading animation',
      (WidgetTester tester) async {
    //Not working
    final _scannerFactory = ScannedDocumentRepositoryMock();

    GetIt.I.registerSingleton<ScannedDocumentRepository>(_scannerFactory);

    when(_scannerFactory.getAll()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(buildTestableWidget(DashboardScreen()));

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  });

  testWidgets('Empty DashboardPage shows empty message',
      (WidgetTester tester) async {
    final _scannerFactory = ScannedDocumentRepositoryMock();

    GetIt.I.registerSingleton<ScannedDocumentRepository>(_scannerFactory);

    when(_scannerFactory.getAll()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(buildTestableWidget(DashboardScreen()));

    await tester.pump();

    expect(
      find.text('To scan your first document, click the floating button.'),
      findsOneWidget,
    );
  });

  testWidgets('Empty DashboardPage throws error message',
      (WidgetTester tester) async {
    final _scannerFactory = ScannedDocumentRepositoryMock();

    GetIt.I.registerSingleton<ScannedDocumentRepository>(_scannerFactory);

    when(_scannerFactory.getAll()).thenAnswer((_) => Future.error(Error()));

    await tester.pumpWidget(buildTestableWidget(DashboardScreen()));

    await tester.pump();

    expect(
      find.text('Something goes wrong'),
      findsOneWidget,
    );
  });

  testWidgets('Information navigation button works',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final _scannerFactory = ScannedDocumentRepositoryMock();

    GetIt.I.registerSingleton<ScannedDocumentRepository>(_scannerFactory);

    when(_scannerFactory.getAll()).thenAnswer((_) => Future.error(Error()));

    await tester.pumpWidget(
      buildTestableWidget(
        DashboardScreen(),
        routes: {
          '/info': (_) => const Text('/info'),
        },
        navigatorObserver: [mockObserver],
      ),
    );

    expect(find.byType(GestureDetector), findsWidgets);
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();

    verify(mockObserver.didPush(any, any));
    expect(find.text('/info'), findsOneWidget);
  });

  testWidgets('Floating button works', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final _scannerFactory = ScannedDocumentRepositoryMock();

    GetIt.I.registerSingleton<ScannedDocumentRepository>(_scannerFactory);

    when(_scannerFactory.getAll()).thenAnswer((_) => Future.error(Error()));

    await tester.pumpWidget(
      buildTestableWidget(
        DashboardScreen(),
        routes: {
          '/doc-scan': (_) => const Text('/doc-scan'),
        },
        navigatorObserver: [mockObserver],
      ),
    );

    expect(find.byType(FloatingActionButton), findsWidgets);
    await tester.tap(find.byType(FloatingActionButton).first);
    await tester.pumpAndSettle();

    verify(mockObserver.didPush(any, any));
    expect(find.text('/doc-scan'), findsOneWidget);
  });

  testWidgets('Dashboard with items navigates next page',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    final _scannerFactory = ScannedDocumentRepositoryMock();

    GetIt.I.registerSingleton<ScannedDocumentRepository>(_scannerFactory);

    final path = '${dirname(Platform.script.toString())}/../sample_files';

    when(_scannerFactory.getAll()).thenAnswer((_) => Future.value([
          ScannedDocument(
              'Sample 1', '$path/sample_1.jpg', '$path/sample_1.pdf'),
          ScannedDocument(
              'Sample 2', '$path/sample_2.jpg', '$path/sample_2.pdf'),
        ]));

    await tester.pumpWidget(
      buildTestableWidget(
        DashboardScreen(),
        navigatorObserver: [mockObserver],
      ),
    );

    await tester.pump();

    expect(
      find.text('Something goes wrong'),
      findsNothing,
    );

    final gridViewGestures = find.descendant(
      of: find.byType(GridView),
      matching: find.byType(GestureDetector),
    );

    expect(gridViewGestures, findsNWidgets(2));

    expect(
      find.descendant(
          of: gridViewGestures.first, matching: find.text('Sample 1')),
      findsOneWidget,
    );

    await tester.tap(gridViewGestures.first);
    await tester.pumpAndSettle();

    expect(
      find.descendant(
          of: find.byType(MaterialApp), matching: find.byType(DocViewer)),
      findsOneWidget,
    );

    verify(mockObserver.didPush(any, any));
  });
}
