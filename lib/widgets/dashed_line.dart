import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 1), // Tamaño del lienzo donde se dibujará la línea
      painter: DashedLinePainter(),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Color de la línea
      ..strokeWidth = 2 // Grosor de la línea
      ..style = PaintingStyle.stroke;

    // Definir los segmentos de la línea (longitud de segmentos y huecos)
    final dashWidth = 8.0; // Longitud del segmento
    final dashSpace = 2.0; // Espacio entre segmentos

    double startX = 0;
    while (startX < size.width) {
      // Dibuja el segmento
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace; // Mover al siguiente segmento
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Como no hay cambios dinámicos, no se necesita repintar
    return false;
  }
}
