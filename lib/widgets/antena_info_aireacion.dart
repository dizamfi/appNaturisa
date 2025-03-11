import 'package:appnaturisa/widgets/network_animated.dart';
import 'package:flutter/material.dart';

// import 'boton_gordo_background.dart';

class AntenaInfoAireacion extends StatelessWidget {
  final String tablero;
  final Color color1;
  final Color color2;
  final bool estado;
  final int potencia;

  const AntenaInfoAireacion({
    super.key,
    this.color1 = Colors.green,
    this.color2 = Colors.blueGrey,
    required this.estado,
    required this.tablero,
    required this.potencia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      height: 95,
      width: 400,
      decoration: BoxDecoration(
        // color: Colors.amber,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tablero,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 18,
              ),
              Text('$potencia'),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.network_wifi, color: Colors.green),
              )
            ],
          ),
          // Container(
          //   width: double.infinity,
          //   height: 1,
          //   color: Colors.grey,
          // ),
          NetworkAnimated(signal: estado)
        ],
      ),
    );
  }
}
