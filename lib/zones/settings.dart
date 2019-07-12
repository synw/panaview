import 'package:flutter/material.dart';
import 'package:filex/filex.dart';
import 'appbar.dart';
import '../conf.dart';
import '../state.dart';

class SettingsState extends State<SettingsZone> {
  @override
  Widget build(BuildContext context) {
    final dirPaths = <String>[];
    topButtons.forEach((dynamic b) => dirPaths.add(b.values.first.toString()));
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            const Text("Settings", textScaleFactor: 2.0),
            const Padding(padding: EdgeInsets.only(bottom: 15.0)),
            const Text("Select folders for the top app bar:"),
            const Padding(padding: EdgeInsets.only(bottom: 15.0)),
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                height: 500,
                width: 400,
                child: Filex(
                  directory: conf.homeDir,
                  directoryTrailingBuilder: (context, dir) {
                    Widget w;
                    if (dirPaths.contains(dir.path)) {
                      w = IconButton(
                          icon: const Icon(Icons.delete), onPressed: () {});
                    } else {
                      w = IconButton(
                          icon: const Icon(Icons.file_download),
                          onPressed: () {
                            topButtons
                                .add(<String, String>{dir.filename: dir.path});
                            conf.write(<String, dynamic>{
                              "top_buttons": topButtons,
                              "packages_directory": packagesDir.path
                            });
                            setAppBar(AppBarZone());
                          });
                    }
                    return w;
                  },
                ))
          ])),
    );
  }
}

class SettingsZone extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}
