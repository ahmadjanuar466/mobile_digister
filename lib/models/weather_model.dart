class Weather {
  String? cityName;
  final String temperature;
  final String condition;

  Weather({
    this.cityName,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      temperature: data['current']['temp_c'].round().toString(),
      condition: data['current']['condition']['text'],
    );
  }
}
