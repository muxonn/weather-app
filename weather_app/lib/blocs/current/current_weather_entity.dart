class CurrentWeatherEntity {
  final locationName;
  String? country;
  double? temperatureCelcius;
  double? temperatureFahrenheit;
  String? conditionText;
  String? conditionIcon;

  CurrentWeatherEntity({required this.locationName});
}
