
import '../../utils/network_result.dart'; // Sealed class
import '../modal/Weather.dart';

// Ye ek abstract class hai
// Abstract class ka matlab hai iska direct object nahi ban sakta
// Isko dusri class implement karegi

abstract class WeatherRepository {

  // Ye ek function declare kiya gaya hai
  // Future ka matlab ye async function hai (data baad me milega)
  // NetworkResult<Weather> ka matlab function weather data return karega
  // getWeather city ka naam lega aur us city ka weather fetch karega

  Future<Weather>getWeather(String city);
}
