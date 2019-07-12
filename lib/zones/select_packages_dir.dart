import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filex/filex.dart';
import '../conf.dart';

class SelectPackagesDirZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Filex(
            compact: true,
            directory: Directory(conf.homeDir.path),
            directoryTrailingBuilder: (context, item) {
              return GestureDetector(
                  child: const Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 3.0, 0),
                      child: Icon(Icons.file_download,
                          color: Colors.grey, size: 20.0)),
                  onTap: () => setPackagesDir(Directory(item.item.path)));
            }));
  }
}
