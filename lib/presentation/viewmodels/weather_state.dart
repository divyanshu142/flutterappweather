
// lib/presentation/viewmodels/weather_state.dart
import '../../domain/modal/Weather.dart';

class WeatherState {

  final bool isLoading;
  final Weather? weather;
  final String? error;

  const WeatherState({
    this.isLoading = false,
    this.weather,
    this.error,
  });

  WeatherState copyWith({
    bool? isLoading,
    Weather? weather,
    String? error,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      weather: weather ?? this.weather,
      error: error,
    );
  }
}

// class WeatherState {
//   final bool isLoading;
//   final Weather? weather;
//   final String? error;
//
//   WeatherState({
//     this.isLoading = false,
//     this.weather,
//     this.error,
//   });
//
//   // Helper method to copy state with changes
//   WeatherState copyWith({
//     bool? isLoading,
//     Weather? weather,
//     String? error,
//   }) {
//     return WeatherState(
//       isLoading: isLoading ?? this.isLoading,
//       weather: weather ?? this.weather,
//       error: error ?? this.error,
//     );
//   }
// }

