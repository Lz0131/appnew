import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
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
              '¡Bienvenido a DeliDish!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Lottie.network(
                'https://lottie.host/a7b35afb-2815-4a77-af9c-bab86fecf022/DKa8AnrLEd.json')
          ],
        ),
      ),
    );
  }
}
