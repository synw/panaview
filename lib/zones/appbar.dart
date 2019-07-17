import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../conf.dart';
import 'settings.dart';
import 'select_packages_dir.dart';
import 'packages_dir.dart';
import '../state.dart';

class AppBarZone extends StatelessWidget {
  final _iconColor = Colors.blueGrey[500];

  @override
  Widget build(BuildContext context) {
    final topButtons = Provider.of<Store>(context).state.topButtons;
    return AppActionsBar(children: <Widget>[
      IconButton(
        icon: Icon(Icons.folder_special, color: _iconColor),
        onPressed: () {
          setStatus("Pick a folder for packages");
          setSide(SelectPackagesDirZone());
        },
      ),
      IconButton(
        icon: Icon(Icons.settings, color: _iconColor),
        onPressed: () {
          setMain(SettingsZone());
        },
      ),
      Row(children: <Widget>[
        for (final folder in topButtons)
          Row(
            children: <Widget>[
              GestureDetector(
                child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.folder, color: Colors.yellow),
                        Text(" ${folder.keys.first}")
                      ],
                    )),
                onTap: () {
                  final Directory dir =
                      Directory(folder.values.first.toString());
                  setPackagesDir(dir);
                  setSide(PackagesDir(packagesDir: dir));
                },
              )
            ],
          )
      ])
    ]);
  }
}

class AppActionsBar extends StatelessWidget {
  AppActionsBar({@required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(children: children));
  }
}
