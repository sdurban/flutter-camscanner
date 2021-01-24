import 'dart:io';

import 'package:cam_scanner/model/scanned_document.dart';
import 'package:cam_scanner/screens/doc_to_text_screen.dart';
import 'package:cam_scanner/widgets/alert_modal.dart';
import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class DocViewer extends StatelessWidget {
  final ScannedDocument _scannedDocument;

  const DocViewer(this._scannedDocument);

  @override
  Widget build(BuildContext context) {
    final file = File(_scannedDocument.documentUri);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Viewer'),
      ),
      body: PdfPreview(
        build: (_) => file.readAsBytesSync(),
        canChangePageFormat: false,
        actions: [
          PdfPreviewAction(
            icon: const Icon(Istos.file_1),
            onPressed: (BuildContext context, LayoutCallback build,
                PdfPageFormat pageFormat) {
              if (file.lengthSync() < 1000000) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DocToTextScreen(_scannedDocument.documentUri),
                  ),
                );
              } else {
                AlertModal.of(context).alert(
                  title: 'API Limit',
                  desc: 'Image is bigger than 1MB, please try with <1MB file',
                );
              }
            },
          )
        ],
      ),
    );
  }
}
