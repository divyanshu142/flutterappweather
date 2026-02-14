
// lib/domain/models/weather.dart
class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon; // Icon ID for images

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });
}