import 'package:flutter/material.dart';

void aboutDialog(BuildContext context) {
  showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("About"),
        content: const Text("Made by synw: https://github.com/synw"),
        actions: <Widget>[
          FlatButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
