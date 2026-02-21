// lib/presentation/viewmodels/weather_viewmodel.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/domain/modal/Weather.dart';
import '../../domain/repository/weather_repository.dart';
import '../../di/network_module.dart';
import '../../utils/network_result.dart';

// 🔹 WeatherViewModel ek AsyncNotifier hai
// AsyncNotifier automatically loading, data aur error state handle karta hai
// <Weather?> ka matlab state me Weather object ya null ho sakta hai

class WeatherViewModel extends AsyncNotifier<Weather?> {

  // 🔹 Repository ka reference
  // late final ka matlab:
  // - variable baad me initialize hoga
  // - sirf ek baar assign hoga
  // - null nahi hoga

  late final WeatherRepository _repository;

  // 🔹 build() AsyncNotifier ka mandatory method hai
  // Provider jab first time create hota hai
  // tab ye method automatically call hota hai

  @override
  Future<Weather?> build() async {

    // 🔹 ref Riverpod ka reference object hai
    // Yaha hum repository provider se repository le rahe hain
    // read() ka matlab:
    // - ek baar value lo
    // - reactive nahi (changes pe rebuild nahi hoga)

    _repository = ref.read(weatherRepositoryProvider);

    // 🔹 Initial state set kar rahe hain
    // Abhi koi weather data nahi hai
    // Isliye null return kar rahe hain

    // AsyncNotifier internally:
    // 1️⃣ build start hote hi → state = AsyncLoading()
    // 2️⃣ build complete hote hi → state = AsyncData(returnedValue)
    // Yaha returnedValue = null
    // To state banegi → AsyncData(null)

    return null;
  }

  // 🔹 Ye method UI se call hoga
  // Jab user city search karega

  Future<void> getWeather(String city) async {

    // 🔹 Loading state manually set kar rahe hain
    // UI me CircularProgressIndicator show hoga

    state = const AsyncLoading();

    // 🔹 AsyncValue.guard kya karta hai?
    // - try-catch automatically handle karta hai
    // - Success → AsyncData me convert karta hai
    // - Error → AsyncError me convert karta hai

    state = await AsyncValue.guard(() async {

      // 🔹 Repository se API call ho rahi hai
      // Agar success → Weather object return hoga
      // Agar error → exception throw hoga

      return await _repository.getWeather(city);
    });
  }
}

// 🔹 Ye Riverpod provider hai
// AsyncNotifierProvider ka kaam:
// - WeatherViewModel ko create karna
// - uski state manage karna
// - UI ko state provide karna

// <WeatherViewModel, Weather?> ka matlab:
// - WeatherViewModel = logic class
// - Weather? = state ka type

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
