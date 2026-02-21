

import '../../domain/modal/Weather.dart';
import 'package:flutter/material.dart';

// Ye ek StatelessWidget hai
// Matlab ye widget apni koi internal state maintain nahi karta
// Sirf jo data milega usko display karega

class WeatherCard extends StatelessWidget {

  // Ye Weather object receive karega
  // final ka matlab value change nahi hogi
  final Weather weather;

  // Constructor
  // required ka matlab: Weather object dena hi padega
  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {

    // Card widget use kiya hai UI ko thoda elevated look dene ke liye
    return Card(

      // elevation shadow depth control karta hai
      elevation: 4,

      child: Padding(

        // Card ke andar 16px ka spacing diya hai
        padding: const EdgeInsets.all(16),

        child: Column(

          // Column sirf utni hi height lega jitni content ko chahiye
          mainAxisSize: MainAxisSize.min,

          children: [

            // 🔹 City Name show kar rahe hain
            Text(
              weather.cityName, // Weather model se city name

              style: const TextStyle(
                fontSize: 22, // thoda bada text
                fontWeight: FontWeight.bold, // bold text
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Temperature show kar rahe hain
            Text(
              "${weather.temperature} °C", // string interpolation use kiya

              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Weather description (e.g. Clear sky, Rainy)
            Text(
              weather.description,
            ),
          ],
        ),
      ),
    );
  }
}