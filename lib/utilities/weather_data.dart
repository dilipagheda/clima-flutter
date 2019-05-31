class WeatherData {
  int condition;
  int _temp;
  String city;
  int code;
  String message;

  set temp(int value) {
    double v = (9 / 5) * value + 32;
    _temp = v.round();
  }

  int get temp {
    double v = (_temp - 32) * (5 / 9);
    print("temp:" + _temp.toString() + " " + v.toString());
    return v.round();
  }

  WeatherData({int condition, int temp, String city, int code, String message})
      : this.condition = condition,
        this._temp = temp,
        this.city = city,
        this.code = code,
        this.message = message;
}
