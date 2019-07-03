import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';
import 'top.dart';
import 'layout.dart';

class DesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                TopAppBloc(),
                Expanded(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 2, child: zones.getZone("side")),
                        DesktopVerticalDivider(),
                        Expanded(
                          flex: 8,
                          child: SingleChildScrollView(
                              child: zones.getZone("main")),
                        ),
                      ]),
                ),
              ],
            )));
  }
}
