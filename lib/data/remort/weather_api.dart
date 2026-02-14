
import 'package:dio/dio.dart';
import '../../utils/constants.dart';
import '../dto/weather_dto/weather_response.dart';

// ✅ Interface (Contract)
abstract class WeatherApiInterface {
  Future<WeatherResponse> getWeather(String city);
}

// ✅ Implementation
class WeatherApi implements WeatherApiInterface {
  final Dio _dio;

  WeatherApi(this._dio);

  @override
  Future<WeatherResponse> getWeather(String city) async {
    final response = await _dio.get(
      'data/2.5/weather',
      queryParameters: {
        'q': city,
        'appid': Constants.apiKey,
        'units': 'metric',
      },
    );
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