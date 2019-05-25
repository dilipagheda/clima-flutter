import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherData weatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationAndData();
  }

  void getLocationAndData() async {
    //Get the current location
    Position position = await Location.getLocation();
    WeatherData weatherData = await FetchData.getData(position);
    setState(() {
      this.weatherData = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocationAndData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
