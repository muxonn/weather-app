class WeatherHour {
  String? time;
  double? temperatureCelcius;
  double? temperatureFahrenheit;
  String? conditionText;

  WeatherHour({
    this.time,
    this.temperatureCelcius,
    this.temperatureFahrenheit,
    this.conditionText,
  });

  WeatherHour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    temperatureCelcius = json['temp_c']?.toDouble();
    temperatureFahrenheit = json['temp_f']?.toDouble();
    conditionText = json['condition']['text'];
  }
}
