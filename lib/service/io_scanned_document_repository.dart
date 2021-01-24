import 'dart:io';
import 'dart:typed_data';

import 'package:cam_scanner/model/scanned_document.dart';
import 'package:cam_scanner/service/scanned_document_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

@LazySingleton(as: ScannedDocumentRepository)
class IoScannedDocumentRepository implements ScannedDocumentRepository {
  static String _filePath;

  Future<String> get _directory async {
    if (_filePath == null) {
      final String directory =
      // ignore: lines_longer_than_80_chars
      '${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}scanned_documents';

      final savedDir = Directory(directory);
      final bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        await savedDir.create();
      }
      _filePath = directory + Platform.pathSeparator;
    }

    return _filePath;
  }

  @override
  Future<List<ScannedDocument>> getAll() async {
    final List<ScannedDocument> _scannedDocuments = [];
    final directory = Directory(await _directory);

    final List<FileSystemEntity> itemList = directory.listSync();

    for (final item in itemList) {
      if (p.extension(item.path) == '.pdf') {
        final fileName = p.basenameWithoutExtension(item.path);

        _scannedDocuments.add(
          ScannedDocument(
            fileName,
            '${await _directory}$fileName.png',
            '${await _directory}$fileName.pdf',
          ),
        );
      }
    }

    return _scannedDocuments;
  }

  @override
  Future<void> saveScannedDocument({
    @required String firstPageUri,
    @required Uint8List document,
  }) async {
    final File firstPage = File(firstPageUri);
    final String fileName = Uuid().v1();

    await firstPage.copy('${await _directory}$fileName.png');

    final File pdfFile = File('${await _directory}$fileName.pdf');

    await pdfFile.writeAsBytes(document);
  }
}
