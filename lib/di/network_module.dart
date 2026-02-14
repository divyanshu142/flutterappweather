
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/remort/weather_api.dart';
import '../data/repository/weather_repository_impl.dart';
import '../domain/repository/weather_repository.dart';
import '../utils/constants.dart';

// ✅ Dio Client Provider (Retrofit ka replacement)
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: Constants.baseUrl));
});

// ✅ Weather API Service Provider
final weatherApiProvider = Provider<WeatherApiInterface>((ref) {
  return WeatherApi(ref.read(dioProvider));
});

// ✅ Weather Repository Provider (Implementation)
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl(ref.read(weatherApiProvider));
});
