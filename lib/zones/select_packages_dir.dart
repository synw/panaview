import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filex/filex.dart';
import 'packages_dir.dart';
import '../conf.dart';

class SelectPackagesDirZone extends StatelessWidget {
  final controller = FilexController(path: conf.homeDir.path);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Filex(
            compact: true,
            controller: controller,
            directoryTrailingBuilder: (context, item) {
              return GestureDetector(
                  child: const Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 3.0, 0),
                      child: Icon(Icons.file_download,
                          color: Colors.grey, size: 20.0)),
                  onTap: () {
                    final dir = Directory(item.item.path);
                    setPackagesDir(dir);
                    setSide(PackagesDir(packagesDir: dir));
                  });
            }));
  }
}
