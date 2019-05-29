import 'package:clima/utilities/api_key.dart';
import 'package:clima/utilities/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class FetchData {
  static Future<WeatherData> getData(Position position) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$API_KEY&units=imperial';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return WeatherData(
          condition: jsonResponse['weather'][0]['id'],
          temp: (jsonResponse['main']['temp'] as double).round(),
          city: jsonResponse['name']);
    } else {
      print("Request failed with status: ${response.statusCode}.");
      return null;
    }
  }
}
