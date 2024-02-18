class CurrentWeather {
  CurrentWeather({
    this.locationName,
    this.country,
    this.temperatureCelcius,
    this.temperatureFahrenheit,
    this.conditionText,
    this.conditionIcon,
  });

  String? locationName;
  String? country;
  double? temperatureCelcius;
  double? temperatureFahrenheit;
  String? conditionText;
  String? conditionIcon;
  String? windDirection;
  double? windKph;
  int? cloudiness;
  int? humidity;

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    locationName = json['location']['name'];
    country = json['location']['country'];
    temperatureCelcius = json['current']['temp_c'];
    temperatureFahrenheit = json['current']['temp_f'];
    conditionText = json['current']['condition']['text'];
    conditionIcon = json['current']['condition']['icon'];
    windDirection = json['current']['wind_dir'];
    windKph = json['current']['wind_kph'];
    cloudiness = json['current']['cloud'];
    humidity = json['current']['humidity'];
  }
}
