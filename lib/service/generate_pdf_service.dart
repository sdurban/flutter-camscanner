import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cam_scanner/service/scanned_document_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as Im;


@lazySingleton
class GeneratePdfService {
  final ScannedDocumentRepository _scannedDocumentRepository;

  const GeneratePdfService(this._scannedDocumentRepository);

  Future<void> generatePdfFromImages(List<String> imagePaths) async {
    final pdf = pw.Document();

    for (var element in imagePaths) {
      Im.Image image = Im.decodeImage(await File(element).readAsBytes());
      Uint8List imageFileBytes = Im.encodeJpg(image, quality: 60);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                  PdfImage.file(pdf.document, bytes: imageFileBytes)
              ),
            );
          },
        ),
      );
    }


    await _scannedDocumentRepository.saveScannedDocument(
      firstPageUri: imagePaths.first,
      document: pdf.save(),
    );
  }
}
