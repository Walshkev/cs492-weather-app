import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast/forecast.dart' as forecast;
import 'package:weatherapp/scripts/utilities/time.dart' as time;

class ForecastNameWidget extends StatelessWidget {
  const ForecastNameWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Text(
        _forecast.name ??
            time.convertTimestampToDayAndHour(_forecast.startTime.toLocal()),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12.0));
  }
}
