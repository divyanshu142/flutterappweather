
import '../../utils/network_result.dart'; // Sealed class
import '../modal/Weather.dart';

abstract class WeatherRepository {
  Future<NetworkResult<Weather>> getWeather(String city);
}
