import 'package:flutter/material.dart';
import 'package:appnew/pages/LoginPage.dart';
import 'package:splash_view/splash_view.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashView(
      backgroundColor: Color.fromARGB(95, 175, 92, 187),
      logo: Lottie.network(
          'https://lottie.host/ad11468c-1682-4790-83b5-16f9200a422c/rWuLEGf6BE.json'),
      loadingIndicator: CircularProgressIndicator(),
      done: Done(LoginPage(),
          animationDuration: const Duration(milliseconds: 3000)),
    );
  }
}
