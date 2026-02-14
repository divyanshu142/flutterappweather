
import 'package:dio/dio.dart';

import '../../domain/modal/Weather.dart';
import '../../domain/repository/weather_repository.dart';
import '../../utils/network_result.dart';
import '../remort/weather_api.dart';

class WeatherRepositoryImpl implements WeatherRepository {

  final WeatherApiInterface _weatherApi;

  WeatherRepositoryImpl(this._weatherApi);

  @override
  Future<NetworkResult<Weather>> getWeather(String city) async {
    try {
      final response = await _weatherApi.getWeather(city);
      final weather = response.toDomain();
      return Success(weather);

    } on DioException catch (e) {
      return Failure(e.message ?? "Network error occurred");

    } catch (e) {
      return Failure("Unexpected error: ${e.toString()}");
    }
  }
}

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

