import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../../models/package.dart';

CodePackages scanPackages(Directory packagesDir) {
  final _flutterPackages = <CodePackage>[];
  final _dartPackages = <CodePackage>[];
  final List<FileSystemEntity> pkgs = packagesDir.listSync();
  final List<FileSystemEntity> pkgsSorted = pkgs
    ..sort((a, b) => a.path.compareTo(b.path));
  for (final FileSystemEntity package in pkgsSorted) {
    if (package is Directory) {
      bool hasPubspec = false;
      bool hasAndroid = false;
      bool hasIos = false;
      Image logo;
      final String packageName = basename(package.path);
      for (final dirInPackage in package.listSync()) {
        final String name = basename(dirInPackage.path);
        if (name == "pubspec.yaml")
          hasPubspec = true;
        else if (name == "android")
          hasAndroid = true;
        else if (name == "ios")
          hasIos = true;
        else if (name == "assets") {
          final assetsDir = Directory("${dirInPackage.path}");
          for (final asset in assetsDir.listSync()) {
            if (basename(asset.path) == "logo.png") {
              logo = Image.file(File("${dirInPackage.path}/logo.png"),
                  width: 25.0, height: 25.0);
              break;
            }
          }
        }
      }
      if (hasPubspec) {
        if (hasAndroid && hasIos)
          _flutterPackages.add(CodePackage(
              name: packageName,
              directory: Directory("${packagesDir.path}/$packageName"),
              isFlutter: true,
              logo: logo));
        else
          _dartPackages.add(CodePackage(
              name: packageName,
              directory: Directory("${packagesDir.path}/$packageName"),
              logo: logo));
      }
    }
  }
  return CodePackages(
      flutterPackages: _flutterPackages, dartPackages: _dartPackages);
}
