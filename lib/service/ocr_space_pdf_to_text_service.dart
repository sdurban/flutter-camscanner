import 'dart:convert';
import 'dart:typed_data';

import 'package:cam_scanner/service/pdf_to_text_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: PdfToTextService)
class OcrSpacePdfToTextService implements PdfToTextService {
  static const String _apiKey = '<INSERT_API_KEY>';
  final _uri = Uri.parse('https://api.ocr.space/parse/image');

  @override
  Future<String> execute(Uint8List fileData) async {
    final response = await http.post(_uri, headers: {
      'content-type': 'application/x-www-form-urlencoded'
    }, body: {
      'apikey': _apiKey,
      'base64Image': 'data:application/pdf;base64,${base64Encode(fileData)}'
    });

    final Map<String, dynamic> text = jsonDecode(response.body);

    if (text['ParsedResults'] == null ||
        text['ParsedResults'][0] == null ||
        text['ParsedResults'][0]['ParsedText'] == null) {
      return 'Something woes wrong with API implementation';
    }

    return text['ParsedResults'][0]['ParsedText'];
  }
}
