import 'dart:async';
import '../../models/analysis.dart';
import '../../models/analysis_log.dart';
import '../../conf.dart';

void processAnalysisResults(
    Map<String, dynamic> data, StreamSink<AnalysisLog> logger,
    {bool quiet = false}) {
  if (!quiet) logger.add(AnalysisLog(message: "Processing analysis results"));
  final analysis = PackageAnalysis();
  analysis.version = data["packageVersion"].toString();
  analysis.sdkVersion = data["pubspec"]["environment"]["sdk"].toString();
  if (data["runtimeInfo"].containsKey("flutterVersions") == true) {
    analysis.flutterVersion =
        data["runtimeInfo"]["flutterVersions"]["frameworkVersion"].toString();
    analysis.flutterChannel =
        data["runtimeInfo"]["flutterVersions"]["channel"].toString();
  }
  analysis.description = data["pubspec"]["description"].toString();
  final deps = <PackageDependency>[];
  final spec = data["pubspec"] as Map<String, dynamic>;
  if (spec.containsKey("dependencies")) {
    for (final key in data["pubspec"]["dependencies"].keys) {
      if (key != "flutter")
        deps.add(PackageDependency(
            name: key.toString(),
            version: data["pubspec"]["dependencies"][key].toString()));
    }
  }
  analysis.dependencies = deps;
  var numErrors = int.parse(data["health"]["analyzerErrorCount"].toString());
  var numWarnings =
      int.parse(data["health"]["analyzerWarningCount"].toString());
  var numHints = int.parse(data["health"]["analyzerHintCount"].toString());
  // health
  final sugs = <PackageSuggestion>[];
  if (data["health"].containsKey("suggestions") == true) {
    for (final sug in data["health"]["suggestions"]) {
      final s = PackageSuggestion(
          description: sug["description"].toString(),
          file: sug["file"].toString(),
          level: sug["level"].toString(),
          title: sug["title"].toString(),
          from: sug["code"].toString(),
          type: SuggestionType.health);
      if (sug.containsKey("score") == true)
        s.scoreImpact = double.parse(sug["score"].toString());
      sugs.add(s);
    }
  }
  analysis.health =
      PackageHealth(score: double.parse(data["scores"]["health"].toString()));
  // maintenance
  if (data["maintenance"].containsKey("suggestions") == true)
    for (final sug in data["maintenance"]["suggestions"]) {
      final level = sug["level"].toString();
      final s = PackageSuggestion(
          description: sug["description"].toString(),
          file: sug["file"].toString(),
          level: level,
          title: sug["title"].toString(),
          from: sug["code"].toString(),
          type: SuggestionType.maintenance);
      if (sug.containsKey("score") == true)
        s.scoreImpact = double.parse(sug["score"].toString());
      sugs.add(s);
      if (level == "hint")
        numHints = numHints + 1;
      else if (level == "warning")
        numWarnings = numWarnings + 1;
      else if (level == "error") numErrors = numErrors + 1;
    }
  final List<MissingInPackage> missing = [];
  if (data["maintenance"]["missingChangelog"] == true)
    missing.add(MissingInPackage.changelog);
  if (data["maintenance"]["missingExample"] == true)
    missing.add(MissingInPackage.example);
  if (data["maintenance"]["missingReadme"] == true)
    missing.add(MissingInPackage.readme);
  if (data["maintenance"]["missingAnalysisOptions"] == true)
    missing.add(MissingInPackage.analysisOptions);
  analysis.maintenance = PackageMaintenance(
      experimental: data["maintenance"]["isExperimentalVersion"] == true,
      preRelease: data["maintenance"]["isPreReleaseVersion"] == true,
      strongMode: data["maintenance"]["strongModeEnabled"] == true,
      score: double.parse(data["scores"]["maintenance"].toString()),
      missing: missing);
  final List<PackageFile> files = [];
  for (final key in data["dartFiles"].keys) {
    files.add(PackageFile(
        uri: data["dartFiles"][key]["uri"].toString(),
        path: key.toString(),
        size: int.parse(data["dartFiles"][key]["size"].toString()),
        isFormated: data["dartFiles"][key]["isFormatted"] == true,
        codeProblems: data["dartFiles"][key]["codeProblems"]));
  }
  analysis.suggestions = sugs;
  analysis.numErrors = numErrors;
  analysis.numHints = numHints;
  analysis.numWarnings = numWarnings;
  analysis.timeToComplete = int.parse(data["stats"]["totalElapsed"].toString());
  analysis.timeToCompleteFormated =
      (analysis.timeToComplete / 1000).toStringAsFixed(1);
  if (!quiet)
    flashStatus("Analysis completed in " +
        "${analysis.timeToCompleteFormated} seconds");
  logger.add(
      AnalysisLog(type: AnalysisLogType.analysisProcessed, analysis: analysis));
}
