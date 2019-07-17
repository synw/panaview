import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';
import '../about.dart';

class TopMenu extends StatelessWidget {
  const TopMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuBar(MenuBarData(menuItems: <MenuItem>[
      MenuItem(
          context: context, title: "About", action: () => aboutDialog(context)),
      MenuItem(context: context, title: "Quit", action: () => exit(0))
    ]));
  }
}
