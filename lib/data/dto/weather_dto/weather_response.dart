// lib/data/remote/dto/weather_response.dart

// Ye file API se aane wale JSON response ko Dart objects me convert karne ke liye hai

import 'package:json_annotation/json_annotation.dart';

import '../../../domain/modal/Weather.dart';

// Ye generated file hogi jo build_runner se generate hoti hai
// Isme fromJson aur toJson ka actual implementation hota hai
part 'weather_response.g.dart'; // ✅ Ye generate hogi

// Is class ke liye JSON convert karne ka code automatically generate karo.
@JsonSerializable()
class WeatherResponse {
  final CoordDto coord;
  final List<WeatherDetailDto> weather;
  final String base;
  final MainDto main;
  final int visibility;
  final WindDto wind;
  final CloudsDto clouds;
  final int dt;
  final SysDto sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  WeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  // Factory constructor jo JSON ko Dart object me convert karega
  // (cozz api se jo responce ata he vo json me ata he isliye)
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
  // Ye method generated file se call hota hai

  // Dart object ko JSON me convert karega
  // (cozz jab ham data server pe bhejte he to json me bhejte he) -->
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);

  // DTO (Data Transfer Object) / json ko Domain Model me convert karna
  // after that you can use this in your UI
  // (hame jitne object chhiye utne hi add karenge ham idhar isse unnesesury object use nahi honge)
  Weather toDomain() {
    return Weather(
      cityName: name,
      temperature: main.temp ?? 0.0,
      description: weather.isNotEmpty ? weather[0].description : "",
      icon: weather.isNotEmpty ? weather[0].icon : "",
    );
  }
}

@JsonSerializable()
class CoordDto {
  final double lon;
  final double lat;
  CoordDto({required this.lon, required this.lat});
  factory CoordDto.fromJson(Map<String, dynamic> json) => _$CoordDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CoordDtoToJson(this);
}

@JsonSerializable()
class WeatherDetailDto {
  final int id;
  final String main;
  final String description;
  final String icon;
  WeatherDetailDto({required this.id, required this.main, required this.description, required this.icon});
  factory WeatherDetailDto.fromJson(Map<String, dynamic> json) => _$WeatherDetailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDetailDtoToJson(this);
}

@JsonSerializable()
class MainDto {
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')   // ✅ Add this
  final double tempMin;
  @JsonKey(name: 'temp_max')   // ✅ Add this
  final double tempMax;
  final int pressure;
  final int humidity;

  MainDto({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory MainDto.fromJson(Map<String, dynamic> json) => _$MainDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MainDtoToJson(this);
}

@JsonSerializable()
class WindDto {
  final double speed;
  final int deg;
  WindDto({required this.speed, required this.deg});
  factory WindDto.fromJson(Map<String, dynamic> json) => _$WindDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WindDtoToJson(this);
}

@JsonSerializable()
class CloudsDto {
  final int all;
  CloudsDto({required this.all});
  factory CloudsDto.fromJson(Map<String, dynamic> json) => _$CloudsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CloudsDtoToJson(this);
}

@JsonSerializable()
class SysDto {
  final String country;
  final int sunrise;
  final int sunset;

  SysDto({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SysDto.fromJson(Map<String, dynamic> json) =>
      _$SysDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SysDtoToJson(this);
}

//------------------------------ Important Point ------------------------------->

// run this command after every changes - flutter pub run build_runner build --delete-conflicting-outputs

//------------------------------ Important Point ------------------------------->
