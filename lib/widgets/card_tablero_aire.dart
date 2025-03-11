import 'package:appnaturisa/helpers/piscina.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardTableroAire extends StatelessWidget {
  final String tablero;
  final int numCircuito;
  final int numAirOn;
  final double sizeCirc;
  final bool statComm;
  final int imputsLN;
  final auto = 1 << 9;
  final manual = 1 << 8;
  final paro = 1 << 3;
  final supVolt = 1 << 11;
  final supTrans = 1 << 10;
  final alarmGuard = 1 << 12;

  const CardTableroAire({
    super.key,
    required this.tablero,
    required this.numCircuito,
    required this.numAirOn,
    required this.statComm,
    required this.imputsLN,
    required this.sizeCirc,
  });

  @override
  Widget build(BuildContext context) {
    String op = ((manual & imputsLN) | (auto & imputsLN)) != 0
        ? ((manual & imputsLN) != 0 ? "Local" : "Remoto")
        : "Off";

    return Container(
      constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          minHeight: 100),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(9, 31, 72, 1),
            blurRadius: 3,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tablero,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(9, 31, 72, 1),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Circuitos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(numCircuito.toString()),
                        ],
                      )
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estado',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Operación',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidCircle,
                      color: numAirOn > 0 ? Colors.green : Colors.grey,
                      size: 12,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(op)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    (supTrans & imputsLN) != 0
                        ? const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.red,
                            size: 15,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                            size: 15,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    (alarmGuard & imputsLN) != 0
                        ? const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.red,
                            size: 15,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                            size: 15,
                          ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sup.Trans',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Alarm Guard',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 34,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (supVolt & imputsLN) != 0
                        ? const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.red,
                            size: 15,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                            size: 15,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    (paro & imputsLN) != 0
                        ? const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.red,
                            size: 15,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                            size: 15,
                          )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sup.Volt',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Paro',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 34,
                ),
                Column(
                  children: [
                    statComm
                        ? const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.red,
                            size: 15,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                            size: 15,
                          )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Red',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Expanded(
                    child: Text(
                  'Circuitos',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),
                // SizedBox(
                //   width: 3,
                // ),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),
                // SizedBox(
                //   width: 3,
                // ),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),
                // SizedBox(
                //   width: 3,
                // ),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),
                // SizedBox(
                //   width: 3,
                // ),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),
                // SizedBox(
                //   width: 3,
                // ),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),
                // SizedBox(
                //   width: 3,
                // ),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),
                // SizedBox(
                //   width: 3,
                // ),
                // FaIcon(FontAwesomeIcons.powerOff, color: Colors.green),

                ...Piscina.circuitosActivos(imputsLN, numCircuito, sizeCirc)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
