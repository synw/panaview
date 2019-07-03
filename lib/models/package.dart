import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CodePackages {
  CodePackages({@required this.dartPackages, @required this.flutterPackages});

  final List<CodePackage> flutterPackages;
  final List<CodePackage> dartPackages;
}

class CodePackage {
  CodePackage(
      {@required this.name,
      @required this.directory,
      this.isFlutter = false,
      this.logo}) {
    namePretty = capitalize(name.replaceAll("_", " "));
  }

  final String name;
  final bool isFlutter;
  final Directory directory;
  final Image logo;
  String namePretty;

  bool get hasLogo => logo != null;
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
