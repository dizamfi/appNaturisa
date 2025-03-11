import 'dart:math';

import 'package:flutter/material.dart';

class Contador extends StatelessWidget {
  final String hora;
  const Contador({
    super.key,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ContadorRadial(
        hora: hora,
      ),
    );
  }
}

class ContadorRadial extends StatelessWidget {
  final String hora;
  const ContadorRadial({
    super.key,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(4),
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [
            Color.fromARGB(133, 152, 179, 192),
            Colors.white,
            Color.fromARGB(133, 152, 179, 192),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
      child: CustomPaint(
        painter: _Radial(),
        child: Center(
          child: Text(
            hora,
            style: const TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}

class _Radial extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ignore: prefer_const_declarations
    final Gradient gradiente = const LinearGradient(colors: <Color>[
      Color.fromARGB(255, 32, 96, 190),
      Color.fromARGB(246, 9, 141, 123),
      Color.fromARGB(246, 10, 85, 119)
    ]);

    final Rect rect =
        Rect.fromCircle(center: const Offset(8, 3.8), radius: 180);

    // Circulo completado
    final paint = Paint()
      ..strokeWidth = 7
      ..color = Colors.red
      ..shader = gradiente.createShader(rect)
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
