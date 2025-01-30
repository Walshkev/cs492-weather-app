import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Forecast{
  final String? name;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String windSpeed;
  final String windDirection;
  final String shortForecast;
  final String? detailedForecast;
  final int? precipitationProbability;
  final int? humidity;
  final num? dewpoint;
  final String? startTime;
  final String? endTime;

  Forecast({
    required this.name,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.windSpeed,
    required this.windDirection,
    required this.shortForecast,
    required this.detailedForecast,
    required this.precipitationProbability,
    required this.humidity,
    required this.dewpoint,
    required this.startTime,
    required this.endTime
  });

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
      name: json["name"].isNotEmpty ? json["name"] : null,
      isDaytime: json["isDaytime"],
      temperature: json["temperature"],
      temperatureUnit: json["temperatureUnit"],
      windSpeed: json["windSpeed"],
      windDirection: json["windDirection"],
      shortForecast: json["shortForecast"],
      detailedForecast: json["detailedForecast"].isNotEmpty ? json["detailedForecast"]: null ,
      precipitationProbability: json["probabilityOfPrecipitation"]["value"],
      humidity: json["relativeHumidity"] != null ? json["relativeHumidity"]["value"] : null,
      dewpoint: json["dewpoint"]?["value"],
      startTime: json["startTime"].isNotEmpty ? json["startTime"] : null,
      endTime: json["endTime"].isNotEmpty ? json["endTime"] : null,
    );
  }

  @override
  String toString(){
    return "name: ${name ?? "None"}\n"
          "isDaytime: ${isDaytime ? "Yes" : "No"}\n"
          "temperature: $temperature\n"
          "temperatureUnit: $temperatureUnit\n"
          "windSpeed: $windSpeed\n"
          "windDirection: $windDirection\n"
          "shortForecast: $shortForecast\n"
          "detailedForecast: $detailedForecast\n"
          "precipitationProbability: ${precipitationProbability ?? "None"}\n"
          "humidity: ${humidity ?? "None"}\n"
          "dewpoint: ${dewpoint ?? "None"}\n"
          "startTime: ${startTime ?? "None\n"}"
          "startTime: ${endTime ?? "None\n"}";
  }
}

Future<List<Forecast>> getForecastFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecast URL from the response json
  String forecastUrl = pointsJson["properties"]["forecast"];

  // make a request to the forecastJson url and decode the json data
  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  return processForecasts(forecastJson["properties"]["periods"]);
}

Future<List<Forecast>> getForecastHourlyFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecastHourly URL from the response json
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  // make a request to the forecastHourlyJson url and decode the json data
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);
  return processForecasts(forecastHourlyJson["properties"]["periods"]);
}

List<Forecast> processForecasts(List<dynamic> forecasts){
  List<Forecast> forecastObjs = [];
  for (dynamic forecast in forecasts){
    forecastObjs.add(Forecast.fromJson(forecast));
  }
  return forecastObjs;
}

Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}