import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';
import 'models/package.dart';
import 'layout.dart';
import 'zones/packages_dir.dart';

ConfigManager conf;
Directory packagesDir;
bool hasPackagesDir = false;
CodePackages packages;

bool initialRunDone = false;

StreamController<CodePackage> currentPackage = StreamController<CodePackage>();

void initConf() {
  conf = ConfigManager.auto("panaview")..read();
}

void setPackagesDir(Directory dir) {
  packagesDir = dir;
  zones.pushChild("side", PackagesDir());
  clearStatus();
  conf.data["packages_directory"] = packagesDir.path;
  conf.write();
}

void setPackages(List<CodePackage> _packages) {
  packages = packages;
}

void setStatus(String msg) => zones.pushChild("status", Text(msg));

void flashStatus(String msg) {
  zones.pushChild("status", Text(msg));
  Future<Null>.delayed(Duration(seconds: 5)).then((_) => clearStatus());
}

void clearStatus() => zones.pushChild("status", const Text(""));

void selectPackage(CodePackage package) => currentPackage.sink.add(package);
