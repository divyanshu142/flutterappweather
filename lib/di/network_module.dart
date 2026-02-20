
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/remort/weather_api.dart';
import '../data/repository/weather_repository_impl.dart';
import '../domain/repository/weather_repository.dart';
import '../utils/constants.dart';

// ✅ Dio Client Provider (Retrofit ka replacement)
// Riverpod ka Provider use kar rahe hain
// Ye provider ek single Dio instance create karta hai
// Dio ek HTTP client hai jo API calls karne ke liye use hota hai
// Provider<Dio> ka matlab hai ye provider Dio object return karega

// BaseOptions me hum baseUrl set kar rahe hain
// Iska matlab ab har API call me full URL nahi likhna padega
// Example: agar baseUrl = https://api.weather.com
// To sirf "/forecast" likhne se complete URL ban jayega

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: Constants.baseUrl));
});

// ✅ Weather API Service Provider
// Ye provider WeatherApiInterface ka implementation return karega
// Yaha hum WeatherApi class use kar rahe hain
// WeatherApi constructor me Dio pass karna padta hai

// ref.read(dioProvider)
// Yaha hum Dio instance le rahe hain jo upar define kiya tha
// read() ka matlab hai ek baar value lo (reactive nahi hai)

// WeatherApi ko Dio pass kar rahe hain
// Ab WeatherApi Dio ka use karke actual API call karega

final weatherApiProvider = Provider<WeatherApiInterface>((ref) {
  return WeatherApi(ref.read(dioProvider));
});

// ✅ Weather Repository Provider
// Repository ka kaam hota hai API layer aur UI/ViewModel ke beech bridge banana
// Yaha hum WeatherRepository interface ka implementation return kar rahe hain

// ref.read(weatherApiProvider)
// Yaha hum WeatherApi ka instance le rahe hain
// Ye wahi API service hai jo upar provider me banayi thi

// WeatherRepositoryImpl ko WeatherApi pass kar rahe hain
// Ab repository API ko call karega aur data process karega
// UI directly API ko call nahi karegi (Clean Architecture follow ho raha hai)


final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl(ref.read(weatherApiProvider));
});























