class WeatherData {
  int condition;
  int _temp;
  String city;

  int get temp {
    double v = (_temp - 32) * (5 / 9);
    return v.round();
  }

  WeatherData({int condition, int temp, String city})
      : this.condition = condition,
        this._temp = temp,
        this.city = city;
}
