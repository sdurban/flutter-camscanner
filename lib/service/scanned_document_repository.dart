import 'dart:typed_data';

import 'package:cam_scanner/model/scanned_document.dart';
import 'package:flutter/widgets.dart';

abstract class ScannedDocumentRepository {
  Future<List<ScannedDocument>> getAll();
  Future<void> saveScannedDocument({
    @required String firstPageUri,
    @required Uint8List document,
  });
}
