import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filex/filex.dart';
import 'appbar.dart';
import '../conf.dart';
import '../state.dart';

class SettingsState extends State<SettingsZone> {
  final controller = FilexController(path: conf.homeDir.path);

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<Store>(context).state;
    final dirPaths = <String>[];
    state.topButtons
        .forEach((dynamic b) => dirPaths.add(b.values.first.toString()));
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
                  controller: controller,
                  directoryTrailingBuilder: (context, dir) {
                    Widget w;
                    if (dirPaths.contains(dir.path)) {
                      w = IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            final btns = <dynamic>[];
                            for (final btn in state.topButtons) {
                              for (final filename in btn.keys) {
                                if (filename != dir.filename) {
                                  btns.add(<String, String>{
                                    filename.toString():
                                        btn[filename].toString()
                                  });
                                }
                              }
                            }
                            setTopButtons(btns, state.packagesDir);
                            setAppBar(AppBarZone());
                          });
                    } else {
                      w = IconButton(
                          icon: const Icon(Icons.file_download),
                          onPressed: () {
                            final topButtons = <dynamic>[]
                              ..addAll(state.topButtons)
                              ..add(<String, String>{dir.filename: dir.path});
                            setTopButtons(topButtons, state.packagesDir);
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
