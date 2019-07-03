import 'analysis.dart';

enum AnalysisLogType { message, analysisCompleted, analysisProcessed }

class AnalysisLog {
  AnalysisLog(
      {this.type = AnalysisLogType.message,
      this.result,
      this.message,
      this.analysis});

  final AnalysisLogType type;
  final Map<String, dynamic> result;
  final String message;
  final PackageAnalysis analysis;
}
