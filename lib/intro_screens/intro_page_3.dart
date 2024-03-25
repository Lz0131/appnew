import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  Color _startColor = Colors.blue; // Color inicial
  Color _endColor = Colors.purple; // Color final
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
              '¡O comparte tus propias recetas!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Lottie.network(
                'https://lottie.host/008a3bd5-819a-445b-a344-1c299de00abc/jzS8R3K87P.json')
          ],
        ),
      ),
    );
  }
}
