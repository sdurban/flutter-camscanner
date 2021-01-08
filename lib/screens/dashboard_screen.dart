import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:get_it/get_it.dart';

import '../model/scanned_document.dart';
import '../service/scanned_document_repository.dart';
import 'doc_viewer_screen.dart';

class DashboardScreen extends StatefulWidget {
  final ScannedDocumentRepository _scannedDocumentRepository =
      GetIt.I.get<ScannedDocumentRepository>();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ScannedDocument> _scannedDocuments = [];
  bool _loaded = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();

    _updateView();
  }

  void _updateView() {
    setState(() {
      _loaded = false;
    });

    widget._scannedDocumentRepository.getAll().then((value) {
      setState(() {
        _scannedDocuments = value;
        _loaded = true;
      });
    }).catchError((_) {
      setState(() {
        _loaded = false;
        _error = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter CamScanner'),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed("/info"),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Istos.info),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (!_loaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_error) {
            return const Center(
              child: Text("Something goes wrong"),
            );
          }

          if (_scannedDocuments.length == 0) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  "To scan your first document, click the floating button.",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            );
          }

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: List.generate(_scannedDocuments.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DocViewer(_scannedDocuments[index]),
                    ),
                  );
                },
                child: Card(
                  elevation: 1.5,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(
                          File(
                            _scannedDocuments[index].previewImageUri,
                          ),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: Color(0x70000000),
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          width: double.infinity,
                          child: Text(
                            _scannedDocuments[index].uuid,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed("/doc-scan")
            .then((value) => _updateView()),
        child: const Icon(Icons.camera_alt_outlined),
        backgroundColor: Colors.green,
      ),
    );
  }
}
