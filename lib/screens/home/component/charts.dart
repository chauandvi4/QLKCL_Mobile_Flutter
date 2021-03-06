import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:qlkcl/models/key_value.dart';

// cre: https://google.github.io/charts/flutter/example/bar_charts/grouped_fill_color.html

/// Example of a grouped bar chart with three series, each rendered with
/// different fill colors.
class GroupedFillColorBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  GroupedFillColorBarChart(this.seriesList, {required this.animate});

  factory GroupedFillColorBarChart.withData(
      List<KeyValue> inData, List<KeyValue> outData) {
    return new GroupedFillColorBarChart(
      _createChart(inData, outData),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      // Configure a stroke width to enable borders on the bars.
      // defaultRenderer: new charts.BarRendererConfig(
      //     groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
      behaviors: [
        new charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
        )
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<KeyValue, String>> _createChart(
      List<KeyValue> inData, List<KeyValue> outData) {
    return [
      // Blue bars with a lighter center color.
      new charts.Series<KeyValue, String>(
        id: 'Mới cách ly',
        domainFn: (KeyValue num, _) => num.id,
        measureFn: (KeyValue num, _) => num.name,
        data: inData,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
      ),
      // Hollow green bars.
      new charts.Series<KeyValue, String>(
        id: 'Hoàn thành cách ly',
        domainFn: (KeyValue num, _) => num.id,
        measureFn: (KeyValue num, _) => num.name,
        data: outData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
    ];
  }
}
