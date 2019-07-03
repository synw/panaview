import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  PageTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(title, textScaleFactor: 2.0),
    );
  }
}
