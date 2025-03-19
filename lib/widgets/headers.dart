// ignore_for_file: unused_element

import 'dart:math';

import 'package:appnaturisa/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderCuadrado extends StatelessWidget {
  const HeaderCuadrado({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: const Color(0xff615AAB),
    );
  }
}

class HeaderBordesRedondeados extends StatelessWidget {
  final Color color;
  final String urlImagem;
  final double inclinacion;
  final double width;
  final double height;
  const HeaderBordesRedondeados(
      {super.key,
      required this.color,
      required this.urlImagem,
      required this.inclinacion,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(180),
              child: Image.asset(
                urlImagem,
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                height: height,
                width: width,
                // width: 400,
                // height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PinkBox extends StatelessWidget {
  const PinkBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: screenSize.width,
        // height: 360,
        height: screenSize.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          gradient: LinearGradient(
            colors: [
              // Color(0xFF003366), // Azul oscuro
              // Color(0xFF0073CC), // Azul medio
              // Color(0xFF00A3FF), // Azul claro
              AppTheme.primaryBlue,
              AppTheme.primaryBlue,
              AppTheme.primaryBlue,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}

class HeaderDiagonal extends StatelessWidget {
  const HeaderDiagonal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xff615AAB),
      child: CustomPaint(
        painter: _HeaderDiagonalPainter(),
      ),
    );
  }
}

class _HeaderDiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; //.fill  //.stroke
    lapiz.strokeWidth = 5.0;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class HeaderTriangular extends StatelessWidget {
  const HeaderTriangular({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xff615AAB),
      child: CustomPaint(
        painter: _HeaderTriangularPainter(),
      ),
    );
  }
}

class _HeaderTriangularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; //.fill  //.stroke
    lapiz.strokeWidth = 5.0;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class HeaderPico extends StatelessWidget {
  const HeaderPico({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xff615AAB),
      child: CustomPaint(
        painter: _HeaderPicoPainter(),
      ),
    );
  }
}

class _HeaderPicoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; //.fill  //.stroke
    lapiz.strokeWidth = 5.0;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.22);
    path.lineTo(size.width * 0.5, size.height * 0.50);
    path.lineTo(size.width, size.height * 0.22);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class HeaderCurvo extends StatelessWidget {
  const HeaderCurvo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xff615AAB),
      child: CustomPaint(
        painter: _HeaderCurvoPainter(),
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color.fromARGB(255, 214, 100, 34);
    lapiz.style = PaintingStyle.fill; //.fill  //.stroke
    lapiz.strokeWidth = 5.0;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.22);
    // path.lineTo(size.width, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.14, size.width, size.height * 0.22);

    path.lineTo(size.width, 0);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class HeaderWave extends StatelessWidget {
  const HeaderWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xff615AAB),
      child: CustomPaint(
        painter: _HeaderWavePainter(),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(center: Offset(0, 55.0), radius: 180);

    final Gradient gradiente = LinearGradient(
      colors: [
        // Color.fromARGB(255, 4, 63, 122), // Azul oscuro
        // Color(0xFF003366), // Azul oscuro
        AppTheme.primaryBlue,
        AppTheme.primaryBlue,

        // const Color.fromARGB(255, 4, 66, 128),
        // Color(0xFF00A3FF), // Azul claro
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight,
    );

    final lapiz = Paint()..shader = gradiente.createShader(rect);

    // Propiedades
    lapiz.style = PaintingStyle.fill; //.fill  //.stroke
    lapiz.strokeWidth = 5.0;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.65,
        size.width * 0.7, size.height * 0.6);

    path.quadraticBezierTo(
        size.width * 0.95, size.height * 0.6, size.width, size.height * 0.67);

    path.lineTo(size.width, 0);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HeaderWaveGradient extends StatelessWidget {
  const HeaderWaveGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xff615AAB),
      child: CustomPaint(
        painter: _HeaderWaveGradientPainter(),
      ),
    );
  }
}

class _HeaderWaveGradientPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(center: Offset(0, 55.0), radius: 180);

    final Gradient gradiente = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xff6D05E8),
          Color(0xffC012FF),
          Color(0xff6D05FA),
        ],
        stops: [
          0.2,
          0.5,
          1.0
        ]);
    final lapiz = Paint()..shader = gradiente.createShader(rect);

    // Propiedades
    // lapiz.color = const Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; //.fill  //.stroke
    lapiz.strokeWidth = 5.0;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.30);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.40,
        size.width * 0.5, size.height * 0.30);

    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.20, size.width, size.height * 0.30);

    path.lineTo(size.width, 0);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class IconHeader extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color? color1;
  final Color? color2;

  const IconHeader(
      {super.key,
      required this.icon,
      required this.titulo,
      required this.subtitulo,
      this.color1 = const Color(0xff526BF6),
      this.color2 = const Color(0xff67ACF2)});

  @override
  Widget build(BuildContext context) {
    final Color colorBlanco = Colors.white.withOpacity(0.7);
    return Stack(children: [
      _IconHeaderBackground(
        color1: color1!,
        color2: color2!,
      ),
      Positioned(
        top: -50,
        left: -65,
        child: FaIcon(
          icon,
          size: 240,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      Column(
        children: [
          const SizedBox(
            height: 80,
            width: double.infinity,
          ),
          Text(
            subtitulo,
            style: TextStyle(fontSize: 20, color: colorBlanco),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            titulo,
            style: TextStyle(
                fontSize: 25, color: colorBlanco, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          FaIcon(
            icon,
            size: 80,
            color: Colors.white,
          ),
        ],
      )
    ]);
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  const _IconHeaderBackground({
    Key? key,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
        gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
    );
  }
}
