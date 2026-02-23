
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/modal/Weather.dart';
import '../../domain/repository/weather_repository.dart';
import '../../utils/network_result.dart';
import '../remort/weather_api.dart';

// Ye class WeatherRepository interface ko implement kar rahi hai
// Repository ka kaam hota hai data source (API, DB) aur ViewModel ke beech bridge ka kaam karna

class WeatherRepositoryImpl implements WeatherRepository {

  // Ye private variable hai (_ se start ho raha hai)
  // Isme WeatherApiInterface ka object store hoga
  // Iska use API call karne ke liye hoga

  final WeatherApiInterface _weatherApi;

  // Constructor
  // Yaha Dependency Injection use ho rahi hai
  // Jab repository create hogi tab WeatherApi ka instance pass kiya jayega

  WeatherRepositoryImpl(this._weatherApi);

  // Future<Weather> ka matlab:
  // Ye function immediately Weather return nahi karega
  // Ye ek Future return karega jo future me Weather object dega
  // (kyunki API call time leti hai - async operation)

  @override
  Future<Weather> getWeather(String city) async {

    try {

      // Yaha API call ho rahi hai
      // city parameter pass kar rahe hain
      // Ye async call hai isliye await use ho raha hai

      final response = await _weatherApi.getWeather(city);

      // API se jo response mila hai wo Data Model me hoga
      // toDomain() function usko Domain Model me convert karta hai
      // Repository ka kaam sirf clean Weather object return karna hai

      return response.toDomain();

    } on DioException catch (e) {

      // Agar network error aata hai (jaise no internet, timeout, 404 etc)
      // Pehle hum Failure object return karte the
      // Ab hum direct exception throw kar rahe hain
      // Ye exception upar ViewModel ya AsyncNotifier handle karega

      throw Exception(e.message ?? "Network error occurred");

    } catch (e) {

      // Agar koi aur unexpected error aaye
      // (jaise parsing error, null error etc)
      // To generic exception throw kar rahe hain

      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}

//--------------------------------- using network class ------------------------->

// WeatherRepositoryImpl class
// Ye class WeatherRepository interface ko implement karti hai
// Matlab jo methods WeatherRepository me defined hain,
// unka actual implementation yaha likha jayega

// class WeatherRepositoryImpl implements WeatherRepository {
//
//   // Ye private variable hai (_ se start ho raha hai)
//   // Isme hum WeatherApiInterface ka object store karenge
//   // Ye API layer se data fetch karne ke liye use hoga
//
//   final WeatherApiInterface _weatherApi;
//
//   // Constructor
//   // Dependency Injection use ho rahi hai
//   // Jab ye class create hogi, tab WeatherApi ka instance pass hoga
//
//   WeatherRepositoryImpl(this._weatherApi);
//
//   // Ye method WeatherRepository interface ka override hai
//   // Ye city ka naam lega aur weather data return karega
//
//   @override
//   Future<NetworkResult<Weather>> getWeather(String city) async {
//
//     try {
//
//       // API call ho rahi hai
//       // _weatherApi.getWeather(city) actual network request karega
//
//       final response = await _weatherApi.getWeather(city);
//
//       // response ko domain model me convert kar rahe hain
//       // Usually API model aur app ka domain model alag hota hai
//       // toDomain() mapper ka kaam karta hai
//
//       final weather = response.toDomain();
//
//       // Agar sab successful raha
//       // To Success object return kar rahe hain
//
//       return Success(weather);
//
//     }
//
//     // Agar network related error aaye (Dio se)
//
//     on DioException catch (e) {
//
//       // Error message ke sath Failure return kar rahe hain
//       // Agar message null ho to default message use karenge
//
//       return Failure(e.message ?? "Network error occurred");
//
//     }
//
//     // Agar koi unexpected error aaye
//
//     catch (e) {
//
//       // Generic failure return kar rahe hain
//
//       return Failure("Unexpected error: ${e.toString()}");
//     }
//   }
// }

//---------------------------- normaly hande error ----------------------->

// class WeatherRepositoryImpl implements WeatherRepository {
//
//   final WeatherApiInterface _weatherApi;
//   WeatherRepositoryImpl(this._weatherApi);
//
//   // final WeatherApiInterface _weatherApi;
//   //
//   // WeatherRepositoryImpl(this._weatherApi);
//
//   @override
//   Future<NetworkResult<Weather>> getWeather(String city) async {
//     try {
//       final response = await _weatherApi.getWeather(city);
//       // Mapper: DTO to Domain Entity
//       return Success(response.toDomain());
//     } catch (e) {
//       return Error(e.toString());
//     }
//   }
// }

