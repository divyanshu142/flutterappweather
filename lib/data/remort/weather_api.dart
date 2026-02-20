
import 'package:dio/dio.dart';
import '../../utils/constants.dart';
import '../dto/weather_dto/weather_response.dart';

// Ye ek abstract class hai jo API ka contract define karti hai
// Iska matlab: koi bhi class jo WeatherApiInterface implement karegi
// usko getWeather method define karna hi padega

// ✅ Interface (Contract)
abstract class WeatherApiInterface {

  // Ye method future return karega kyunki API call asynchronous hoti hai
  // WeatherResponse return karega (DTO object)
  // Parameter me city name lega
  Future<WeatherResponse> getWeather(String city);
}

// ✅ Implementation Class
// Ye actual implementation hai jo Dio use karke API call karega

class WeatherApi implements WeatherApiInterface {

  // Dio ek HTTP client hai jo network calls ke liye use hota hai
  final Dio _dio;

  // Constructor injection (Dependency Injection)
  // Bahar se Dio pass kiya ja raha hai
  // Isse testing easy hoti hai (mock Dio use kar sakte ho)
  WeatherApi(this._dio);

  // Ye override keyword batata hai ki
  // hum interface ka method implement kar rahe hain
  @override
  Future<WeatherResponse> getWeather(String city) async {

    // _dio.get() HTTP GET request bhejta hai
    // Ye async hai isliye await use kar rahe hain
    final response = await _dio.get(
      'data/2.5/weather',
      queryParameters: {
        'q': city,
        'appid': Constants.apiKey,
        'units': 'metric',
      },
    );

    // response.data me JSON data milta hai
    // Usko WeatherResponse DTO me convert kar rahe hain
    return WeatherResponse.fromJson(response.data);
  }
}

// ----------------------- without interface ---------------------->

// class WeatherApi {
//   final Dio _dio;
//
//   WeatherApi(this._dio);
//
//   Future<WeatherResponse> getWeather(String city) async {
//     final response = await _dio.get(
//       'data/2.5/weather',
//       queryParameters: {
//         'q': city,
//         'appid': Constants.apiKey,
//         'units': 'metric',
//       },
//     );
//     // JSON to DTO Mapping (using the generated code)
//     return WeatherResponse.fromJson(response.data);
//   }
// }