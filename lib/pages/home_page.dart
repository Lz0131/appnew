import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:appnew/database/model_recetas.dart';
import 'package:appnew/database/recetas_data.dart';
import 'package:appnew/pages/dashboard_screen.dart';
import 'package:appnew/pages/mostrar_receta.dart';
import 'package:appnew/settings/app_value_notifier.dart';
import 'package:appnew/settings/theme.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  final Receta? carruselImages;
  final ValueNotifier<bool> themeNotifier;

  const HomePage({
    Key? key,
    this.carruselImages,
    required this.themeNotifier,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  // control
  late final AnimationController _controller;
  late Color _startColor; // Color inicial
  late Color _endColor; // Color final

  @override
  void initState() {
    super.initState();

    _startColor =
        ThemeApp.startColorForTheme(AppValueNotifier.themeNotifier.value);
    _endColor = ThemeApp.endColorForTheme(AppValueNotifier.themeNotifier.value);

    AppValueNotifier.themeNotifier.addListener(_handleThemeChange);
    _startColorTransition();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    AppValueNotifier.themeNotifier.removeListener(_handleThemeChange);
    _timer.cancel();
    _controller.dispose();
  }

  void _handleThemeChange() {
    setState(() {
      _startColor =
          ThemeApp.startColorForTheme(AppValueNotifier.themeNotifier.value);
      _endColor =
          ThemeApp.endColorForTheme(AppValueNotifier.themeNotifier.value);
    });
  }

  bool bookmarked = false;

  Duration _duration = Duration(seconds: 5); // Duración de la transición
  late Timer _timer; // Timer para la transición de color

  void _startColorTransition() {
    // Inicia un timer para la transición de colores
    _timer = Timer.periodic(_duration, (_) {
      // Intercambia los colores al finalizar la transición
      setState(() {
        Color temp = _startColor;
        _startColor = _endColor;
        _endColor = temp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DashboardScreen(),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Recetario"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_startColor, _endColor],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CarouselSlider.builder(
              itemCount: carruselImages.length,
              itemBuilder: (context, index, realIndex) {
                // ignore: unused_local_variable
                final carruselImage = carruselImages[index];
                return CardImages(
                  carruselImages: carruselImages[index],
                );
              },
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 3),
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ), // Espacio entre el carrusel y la aimacion Lottie
            LottieBuilder.network(
                'https://lottie.host/01a4bea9-2604-4655-8f53-7d3b0bc6852c/tx9nAkt83D.json'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class CardImages extends StatelessWidget {
  final Receta carruselImages;
  const CardImages({Key? key, required this.carruselImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          splashColor: Colors.red,
          onTap: () {
            carruselImages.copy();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MostrarReceta(
                          carruselImages: carruselImages,
                          themeNotifier: AppValueNotifier.themeNotifier,
                        )));
          },
          child: FadeInImage(
            placeholder: const AssetImage("assets/loading1.gif"),
            image: AssetImage(carruselImages.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
