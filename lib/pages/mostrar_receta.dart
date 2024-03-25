import 'dart:async';

import 'package:flutter/material.dart';
import 'package:appnew/pages/dashboard_screen.dart';
import 'package:appnew/settings/app_value_notifier.dart';
import 'package:appnew/settings/theme.dart';

import '../database/model_recetas.dart';

/*class MostrarReceta extends StatelessWidget {
  final Receta carruselImages;
  final ValueNotifier<bool> themeNotifier;
  const MostrarReceta({
    Key? key,
    required this.carruselImages,
    required this.themeNotifier,
  }) : super(key: key);
  @override
  State<MostrarReceta> createState() => _MostrarReceta();
}

class _MostrarReceta extends State<MostrarReceta> {
  late Color _startColor; // Color inicial
  late Color _endColor; // Color final
  @override
  @override
  
}*/
class MostrarReceta extends StatefulWidget {
  final Receta carruselImages;
  final ValueNotifier<bool> themeNotifier;
  const MostrarReceta({
    Key? key,
    required this.carruselImages,
    required this.themeNotifier,
  }) : super(key: key);

  @override
  State<MostrarReceta> createState() =>
      _MostrarRecetaState(carruselImages: carruselImages);
}

class _MostrarRecetaState extends State<MostrarReceta> {
  final Receta carruselImages;

  _MostrarRecetaState({required this.carruselImages});

  late Color _startColor; // Color inicial
  late Color _endColor; // Color final
  bool bookmarked = false;

  Duration _duration = Duration(seconds: 5); // Duración de la transición
  late Timer _timer; // Timer para la transición de color

  @override
  void initState() {
    super.initState();

    _startColor =
        ThemeApp.startColorForTheme(AppValueNotifier.themeNotifier.value);
    _endColor = ThemeApp.endColorForTheme(AppValueNotifier.themeNotifier.value);

    AppValueNotifier.themeNotifier.addListener(_handleThemeChange);
    _startColorTransition();
  }

  @override
  void dispose() {
    super.dispose();

    AppValueNotifier.themeNotifier.removeListener(_handleThemeChange);
    _timer.cancel();
  }

  void _handleThemeChange() {
    setState(() {
      _startColor =
          ThemeApp.startColorForTheme(AppValueNotifier.themeNotifier.value);
      _endColor =
          ThemeApp.endColorForTheme(AppValueNotifier.themeNotifier.value);
    });
  }

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
        title: Text(
          carruselImages.name,
          style: const TextStyle(
            letterSpacing: 1.0,
            fontSize: 22,
          ),
        ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/loading1.gif"),
                        image: AssetImage(carruselImages.image),
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Text(
                              carruselImages.name,
                              style: const TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "INGREDIENTES:",
                      style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      carruselImages.ingredients,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "PREPARACIÓN:",
                      style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      carruselImages.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
