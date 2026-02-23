
// StatefulWidget because animation needs mutable state
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'weather_screen.dart'; // apni file ka path

// SplashScreen ek StatefulWidget hai
// Kyunki hume animation chalani hai (state change hota rahega)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// State class me SingleTickerProviderStateMixin use kiya
// Ye hume vsync provide karta hai (animation ke liye required)

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  // AnimationController animation ko control karega
  late AnimationController _controller;

  // Fade animation ke liye double type animation
  late Animation<double> _fadeAnimation;

  // Scale animation ke liye double type animation
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 🔥 AnimationController initialize kiya
    // vsync: this → Ticker provide karega
    // duration: 2 second me animation complete hogi

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // 🔹 Fade animation (opacity 0 se 1 tak)
    // Yani invisible se visible hoga
    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(_controller);

    // 🔹 Scale animation (size 0.5 se 1 tak)
    // Yani thoda chhota start hoga fir normal size me aayega
    // Curves.easeOutBack smooth effect deta hai

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    // Animation start kar di
    _controller.forward();

    // ⏳ 2 second baad next screen pe navigate karenge
    // pushReplacement ki jagah go_router ka context.go use kiya

    Future.delayed(const Duration(seconds: 2), () {

      // '/home' route pe navigate
      // Ye purani screen remove kar deta hai (back nahi ja sakte)

      context.go('/home');
    });
  }

  @override
  void dispose() {
    // Memory leak avoid karne ke liye
    // AnimationController ko dispose karna zaruri hai

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Scaffold main structure provide karta hai

    return Scaffold(
      backgroundColor: Colors.blueAccent,

      body: Center(
        child: FadeTransition(

          // Fade animation apply ki
          opacity: _fadeAnimation,

          child: ScaleTransition(

            // Scale animation apply ki
            scale: _scaleAnimation,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [

                // Cloud icon show ho raha hai
                Icon(
                  Icons.cloud,
                  size: 100,
                  color: Colors.white,
                ),

                SizedBox(height: 20),

                // App name show ho raha hai
                Text(
                  "Weather App",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------ without comment ---------------------------->

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // 🔥 AnimationController
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     // 🔹 Fade animation (0 → 1)
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//
//     // 🔹 Scale animation (0.5 → 1)
//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
//     );
//
//     _controller.forward();
//
//     // ⏳ 3 second baad next screen
//     Future.delayed(const Duration(seconds: 2), () {
//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (_) => const WeatherScreen(),
//       //   ),
//       // );
//       context.go('/home');
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Icon(
//                   Icons.cloud,
//                   size: 100,
//                   color: Colors.white,
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Weather App",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
