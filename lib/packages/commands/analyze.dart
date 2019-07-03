import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:panaview/conf.dart';
import '../../models/package.dart';
import '../../models/analysis_log.dart';
import 'process_results.dart';

Future<void> analyze(
    CodePackage package, StreamSink<AnalysisLog> logger) async {
  final String cmd = "pana";
  final List<String> args = <String>[
    "-j",
    "--no-warning",
    "--scores",
    "--verbosity=verbose",
    "-s",
    "path",
    package.directory.path
  ];
  print("Running $cmd ${args.join(" ")}");
  Process.start(cmd, args).then((process) {
    StreamSubscription out;
    StreamSubscription err;
    out = process.stdout.listen((data) {
      // save
      final Directory dir =
          Directory("${conf.appConfigDir.path}/${package.name}");
      if (!dir.existsSync()) dir.createSync();
      final File file = File("${dir.path}/analysis.json");
      if (!file.existsSync()) file.createSync();
      file.writeAsBytesSync(data);
      // process
      final String msg = String.fromCharCodes(data);
      final Map<String, dynamic> res = json.decode(msg) as Map<String, dynamic>;
      logger.add(AnalysisLog(type: AnalysisLogType.analysisCompleted));
      processAnalysisResults(res, logger);
      out.cancel();
      err.cancel();
    });
    err = process.stderr.listen((data) {
      final String msg = String.fromCharCodes(data);
      try {
        final dynamic res = json.decode(msg);
        logger.add(AnalysisLog(message: res["message"].toString()));
      } catch (_) {}
    });
  });
}
