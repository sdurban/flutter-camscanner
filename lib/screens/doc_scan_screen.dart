import 'dart:io';

import 'package:cam_scanner/widgets/loading_overlay.dart';
import 'package:cam_scanner/service/generate_pdf_service.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class DocScanScreen extends StatefulWidget {
  @override
  _DocScanScreenState createState() => _DocScanScreenState();
}

class _DocScanScreenState extends State<DocScanScreen> {
  final List<String> _documents = [];

  @override
  void dispose() {
    super.dispose();
    for (final document in _documents) {
      File(document).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanning document'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            if (index < _documents.length) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.file(
                    File(_documents[index]),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      File(_documents[index])..delete();
                      _documents.removeAt(index);
                      setState(() {});
                    },
                    elevation: 0.0,
                    fillColor: const Color(0x50000000),
                    child: const Icon(
                      Istos.trash,
                      size: 35.0,
                    ),
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                  ),
                ],
              );
            } else {
              return InkWell(
                onTap: () {
                  EdgeDetection.detectEdge.then((value) {
                    if (value != null) {
                      _documents.add(value);
                      setState(() {});
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 50,
                  ),
                  decoration: BoxDecoration(
                    border: RDottedLineBorder.all(
                      width: 1,
                      dottedLength: 6,
                      dottedSpace: 10,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Istos.plus_a,
                          size: 35,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Add new image',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          itemCount: _documents.length + 1,
          pagination: const SwiperPagination(),
          control: const SwiperControl(),
          viewportFraction: 0.8,
          itemHeight: 20,
          scale: 0.9,
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 4,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    final generatePdfService =
                        GetIt.I.get<GeneratePdfService>();

                    LoadingOverlay.of(context)
                        .during(
                      generatePdfService.generatePdfFromImages(_documents),
                    )
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('CONTINUE'),
                  color: Theme.of(context).bottomAppBarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
