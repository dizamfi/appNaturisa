import 'package:appnaturisa/screens/inicio_sesion_screens.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Duración del splash
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => InicioSesionScreen()), // Tu pantalla principal
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RiveAnimation.asset(
          'assets/naturisa_entrada.riv',
          fit: BoxFit.cover,
          // artboard:
          //     'Artboard', // Reemplaza con el nombre correcto de tu artboard
          // animations: ['animacion'],
        ),
      ),
    );
  }
}
