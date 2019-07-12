import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../conf.dart';
import 'packages_dir.dart';
import '../view_package.dart';

class _IntroZoneState extends State<IntroZone> {
  final Completer _ready = Completer<Null>();

  @override
  void initState() {
    _ready.future.then((dynamic _) {
      final dynamic raw = conf.key("packages_directory");
      final String packagesDirPath = raw.toString();
      //print("******** $packagesDirPath / ${packagesDirPath != null}");
      if (raw != null) {
        packagesDir = Directory(packagesDirPath);
        hasPackagesDir = true;
        clearStatus();
        setSide(PackagesDir());
      } else {
        setStatus("Pick a folder for packages");
      }
      setMain(ViewPackage());
    });
    super.initState();
    _ready.complete();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class IntroZone extends StatefulWidget {
  @override
  _IntroZoneState createState() => _IntroZoneState();
}
