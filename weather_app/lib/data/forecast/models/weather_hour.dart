class WeatherHour {
  String? time;
  double? temperatureCelcius;
  double? temperatureFahrenheit;
  String? conditionText;
  String? conditionIcon;
  String? locationName;

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
    if (conditionText == "Patchy rain nearby") conditionText = "Patchy rain";
    if (conditionText == "Moderate or heavy rain in area with thunder")
      conditionText = "Heavy rain";
    conditionIcon = json['condition']['icon'];
  }
}
