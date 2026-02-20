
// lib/domain/models/weather.dart

// Ye Weather naam ki ek class hai
// Iska use weather ka data store karne ke liye hota hai

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon; // Icon ID for images

  // Ye class ka constructor hai
  // "required" ka matlab hai object banate time ye values deni hi padegi

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });
}