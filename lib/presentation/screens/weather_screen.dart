
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/weather_viewmodel.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(weatherViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔹 City Input
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: "Enter City",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final city = _cityController.text.trim();

                  if (city.isNotEmpty) {
                    ref
                        .read(weatherViewModelProvider.notifier)
                        .getWeather(city);
                  }
                },
                child: const Text("Get Weather"),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 State Handling
            if (state.isLoading)
              const CircularProgressIndicator(),

            if (!state.isLoading && state.error != null)
              Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.red),
              ),

            if (!state.isLoading && state.weather != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        state.weather!.cityName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${state.weather!.temperature} °C",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(state.weather!.description),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
