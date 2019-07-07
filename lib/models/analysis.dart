import 'package:meta/meta.dart';

enum MissingInPackage { changelog, example, readme, analysisOptions }

enum SuggestionType { health, maintenance }

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
  List<PackageSuggestion> suggestions;
  int numErrors;
  int numWarnings;
  int numHints;
}

class PackageDependency {
  PackageDependency({@required this.name, @required this.version});

  final String name;
  final String version;
}

class PackageHealth {
  PackageHealth({@required this.score});

  final double score;
}

class PackageMaintenance {
  PackageMaintenance(
      {@required this.missing,
      @required this.strongMode,
      @required this.experimental,
      @required this.preRelease,
      @required this.score});

  final List<MissingInPackage> missing;
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
      @required this.type,
      this.scoreImpact});

  final String from;
  final String level;
  final String title;
  final String description;
  final String file;
  final SuggestionType type;
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
