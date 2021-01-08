import 'dart:typed_data';

abstract class PdfToTextService {
  Future<String> execute(Uint8List fileData);
}