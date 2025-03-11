import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MapaAireacionJosefinaScreen extends StatefulWidget {
  const MapaAireacionJosefinaScreen({super.key});

  @override
  State<MapaAireacionJosefinaScreen> createState() =>
      _MapaAireacionJosefinaScreenState();
}

class _MapaAireacionJosefinaScreenState
    extends State<MapaAireacionJosefinaScreen> {
  SMINumber? _input; // Controlador para la entrada de la máquina de estados
  double piscina = 0; // Valor inicial para la variable "Piscina"

  void _onRiveInit(Artboard art) {
    final controller =
        StateMachineController.fromArtboard(art, 'State Machine 1');
    if (controller != null) {
      art.addController(controller);
      _input = controller.findInput<double>('Piscina') as SMINumber?;
      if (_input != null) {
        _input!.value = piscina;
        print('aaasadddddddd'); // Asigna el valor inicial
      }
    } else {
      debugPrint('No se encontró la máquina de estados "State Machine 1".');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RiveAnimation.asset(
          'assets/mapagraca.riv', // Asegúrate de que este archivo exista en esta ruta
          onInit: _onRiveInit, // Inicializa la animación con el método definido
          // animations: const [
          //   'Piscina 01',
          //   'Piscina 02',
          //   'Piscina 03',
          //   'Piscina 04'
          // ],
          fit: BoxFit.contain, // Ajusta el contenido al tamaño del contenedor
        ),
      ),
    );
  }
}
