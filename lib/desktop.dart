import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';
import 'package:provider/provider.dart';
import 'top.dart';
import 'layout.dart';
import 'state.dart';

class DesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final update = Provider.of<UpdateAction>(context);
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
                        Expanded(flex: 2, child: update.state.sideBarZone),
                        DesktopVerticalDivider(),
                        Expanded(
                          flex: 8,
                          child: SingleChildScrollView(
                              child: update.state.mainZone),
                        ),
                      ]),
                ),
              ],
            )));
  }
}
