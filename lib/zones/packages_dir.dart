import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktopia/desktopia.dart';
import 'package:panaview/view_package.dart';
import 'package:provider/provider.dart';
import '../models/package.dart';
import '../conf.dart';
import '../state.dart';

class _PackagesDirState extends State<PackagesDir> {
  _PackagesDirState({@required this.packagesDir});

  final Directory packagesDir;

  @override
  Widget build(BuildContext context) {
    final CodePackages packages = Provider.of<Store>(context).state.packages;
    return SingleChildScrollView(
        child: Scrollbar(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
          DesktopSectionHeader(title: "Flutter packages", borderTop: false),
          const Padding(padding: EdgeInsets.only(bottom: 8.0)),
          for (final package in packages.flutterPackages)
            PackageLine(
              package: package,
            ),
          const Padding(padding: EdgeInsets.only(bottom: 12.0)),
          if (packages.dartPackages.isNotEmpty)
            DesktopSectionHeader(title: "Dart packages", borderTop: false),
          const Padding(padding: EdgeInsets.only(bottom: 8.0)),
          if (packages.dartPackages.isNotEmpty)
            for (final package in packages.dartPackages)
              PackageLine(
                package: package,
              ),
        ])));
  }
}

class PackageLine extends StatelessWidget {
  const PackageLine({
    Key key,
    @required this.package,
  }) : super(key: key);

  final CodePackage package;

  @override
  Widget build(BuildContext context) {
    String type = "dart";
    if (package.isFlutter) type = "flutter";
    Image logo = Image.asset("assets/img/$type.png", width: 20.0, height: 20.0);
    if (package.hasLogo) logo = package.logo;

    return Padding(
        child: Row(
          children: <Widget>[
            logo,
            GestureDetector(
                child: Text(" ${package.name}", overflow: TextOverflow.clip),
                onTap: () {
                  setMain(ViewPackage());
                  selectPackage(package);
                }),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(10.0, 4.0, 5.0, 4.0));
  }
}

class PackagesDir extends StatefulWidget {
  PackagesDir({@required this.packagesDir});

  final Directory packagesDir;

  @override
  _PackagesDirState createState() =>
      _PackagesDirState(packagesDir: packagesDir);
}
