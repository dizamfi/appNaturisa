import 'package:appnaturisa/widgets/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NetworkAnimated extends StatefulWidget {
  final bool signal;
  const NetworkAnimated({super.key, required this.signal});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _NetworkAnimatedState createState() => _NetworkAnimatedState(signal: signal);
}

class _NetworkAnimatedState extends State<NetworkAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _movementAnimation;

  final bool signal;

  _NetworkAnimatedState({required this.signal});

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador de animación
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1000), // Duración total para las 3 ondas
    )..repeat();

    // Configura la animación de repetición de las ondas
    _sizeAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Mueve las ondas con una animación
    _movementAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Imagen de la antena
          Image.asset('assets/antenaIcono2.png', width: 50, height: 50),
          // Animación de transmisión de señal

          signal
              ? Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        // Envuelve el Stack para limitarlo
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            _buildSignalCircle(0.4, 0.4),
                            _buildSignalCircle(0.5, 0.6),
                            _buildSignalCircle(1.0, 0.6),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Row(
                    children: [
                      Flexible(
                        child: DashedLine(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FaIcon(
                        FontAwesomeIcons.xmark,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: DashedLine(),
                      ),
                    ],
                  ),
                ),
          // Imagen del PLC o dispositivo final
          Image.asset('assets/plc2.png', width: 50, height: 50),
        ],
      ),
    );
  }

  Widget _buildSignalCircle(double sizeMultiplier, double opacity) {
    double currentOpacity = (opacity - _sizeAnimation.value).clamp(0.0, 1.0);
    double movement = _movementAnimation.value *
        0.8; // Se mueve de 0 a 1 (de izquierda a derecha)

    return Positioned(
      left: movement * MediaQuery.of(context).size.width, // Mueve los círculos
      top: 0,
      bottom: 0,
      child: Opacity(
        opacity: currentOpacity,
        child: Container(
          width: 110 * _sizeAnimation.value * sizeMultiplier,
          height: 110 * _sizeAnimation.value * sizeMultiplier,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 108, 185, 159).withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
