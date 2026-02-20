// lib/presentation/viewmodels/weather_viewmodel.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/domain/modal/Weather.dart';
import '../../domain/repository/weather_repository.dart';
import '../../di/network_module.dart';
import '../../utils/network_result.dart';
//import 'weather_state.dart';

class WeatherViewModel extends AsyncNotifier<Weather?> {

  late final WeatherRepository _repository;

  @override
  Future<Weather?> build() async {
    // ✅ Change: Repository yaha initialize
    _repository = ref.read(weatherRepositoryProvider);

    // Initial state → no weather yet
    return null;
  }

  Future<void> getWeather(String city) async {

    // ✅ Change: Manual isLoading remove
    // AsyncNotifier automatically handle karega
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {

      // ✅ Change: Direct Weather return ho raha
      return await _repository.getWeather(city);
    });
  }
}

final weatherViewModelProvider =
AsyncNotifierProvider<WeatherViewModel, Weather?>(
    WeatherViewModel.new);

//--------------------------------- using state menually -------------------------->

// class WeatherViewModel extends Notifier<WeatherState> {
//
//   late final WeatherRepository _repository;
//
//   @override
//   WeatherState build() {
//     _repository = ref.read(weatherRepositoryProvider);
//     return const WeatherState();
//   }
//
//   Future<void> getWeather(String city) async {
//
//     state = state.copyWith(
//       isLoading: true,
//       error: null,
//     );
//
//     final result = await _repository.getWeather(city);
//
//     switch (result) {
//
//       case Success(:final data):
//         state = state.copyWith(
//           isLoading: false,
//           weather: data,
//           error: null,
//         );
//
//       case Failure(:final message):
//         state = state.copyWith(
//           isLoading: false,
//           error: message,
//         );
//       case Loading<Weather>():
//         // TODO: Handle this case.
//         throw UnimplementedError();
//       case Idle<Weather>():
//         // TODO: Handle this case.
//         throw UnimplementedError();
//     }
//   }
// }
//
// // ✅ ViewModel Provider (Hilt ViewModel inject jesa)
// final weatherViewModelProvider =
// NotifierProvider<WeatherViewModel, WeatherState>(
//   WeatherViewModel.new,
// );


// // ✅ ViewModel (StateNotifier)
// class WeatherViewModel extends StateNotifier<WeatherState> {
//   final WeatherRepository _repository;
//
//   WeatherViewModel(this._repository) : super(WeatherState());
//
//   Future<void> getWeather(String city) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     final result = await _repository.getWeather(city);
//
//     if (result is Success) {
//       state = state.copyWith(isLoading: false, weather: result.data);
//     } else {
//       state = state.copyWith(isLoading: false, error: result.message);
//     }
//   }
// }
//
// // ✅ ViewModel Provider (Hilt ViewModel inject jesa)
// final weatherViewModelProvider =
// StateNotifierProvider<WeatherViewModel, WeatherState>((ref) {
//   return WeatherViewModel(ref.read(weatherRepositoryProvider));
// });
