import 'dart:io';
import 'package:flutter/material.dart';
import 'zones/intro.dart';
import 'zones/appbar.dart';
import 'models/package.dart';

enum UpdateActionType { refreshMain, refreshSide, refreshStatus, refreshAppBar }

class Store {
  Store();

  final state = _state;

  Store.setPackages(CodePackages packages) {
    _state.packages = packages;
  }

  Store.setPackagesDir(Directory dir) {
    _state.packagesDir = dir;
  }

  Store.setTopButtons(List<dynamic> buttons) {
    _state.topButtons = buttons;
  }

  Store.update(UpdateActionType type, Widget w) {
    switch (type) {
      case UpdateActionType.refreshMain:
        _state.mainZone = w;
        break;
      case UpdateActionType.refreshSide:
        _state.sideBarZone = w;
        break;
      case UpdateActionType.refreshStatus:
        _state.statusZone = w;
        break;
      case UpdateActionType.refreshAppBar:
        _state.appBarZone = w;
        break;
    }
  }
}

final _state = AppState();

class AppState {
  AppState();

  Widget statusZone = const Text("");
  Widget appBarZone = AppBarZone();
  Widget sideBarZone = const Text("");
  Widget mainZone = IntroZone();

  Directory packagesDir;
  CodePackages packages;
  List<dynamic> topButtons = <dynamic>[];
}
