
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/WeatherCard.dart';

// Ye screen ConsumerStatefulWidget hai
// Iska matlab:
// 1. Ye StatefulWidget hai (state maintain kar sakta hai)
// 2. Riverpod ka ref use kar sakta hai (providers access karne ke liye)

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

// Ye actual state class hai
// ConsumerState ka matlab: yaha ref available hoga

class _WeatherScreenState extends ConsumerState<WeatherScreen> {

  // TextField ka controller
  // Isse hum user ka input read kar sakte hain

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // Yaha hum provider ko watch kar rahe hain
    // watch() ka matlab:
    // - Jab bhi state change hoga
    // - Ye widget automatically rebuild hoga

    // ✅ Change: AsyncValue watch kar rahe
    final weatherState = ref.watch(weatherViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: "Enter City",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final city = _cityController.text.trim();

                  if (city.isNotEmpty) {

                    // Yaha read() use kar rahe hain
                    // Kyunki hume rebuild nahi chahiye
                    // Hume sirf function call karna hai

                    ref
                        .read(weatherViewModelProvider.notifier)
                        .getWeather(city);
                  }
                },
                child: const Text("Get Weather"),
              ),
            ),

            const SizedBox(height: 30),

            // 🔥 Yaha main magic ho raha hai
            // weatherState ek AsyncValue<Weather?> hai

            Expanded(
              child: weatherState.when(

                loading: () =>
                const Center(child: CircularProgressIndicator()),

                error: (error, stackTrace) =>
                    Center(
                      child: Text(
                        error.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                data: (weather) {

                  // Initial state me build() null return karta hai
                  // Isliye first time weather null hoga

                  if (weather == null) {
                    return const Center(
                      child: Text("Search a city"),
                    );
                  }

                  // Agar weather available hai
                  // To custom WeatherCard widget show karenge

                  return WeatherCard(weather: weather);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------using state using nework class ---------------------------->

// class WeatherScreen extends ConsumerStatefulWidget {
//   const WeatherScreen({super.key});
//
//   @override
//   ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends ConsumerState<WeatherScreen> {
//
//   final TextEditingController _cityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     final state = ref.watch(weatherViewModelProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Weather App"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             // 🔹 City Input
//             TextField(
//               controller: _cityController,
//               decoration: const InputDecoration(
//                 labelText: "Enter City",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // 🔹 Search Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   final city = _cityController.text.trim();
//
//                   if (city.isNotEmpty) {
//                     ref
//                         .read(weatherViewModelProvider.notifier)
//                         .getWeather(city);
//                   }
//                 },
//                 child: const Text("Get Weather"),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // 🔹 State Handling
//             if (state.isLoading)
//               const CircularProgressIndicator(),
//
//             if (!state.isLoading && state.error != null)
//               Text(
//                 "Error: ${state.error}",
//                 style: const TextStyle(color: Colors.red),
//               ),
//
//             if (!state.isLoading && state.weather != null)
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Text(
//                         state.weather!.cityName,
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "${state.weather!.temperature} °C",
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(state.weather!.description),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
