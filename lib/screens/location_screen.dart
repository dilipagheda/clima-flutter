import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherData weatherData;
  bool isLoading = false;

  void getData() async {
    var cityName = await Navigator.pushNamed(context, '/city');
    if (cityName == null || cityName.toString().length == 0) {
      showAlert(context, "City Name is not entered! Go back!", 500.toString());
      return;
    }
    setState(() {
      isLoading = true;
      this.weatherData.city = "?";
      this.weatherData.condition = 0;
      this.weatherData.temp = 0;
    });
    WeatherData weatherDataByCity = await FetchData.getDataByCity(cityName);
    setState(() {
      isLoading = false;
      this.weatherData.city = weatherDataByCity.city;
      this.weatherData.condition = weatherDataByCity.condition;
      this.weatherData.temp = weatherDataByCity.temp;
    });
    if (weatherDataByCity.code != 200) {
      showAlert(context, weatherDataByCity.message,
          weatherDataByCity.code.toString());
    }
  }

  showAlert(BuildContext context, String message, String code) {
    Alert(
      style: AlertStyle(
          titleStyle: TextStyle(
            color: Colors.white,
          ),
          descStyle: TextStyle(
            color: Colors.white,
          )),
      context: context,
      type: AlertType.error,
      title: code,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            getData();
          },
          width: 120,
        )
      ],
    ).show();
  }

  Widget renderSpinner() {
    if (isLoading) {
      return SpinKitRotatingPlain(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    weatherData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/');
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        getData();
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                renderSpinner(),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${weatherData.temp}°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        WeatherModel.getWeatherIcon(weatherData.condition),
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "${WeatherModel.getMessage(weatherData.temp)} in ${weatherData.city}!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
