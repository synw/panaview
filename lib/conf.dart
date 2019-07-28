import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';
import 'models/package.dart';
import 'packages/commands/scan.dart';
import 'state.dart';

ConfigManager conf;
bool hasPackagesDir = false;

final updateController = StreamController<Store>();

bool initialRunDone = false;

StreamController<CodePackage> currentPackage =
    StreamController<CodePackage>.broadcast();

void initConf() {
  conf = ConfigManager.auto("panaview")..read();
  if (conf.data.containsKey("top_buttons") == true) {
    final topButtons = conf.key("top_buttons") as List<dynamic>;
    Store.setTopButtons(topButtons);
  }
}

void setPackagesDir(Directory dir) {
  setStatus("Scanning packages");
  final packages = scanPackages(dir);
  clearStatus();
  Store.setPackagesDir(dir);
  Store.setPackages(packages);
  conf.data["packages_directory"] = dir.path;
  conf.write();
}

void setTopButtons(List<dynamic> topButtons, Directory packagesDir) {
  Store.setTopButtons(topButtons);
  conf.write(<String, dynamic>{
    "top_buttons": topButtons,
    "packages_directory": packagesDir.path
  });
}

void setPackages(CodePackages _packages) {
  Store.setPackages(_packages);
}

void setMain(Widget w) =>
    updateController.sink.add(Store.update(UpdateActionType.refreshMain, w));

void setSide(Widget w) =>
    updateController.sink.add(Store.update(UpdateActionType.refreshSide, w));

void setAppBar(Widget w) =>
    updateController.sink.add(Store.update(UpdateActionType.refreshAppBar, w));

void setStatus(String msg) => updateController.sink
    .add(Store.update(UpdateActionType.refreshStatus, Text(msg)));

void flashStatus(String msg) {
  updateController.sink
      .add(Store.update(UpdateActionType.refreshStatus, Text(msg)));
  Future<Null>.delayed(Duration(seconds: 5)).then((_) => clearStatus());
}

void clearStatus() => updateController.sink
    .add(Store.update(UpdateActionType.refreshStatus, const Text("")));

void selectPackage(CodePackage package) => currentPackage.sink.add(package);
