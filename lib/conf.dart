import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';
import 'zones/packages_dir.dart';
import 'models/package.dart';
import 'state.dart';

ConfigManager conf;
Directory packagesDir;
bool hasPackagesDir = false;
CodePackages packages;
List<dynamic> topButtons = <dynamic>[];

final updateController = StreamController<UpdateAction>();

bool initialRunDone = false;

StreamController<CodePackage> currentPackage = StreamController<CodePackage>();

void initConf() {
  conf = ConfigManager.auto("panaview")..read();
  if (conf.data.containsKey("top_buttons"))
    topButtons = conf.key("top_buttons") as List<dynamic>;
}

void setPackagesDir(Directory dir) {
  packagesDir = dir;
  setSide(PackagesDir());
  clearStatus();
  conf.data["packages_directory"] = packagesDir.path;
  conf.write();
}

void setPackages(List<CodePackage> _packages) {
  packages = packages;
}

void setMain(Widget w) => updateController.sink
    .add(UpdateAction.update(UpdateActionType.refreshMain, w));

void setSide(Widget w) => updateController.sink
    .add(UpdateAction.update(UpdateActionType.refreshSide, w));

void setAppBar(Widget w) => updateController.sink
    .add(UpdateAction.update(UpdateActionType.refreshAppBar, w));

void setStatus(String msg) => updateController.sink
    .add(UpdateAction.update(UpdateActionType.refreshStatus, Text(msg)));

void flashStatus(String msg) {
  updateController.sink
      .add(UpdateAction.update(UpdateActionType.refreshStatus, Text(msg)));
  Future<Null>.delayed(Duration(seconds: 5)).then((_) => clearStatus());
}

void clearStatus() => updateController.sink
    .add(UpdateAction.update(UpdateActionType.refreshStatus, const Text("")));

void selectPackage(CodePackage package) => currentPackage.sink.add(package);
