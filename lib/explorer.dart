import 'package:flutter/material.dart';

class _ExplorerZoneState extends State<ExplorerZone> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: const Text("Explorer"),
    );
  }
}

class ExplorerZone extends StatefulWidget {
  @override
  _ExplorerZoneState createState() => _ExplorerZoneState();
}
