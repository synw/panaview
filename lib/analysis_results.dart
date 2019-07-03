import 'package:flutter/material.dart';
import 'models/package.dart';
import 'models/analysis.dart';

class AnalysisResultsDisplay extends StatelessWidget {
  AnalysisResultsDisplay(this.package, this.analysis);

  final PackageAnalysis analysis;
  final CodePackage package;

  List<Widget> configData() {
    final List<Widget> deps = <Widget>[];
    if (analysis.dependencies != null) {
      if (analysis.dependencies.isNotEmpty)
        for (final dep in analysis.dependencies)
          deps.add(Text("  - ${dep.name} ${dep.version}"));
    }
    final res = <Widget>[Text("Sdk: ${analysis.sdkVersion}")];
    if (package.isFlutter) {
      res.add(Text("Flutter version: ${analysis.flutterVersion}"));
      res.add(Text("Flutter version: ${analysis.flutterChannel}"));
    }
    if (deps.isEmpty)
      res.add(const Text("Dependencies: none"));
    else
      res.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: const Text("Dependencies:")),
            ...deps
          ]));
    return res;
  }

  List<Widget> summaryData() {
    final int numSuggestions = analysis.health.suggestions.length +
        analysis.maintenance.suggestions.length;
    final res = <Widget>[
      formatScore(analysis.health.score, "Health"),
      formatScore(analysis.maintenance.score, "Maintenance"),
      Text("Errors: ${analysis.health.numErrors}"),
      Text("Warnings: ${analysis.health.numWarnings}"),
      Text("Hints: ${analysis.health.numHints}"),
      Text("Suggestions: $numSuggestions"),
    ];
    return res;
  }

  ListView suggestions() {
    final List<PackageSuggestion> allSugs = analysis.maintenance.suggestions;
    allSugs.addAll(analysis.health.suggestions);
    final w = ListView.builder(
      shrinkWrap: true,
      itemCount: allSugs.length,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          title: Suggestion(sug: allSugs[i]),
        );
      },
    );
    return w;
  }

  @override
  Widget build(BuildContext context) {
    final sugs = suggestions();
    return Column(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CardBloc(
                analysis: analysis, title: "Config", data: configData()),
          ),
          Expanded(
            flex: 2,
            child: CardBloc(
                analysis: analysis, title: "Summary", data: summaryData()),
          )
        ],
      ),
      sugs
    ]);
  }

  Row formatScore(double score, String type) {
    Row w;
    final String s = score.toString().replaceAll(".0", "");
    Color color;
    if (score == 100)
      color = Colors.green;
    else if (score < 65)
      color = Colors.red;
    else
      color = Colors.orange;
    w = Row(children: <Widget>[
      Text("$type score: "),
      Text(s, style: TextStyle(color: color))
    ]);

    return w;
  }
}

class Suggestion extends StatelessWidget {
  const Suggestion({
    Key key,
    @required this.sug,
  }) : super(key: key);

  final PackageSuggestion sug;

  Widget formatLevel() {
    Widget w;
    switch (sug.level) {
      case "warning":
        w = Text("Warning",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
        break;
      case "hint":
        w = Text("Hint",
            style:
                TextStyle(color: Colors.orange, fontWeight: FontWeight.bold));
        break;
      default:
    }
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[formatLevel(), Text(": ${sug.title}")]),
          const Padding(padding: EdgeInsets.only(bottom: 10.0)),
          Text("${sug.description}")
        ]));
  }
}

class CardBloc extends StatelessWidget {
  const CardBloc(
      {Key key,
      @required this.analysis,
      @required this.title,
      @required this.data})
      : super(key: key);

  final PackageAnalysis analysis;
  final String title;
  final List<Widget> data;

  List<Widget> getRows() {
    final wl = <Widget>[];
    for (final item in data) {
      wl.add(Padding(padding: const EdgeInsets.only(bottom: 5.0), child: item));
    }
    return wl;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        color: Colors.blue,
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              title,
                              textScaleFactor: 1.3,
                              style: TextStyle(color: Colors.white),
                            )))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getRows()),
          )
        ]));
  }
}
