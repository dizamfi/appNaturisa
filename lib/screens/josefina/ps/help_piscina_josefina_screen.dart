import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpPiscinaJosefinaScreen extends StatelessWidget {
  const HelpPiscinaJosefinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Simbología',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  iconSize: 30,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Column(
              children: [
                OptionsHelp(),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OptionsHelp extends StatelessWidget {
  const OptionsHelp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stack(
        //   children: [
        // Container(
        //   width: double.infinity,
        //   height: 230,
        //   decoration: BoxDecoration(
        //     color: Colors.transparent,
        //     border: Border.all(
        //       color: Colors.grey,
        //       width: 1.0,
        //     ),
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //     child: Column(
        //       children: [
        //         const SizedBox(
        //           height: 78,
        //         ),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: const [
        //             FaIcon(
        //               FontAwesomeIcons.solidCircle,
        //               color: Colors.green,
        //               size: 15,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Icon(
        //               Icons.arrow_right_alt_rounded,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Text('Piscina encendida'),
        //           ],
        //         ),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: const [
        //             FaIcon(
        //               FontAwesomeIcons.solidCircle,
        //               color: Colors.grey,
        //               size: 15,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Icon(
        //               Icons.arrow_right_alt_rounded,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Text('Piscina apagada'),
        //           ],
        //         ),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: const [
        //             Text(
        //               'PS##',
        //               style: TextStyle(
        //                   // color: Color.fromRGBO(9, 31, 72, 1),
        //                   color: Color.fromRGBO(9, 31, 72, 1),
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Icon(
        //               Icons.arrow_right_alt_rounded,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Text('Nombre Piscina'),
        //           ],
        //         ),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: const [
        //             Text(
        //               '#/#',
        //               style: TextStyle(
        //                   // color: Color.fromRGBO(9, 31, 72, 1),
        //                   color: Color.fromRGBO(9, 31, 72, 1),
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Icon(
        //               Icons.arrow_right_alt_rounded,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Text('Circuito on / total circuito'),
        //           ],
        //         ),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: const [
        //             Text(
        //               'TA',
        //               style: TextStyle(
        //                   // color: Color.fromRGBO(9, 31, 72, 1),
        //                   color: Color.fromRGBO(9, 31, 72, 1),
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Icon(
        //               Icons.arrow_right_alt_rounded,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Text('Tableros sin compensación'),
        //           ],
        //         ),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: const [
        //             Text(
        //               'TCP',
        //               style: TextStyle(
        //                   // color: Color.fromRGBO(9, 31, 72, 1),
        //                   color: Color.fromRGBO(9, 31, 72, 1),
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Icon(
        //               Icons.arrow_right_alt_rounded,
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Text('Tableros con compensación'),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        //     Container(
        //       width: double.infinity,
        //       height: 70,
        //       decoration: BoxDecoration(
        //         color: Colors.transparent,
        //         border: Border.all(
        //           color: Colors.grey,
        //           width: 1.0,
        //         ),
        //         borderRadius: BorderRadius.circular(15.0),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           const SizedBox(
        //             width: 15,
        //           ),
        //           const FaIcon(
        //             FontAwesomeIcons.solidCircle,
        //             color: Colors.green,
        //             size: 15,
        //           ),
        //           const SizedBox(
        //             width: 18,
        //           ),
        //           const Text(
        //             'PS##',
        //             style: TextStyle(
        //                 // color: Color.fromRGBO(9, 31, 72, 1),
        //                 color: Color.fromRGBO(9, 31, 72, 1),
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //           const SizedBox(
        //             width: 20,
        //           ),
        //           Text(
        //             '#/#',
        //             style: TextStyle(
        //                 // color: Color.fromRGBO(9, 31, 72, 1),
        //                 color:
        //                     const Color.fromRGBO(9, 31, 72, 1).withOpacity(0.7),
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //           const SizedBox(
        //             width: 20,
        //           ),
        //           const Text(
        //             'TA',
        //             style: TextStyle(
        //                 // color: Color.fromRGBO(9, 31, 72, 1),
        //                 color: Color.fromRGBO(9, 31, 72, 1),
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //           const SizedBox(
        //             width: 15,
        //           ),
        //           const Expanded(
        //             child: Text(
        //               'TCP',
        //               style: TextStyle(
        //                   // color: Color.fromRGBO(9, 31, 72, 1),
        //                   color: Color.fromRGBO(9, 31, 72, 1),
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //           const FaIcon(
        //             FontAwesomeIcons.chevronRight,
        //             // color: Color.fromRGBO(9, 31, 72, 1)
        //             color: Color.fromRGBO(9, 31, 72, 1),
        //           ),
        //           const SizedBox(
        //             width: 20,
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 25,
        ),
        Container(
          width: double.infinity,
          height: 340,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    FaIcon(
                      FontAwesomeIcons.solidCircle,
                      color: Colors.green,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Tablero encendido'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    FaIcon(
                      FontAwesomeIcons.solidCircle,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Tablero apagado'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    FaIcon(
                      FontAwesomeIcons.check,
                      color: Colors.green,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Funcionamiento correcto'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.red,
                      size: 15,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Alarma o problema en el tablero'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.powerOff,
                        color: Colors.green, size: 22),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Circuitos encendidos'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.powerOff,
                        color: Colors.grey, size: 22),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Circuitos apagados'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 22),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Antena activa'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.red, size: 22),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Problema en la antena'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.network_wifi, color: Colors.green, size: 22),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Buena calidad de la antena'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.network_wifi,
                        color: Colors.orangeAccent, size: 22),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Calidad media de la antena'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.network_wifi, color: Colors.red, size: 22),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Mala calidad de la antena'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
