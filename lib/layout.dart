/*
import 'dart:async';
import 'package:desktopia/desktopia.dart';
import 'zones/select_packages_dir.dart';
import 'zones/status.dart';
import 'zones/intro.dart';
import 'zones/appbar.dart';

final StreamController<ScreenZoneUpdate> zoneUpdate =
    StreamController<ScreenZoneUpdate>.broadcast();

final ScreenZones zones =
    ScreenZones(updates: zoneUpdate, children: <String, ScreenZone>{
  "topbar": ScreenZone(
      name: "topbar", child: TopAppBarZone(), updates: zoneUpdate.stream),
  "side": ScreenZone(
      name: "side", child: SelectPackagesDirZone(), updates: zoneUpdate.stream),
  "main":
      ScreenZone(name: "main", child: IntroZone(), updates: zoneUpdate.stream),
  "status": ScreenZone(
      name: "status", child: StatusZone(), updates: zoneUpdate.stream),
});*/
