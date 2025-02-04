import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weatherapp/scripts/time.dart';

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
  final DateTime startTime;
  final DateTime endTime;
  final String? tempHighLow;

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
    required this.endTime,
    required this.tempHighLow,
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
      startTime: DateTime.parse(json["startTime"]).toLocal(),
      endTime: DateTime.parse(json["endTime"]).toLocal(),
      tempHighLow: null
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
          "startTime: ${startTime.toLocal()}\n"
          "endTime: ${endTime.toLocal()}\n"
          "tempHighLow: ${tempHighLow ?? "None"}";
  }

   String getIconPath() {
    const Map<String, String> weatherIcons = {
      "Mostly Cloudy": "assets/weather_icons/mostly_cloudy.svg",
      "Slight Chance Light Snow": "assets/weather_icons/snow_showers.svg",
      "Chance Light Snow": "assets/weather_icons/flurries.svg",
      "Partly Cloudy": "assets/weather_icons/partly_cloudy.svg",
      "Mostly Sunny": "assets/weather_icons/mostly_sunny.svg",
      "Sunny": "assets/weather_icons/sunny.svg",
      "Mostly Clear": "assets/weather_icons/mostly_clear.svg",
      "Heavy Snow Likely": "assets/weather_icons/heavy_snow.svg",
      "Heavy Snow": "assets/weather_icons/heavy_snow.svg",
      "Partly Sunny": "assets/weather_icons/sunny.svg",
      "Light Snow Likely": "assets/weather_icons/flurries.svg",
      "Snow": "assets/weather_icons/snow_showers.svg",
      "Slight Chance Light Rain": "assets/weather_icons/droplet_light.svg",
      "Chance Light Rain": "assets/weather_icons/droplet_light.svg",
      "Light Rain": "assets/weather_icons/droplet_drizzle.svg",
      "Light Snow": "assets/weather_icons/flurries.svg",
      "Snow Likely": "assets/weather_icons/snow_showers.svg",
      "Patchy Blowing Dust": "assets/weather_icons/dust.svg",
      "Slight Chance Rain And Snow": "assets/weather_icons/wintry_mix.svg",

      "Rain And Snow Likely": "assets/weather_icons/wintry_mix.svg",
      "Light Rain Likely": "assets/weather_icons/droplet_light.svg",
      "Rain And Snow": "assets/weather_icons/wintry_mix.svg",
      "Cloudy": "assets/weather_icons/cloudy.svg",
      "Slight Chance Freezing Drizzle": "assets/weather_icons/droplet_light.svg",
      "Patchy Fog": "assets/weather_icons/fog.svg",
      "Areas Of Fog": "assets/weather_icons/fog.svg",
      "Slight Chance Rain Showers": "assets/weather_icons/droplet_light.svg",
      "Chance Rain Showers": "assets/weather_icons/droplet_light.svg",
      "Chance Showers And Thunderstorms": "assets/weather_icons/thunder.svg",
      "Showers And Thunderstorms Likely": "assets/weather_icons/strong_tstorms.svg",

      "Rain Showers": "assets/weather_icons/droplet_light.svg",
      "Rain Showers Likely": "assets/weather_icons/droplet_light.svg",
      "Slight Chance Showers And Thunderstorms": "assets/weather_icons/thunder.svg",
      "Patchy Blowing Snow": "assets/weather_icons/blizzard.svg",
      "Slight Chance Snow Showers": "assets/weather_icons/snow_showers.svg",
      "Clear": "assets/weather_icons/sunny.svg",
      "Chance Rain And Snow Showers": "assets/weather_icons/wintry_mix.svg",
      "Heavy Snow And Patchy Blowing Snow": "assets/weather_icons/heavy_snow.svg",
      "Snow And Patchy Blowing Snow": "assets/weather_icons/snow_showers.svg",
      "Chance Sleet": "assets/weather_icons/sleet_hail.svg",
      "Chance Freezing Rain": "assets/weather_icons/sleet_hail.svg",
      "Freezing Rain": "assets/weather_icons/sleet_hail.svg",
      "Chance Snow Showers": "assets/weather_icons/snow_showers.svg",
      "Freezing Rain Likely": "assets/weather_icons/sleet_hail.svg",
      "Slight Chance Drizzle": "assets/weather_icons/droplet_light.svg",
      "Chance Freezing Drizzle": "assets/weather_icons/sleet_hail.svg",
      "Freezing Drizzle Likely": "assets/weather_icons/sleet_hail.svg",
      "Rain": "assets/weather_icons/droplet_heavy.svg",
      "Chance of light snow": "assets/weather_icons/snow_showers.svg",
    };

   
    // TODO: Keep adding to this logic to try to get rid of question marks
    // TODO: change the location in your android phone to at least 5 different location
    // with different climates so you can eliminate more question marks

    return weatherIcons[shortForecast] ?? "assets/weather_icons/question.svg";
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


Forecast getForecastDaily(Forecast forecast1, Forecast forecast2){
  String tempHighLow = getTempHighLow(forecast1.temperature, forecast2.temperature, forecast1.temperatureUnit);

  return Forecast(
    name: equalDates(DateTime.now(), forecast1.startTime) ? "Today" : forecast1.name, 
    isDaytime: forecast1.isDaytime, 
    temperature: forecast1.temperature, 
    temperatureUnit: forecast1.temperatureUnit, 
    windSpeed: forecast1.windSpeed, 
    windDirection: forecast1.windDirection, 
    shortForecast: forecast1.shortForecast, 
    detailedForecast: forecast1.detailedForecast, 
    precipitationProbability: forecast1.precipitationProbability, 
    humidity: forecast1.humidity, 
    dewpoint: forecast1.dewpoint, 
    startTime: forecast1.startTime, 
    endTime: forecast2.endTime, 
    tempHighLow: tempHighLow);

}

String getTempHighLow(int temp1, int temp2, String tempUnit){
  if (temp1 < temp2){
    return "$temp1°$tempUnit/$temp2°$tempUnit";
  }
  else {
    return "$temp2°$tempUnit/$temp1°$tempUnit";
  }

}