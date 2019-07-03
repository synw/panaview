import 'package:flutter/material.dart';
import 'package:panaview/conf.dart';
import 'widgets/menu.dart';
import 'layout.dart';
import 'explorer.dart';
import 'zones/select_packages_dir.dart';

class TopAppBloc extends StatelessWidget {
  final _iconColor = Colors.blueGrey[500];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xffcecece),
        child: Column(children: <Widget>[
          //const TopMenu(),
          Container(
              height: 1.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: const Text("")),
          Row(
            children: <Widget>[
              Expanded(
                child: AppActionsBar(children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.folder_special, color: _iconColor),
                    onPressed: () {
                      setStatus("Pick a folder for packages");
                      zones.pushChild("side", SelectPackagesDirZone());
                    },
                  ),
                ]),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 30.0, 0),
                    child: zones.getZone("status"),
                  )
                ],
              )
            ],
          ),
          Container(
              height: 1.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: const Text("")),
        ]));
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
