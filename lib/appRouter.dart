
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/presentation/screens/SplashScreen.dart';
import 'package:weatherapp/presentation/screens/weather_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: '/Home',
      builder: (context, state) => const WeatherScreen(),
    ),

  ],
);
