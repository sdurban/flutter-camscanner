import 'package:flutter/material.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show(bool showProgress) {
    showDialog(
        context: _context,
        barrierDismissible: false,
        child: _FullScreenLoader(showProgress));
  }

  Future<T> during<T>(Future<T> future, {bool showProgress = true}) {
    show(showProgress);
    return future.whenComplete(hide);
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  final bool _showProgress;

  _FullScreenLoader(this._showProgress);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
      child: Center(
        child: _showProgress ? const CircularProgressIndicator() : Container(),
      ),
    );
  }
}