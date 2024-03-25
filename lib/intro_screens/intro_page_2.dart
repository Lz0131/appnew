import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  Color _startColor = Colors.purple; // Color inicial
  Color _endColor = const Color.fromARGB(255, 221, 108, 146); // Color final
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
  void dispose() {
    // Detiene el timer al desmontar el widget
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Llamada a la función que inicia la transición de colores
    _startColorTransition();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _duration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_startColor, _endColor],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Centra verticalmente los elementos dentro de la columna
          children: [
            const Text(
              '¡Aprende nuevas recetas facilmente!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Lottie.network(
                'https://lottie.host/9817af00-70a7-4d95-bcef-bbe83002daec/SElewV2Eb4.json')
          ],
        ),
      ),
    );
  }
}
