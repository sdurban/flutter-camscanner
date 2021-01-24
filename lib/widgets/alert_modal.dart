import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class AlertModal {
  BuildContext _context;

  void alert({
    @required String title,
    @required String desc,
  }) {
   Alert(
      context: _context,
      type: AlertType.error,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: const Text(
            'Accept',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(_context),
          width: 120,
        )
      ],
    ).show();
  }

  AlertModal._create(this._context);

  factory AlertModal.of(BuildContext context) {
    return AlertModal._create(context);
  }
}