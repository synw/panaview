import 'package:meta/meta.dart';

enum MissingInPackage { changelog, example, readme, analysisOptions }

class PackageAnalysis {
  String version;
  List<PackageDependency> dependencies;
  String sdkVersion;
  String flutterVersion;
  String flutterChannel;
  String description;
  PackageHealth health;
  PackageMaintenance maintenance;
  List<PackageFile> files;
  int timeToComplete;
  String timeToCompleteFormated;
}

class PackageDependency {
  PackageDependency({@required this.name, @required this.version});

  final String name;
  final String version;
}

class PackageHealth {
  PackageHealth(
      {@required this.numErrors,
      @required this.numWarnings,
      @required this.numHints,
      @required this.suggestions,
      @required this.score});

  final int numErrors;
  final int numWarnings;
  final int numHints;
  final List<PackageSuggestion> suggestions;
  final double score;
}

class PackageMaintenance {
  PackageMaintenance(
      {@required this.missing,
      @required this.suggestions,
      @required this.strongMode,
      @required this.experimental,
      @required this.preRelease,
      @required this.score});

  final List<MissingInPackage> missing;
  final List<PackageSuggestion> suggestions;
  final bool strongMode;
  final bool experimental;
  final bool preRelease;
  final double score;
}

class PackageSuggestion {
  PackageSuggestion(
      {@required this.from,
      @required this.level,
      @required this.title,
      @required this.description,
      @required this.file,
      this.scoreImpact});

  final String from;
  final String level;
  final String title;
  final String description;
  final String file;
  double scoreImpact;
}

class PackageFile {
  PackageFile(
      {@required this.uri,
      @required this.path,
      @required this.size,
      @required this.isFormated,
      @required this.codeProblems});

  final String uri;
  final String path;
  final int size;
  final bool isFormated;
  final dynamic codeProblems;
}
