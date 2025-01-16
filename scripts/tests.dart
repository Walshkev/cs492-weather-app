import './forecast.dart' as forecast;

Future<void> main() async {
  // testing with Bend, OR coordinates
  double lat = 44.05;
  double lon = -121.31;
  // TODO: Seach for latitutes and longitudes of 5 cities in the US on the internet

  Map<String, List<double>> cities = {
    'New York, NY': [40.713051, -74.0060],
    'Los Angeles, CA': [34.0522, -118.2437],
    'Chicago, IL': [41.8781, -87.6298],
    'Houston, TX': [29.7604, -95.3698],
    'Phoenix, AZ': [33.4484, -112.0740],
  };
  for (String city in cities.keys){
    List<double>? coords = cities[city];
    double lat = coords![0];
    double lon = coords[1];
    List<forecast.Forecast> forecasts = await forecast.getForecastFromPoints(lat, lon);
    List<forecast.Forecast> forecastsHourly = await forecast.getForecastHourlyFromPoints(lat,lon);
  }
  // Create a for loop that will generate forecasts arrays for each city
  // TODO: create forecasts and forecastsHourly both of type List<forecast.Forecast>
  forecast.getForecastFromPoints(lat, lon);
  forecast.getForecastHourlyFromPoints(lat,lon);
}