import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'desktop.dart';
import 'conf.dart';
import 'state.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  initConf();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Store>.value(
      initialData: Store(),
      value: updateController.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DesktopPage(),
      ),
      //theme: ThemeData.dark(),
    );
  }
}
