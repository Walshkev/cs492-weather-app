import 'forecast.dart' as forecast;
import 'location.dart' as location;

// void main() async {
//   testForecast();
// }

void testLocation() async {
  List locationList = [];
  // TODO: Create a list of Map<String, String>
  // Add several (at least 5) city, state, zip Map<String, String> to the list
  // iterate through the list, calling location.getLocationFromAddress function for each iteration
  // passing in the city, state, and zip.
  // Debug with a breakpoint after the return (you can use a placeholder like print("test") for your breakpoint)
  // Check to ensure each location returns as expected through debugging. 

  List<Map<String, String>> addresses = [
    {"city": "New York", "state": "NY", "zip": "10001"},
    {"city": "Los Angeles", "state": "CA", "zip": "90001"},
    {"city": "Chicago", "state": "IL", "zip": "60601"},
    {"city": "Houston", "state": "TX", "zip": "77001"},
    {"city": "Phoenix", "state": "AZ", "zip": "85001"}
  ];

  for (Map<String, String> address in addresses){
    var info = await location.getLocationFromAddress(address["city"]!, address["state"]!, address["zip"]!);
    locationList.add(info);
  }
  print(locationList);
  return;

}


void testForecast() async {
// testing with Bend, OR coordinates
  // double lat = 44.05;
  // double lon = -121.31;
  List<List<double>> coords = [
    [44.05, -121.31],
    [40.71, -74.006],
    [41.878, -87.629],
    [25.7617, -80.1918],
    [35.0844, -106.65]
  ];

  for (List<double> coord in coords){
    List<forecast.Forecast> forecasts = await forecast.getForecastFromPoints(coord[0], coord[1]);
    List<forecast.Forecast> forecastsHourly = await forecast.getForecastHourlyFromPoints(coord[0],coord[1]);
  }
}