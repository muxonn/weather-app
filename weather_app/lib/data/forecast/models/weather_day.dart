class WeatherDay {
  WeatherDay({
    this.maxTemperatureC,
    this.minTemperatureC,
    this.maxWindKph,
    this.avgHumidity,
  });

  double? maxTemperatureC;
  double? minTemperatureC;
  double? maxWindKph;
  double? avgHumidity;

  WeatherDay.fromJson(Map<String, dynamic> json) {
    maxTemperatureC = json["maxtemp_c"]?.toDouble();
    minTemperatureC = json["mintemp_c"]?.toDouble();
    maxWindKph = json["maxwind_kph"]?.toDouble();
    avgHumidity = json["avghumidity"]?.toDouble();
  }
}
