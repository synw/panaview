import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'models/package.dart';
import 'models/analysis_log.dart';
import 'models/analysis.dart';
import 'packages/commands/analyze.dart';
import 'packages/commands/process_results.dart';
import 'analysis_results.dart';
import 'conf.dart';

class _ViewPackageState extends State<ViewPackage> {
  CodePackage package;
  final StreamController<AnalysisLog> commandLog =
      StreamController<AnalysisLog>();
  var logs = <Text>[];
  PackageAnalysis analysis;
  bool analyzing = false;
  bool hasAnalysis = false;

  StreamSubscription<CodePackage> _currentPackageSub;

  @override
  void initState() {
    _currentPackageSub = currentPackage.stream.listen((data) {
      setState(() {
        logs = <Text>[];
        package = data;
        analysis = null;
        hasAnalysis = false;
      });
      // load previous analysis data
      for (final dir in conf.appConfigDir.listSync()) {
        if (basename(dir.path) == package.name) {
          final f =
              File("${conf.appConfigDir.path}/${package.name}/analysis.json");
          final bytes = f.readAsBytesSync();
          final String msg = String.fromCharCodes(bytes);
          final Map<String, dynamic> res =
              json.decode(msg) as Map<String, dynamic>;
          processAnalysisResults(res, commandLog, quiet: true);
        }
      }
    });

    commandLog.stream.listen((data) {
      switch (data.type) {
        case AnalysisLogType.message:
          setState(() => logs.add(Text(data.message)));
          break;
        case AnalysisLogType.analysisCompleted:
          setStatus("Processing analysis results");
          setState(
              () => logs.add(const Text("Analysis done, processing data")));
          break;
        case AnalysisLogType.analysisProcessed:
          setState(() {
            analyzing = false;
            analysis = data.analysis;
            hasAnalysis = true;
            logs = <Text>[];
          });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget w;
    if (package == null)
      w = const Text("");
    else
      w = Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: hasAnalysis
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                          "${package.namePretty} " +
                                              "${analysis.version}",
                                          textScaleFactor: 1.8)),
                                ])
                          : Text(package.namePretty, textScaleFactor: 1.8)),
                  RaisedButton(
                    child: const Text("Analyze"),
                    color: Colors.green,
                    onPressed: () {
                      setStatus("Analyzing package ${package.name}");
                      analyze(package, commandLog);
                      setState(() => analyzing = true);
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: hasAnalysis
                    ? Text("${analysis.description}")
                    : const Text(""),
              ),
              analyzing
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: logs)
                  : hasAnalysis
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: AnalysisResultsDisplay(package, analysis))
                      : const Text("")
            ],
          ));
    return w;
  }

  @override
  void dispose() {
    commandLog.close();
    _currentPackageSub.cancel();
    super.dispose();
  }
}

class ViewPackage extends StatefulWidget {
  @override
  _ViewPackageState createState() => _ViewPackageState();
}
