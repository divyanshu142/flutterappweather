
import 'package:flutter/material.dart';
import 'package:weatherapp/presentation/screens/SplashScreen.dart';
import 'appRouter.dart';
import 'presentation/screens/weather_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
        routerConfig: appRouter // 🔥 Yaha router pass kiya
    );
  }
}

// SplashScreen(),
// WeatherScreen(),
// appRouter(),
//home: const appRouter,























