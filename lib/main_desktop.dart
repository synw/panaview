import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'desktop.dart';
import 'conf.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  initConf();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panaview',
      home: DesktopPage(),
      //theme: ThemeData.dark(),
    );
  }
}
