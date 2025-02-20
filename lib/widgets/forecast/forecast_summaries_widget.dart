import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast/forecast.dart' as forecast;
import 'package:weatherapp/widgets/forecast/forecast_summary_widget.dart';
import 'package:weatherapp/widgets/forecast/on_tap_summary_widget.dart';

class ForecastSummariesWidget extends StatelessWidget {
  const ForecastSummariesWidget({
    super.key,
    required List<forecast.Forecast> forecasts,
    required Function setActiveForecast,
  })  : _forecasts = forecasts,
        _setActiveForecast = setActiveForecast;

  final List<forecast.Forecast> _forecasts;
  final Function _setActiveForecast;

  List<OnTapSummaryWidget> getForecastWidgets() {
    List<OnTapSummaryWidget> widgets = [];

    for (int i = 0; i < _forecasts.length; i++) {
      widgets.add(OnTapSummaryWidget(
          forecasts: _forecasts, i: i, setActiveForecast: _setActiveForecast));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: getForecastWidgets()));
  }
}
