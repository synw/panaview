import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';

class TopMenu extends StatelessWidget {
  const TopMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuBar(MenuBarData(menuItems: <MenuItem>[
      MenuItem(
        context: context,
        title: "File",
        actionMenu: ActionMenu(actions: <MenuAction>[
          MenuAction(
            title: "Quit",
            onPressed: () => exit(0),
          )
        ]),
      ),
      MenuItem(context: context, title: "Ping", action: () => null),
      MenuItem(context: context, title: "Quit", action: () => exit(0))
    ]));
  }
}
