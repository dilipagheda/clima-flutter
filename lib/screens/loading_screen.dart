import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherData weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getLocationAndData();
  }

  void getLocationAndData() async {
    //Get the current location
    Position position = await Location.getLocation();
    WeatherData weatherData = await FetchData.getData(position);
    setState(() {
      isLoading = false;
    });
    Navigator.pushNamed(context, '/location', arguments: weatherData);
  }

  Widget renderSpinner() {
    return SpinKitRotatingPlain(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? renderSpinner()
            : Container(
                height: 0,
                width: 0,
              ),
      ),
    );
  }
}
