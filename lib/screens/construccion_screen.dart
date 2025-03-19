import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ConstruccionScreen extends StatelessWidget {
  const ConstruccionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RiveAnimation.asset(
          'assets/en_construccion.riv',
          fit: BoxFit.cover,
          // artboard:
          //     'Artboard', // Reemplaza con el nombre correcto de tu artboard
          // animations: ['animacion'],
        ),
      ),
    );
  }
}
