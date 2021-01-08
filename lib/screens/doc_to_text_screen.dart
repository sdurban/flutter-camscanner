import 'dart:io';

import 'package:cam_scanner/service/pdf_to_text_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DocToTextScreen extends StatelessWidget {
  final PdfToTextService _pdfToTextService = GetIt.I.get<PdfToTextService>();
  final String _pathFile;

  DocToTextScreen(this._pathFile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document to text"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<String>(
          future: _pdfToTextService.execute(File(_pathFile).readAsBytesSync()),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something goes wrong"),
              );
            }

            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Text(snapshot.data),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
