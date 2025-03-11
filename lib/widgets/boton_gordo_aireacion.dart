import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'boton_gordo_background.dart';

class BotonGordoAireacion extends StatelessWidget {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final bool estado;
  final int alarma;
  final int numCirc;
  final int numCircOn;
  final int ta;
  final int tcp;
  final alarmAdver = 1 << 0;
  final alarmAlert = 1 << 1;

  final Function() onPress;

  const BotonGordoAireacion({
    super.key,
    this.icon = FontAwesomeIcons.circle,
    required this.texto,
    this.color1 = Colors.green,
    this.color2 = Colors.blueGrey,
    required this.onPress,
    required this.estado,
    required this.alarma,
    required this.numCirc,
    required this.numCircOn,
    required this.ta,
    required this.tcp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: _BotonGordoBackground(
        icon: icon,
        color1: color1,
        color2: color2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: 18,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(
                  icon,
                  // color: Color.fromRGBO(9, 31, 72, 1),
                  color: estado ? Colors.green : Colors.grey,
                  size: 22,
                ),
                if (alarma != 0)
                  Row(
                    children: [
                      if ((alarmAlert & alarma) != 0 &&
                              (alarmAdver & alarma) != 0 ||
                          (alarmAlert & alarma) != 0)
                        const FaIcon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                      if ((alarmAlert & alarma) == 0 &&
                          (alarmAdver & alarma) != 0)
                        const FaIcon(
                          Icons.warning_amber_rounded,
                          color: Colors.yellow,
                          size: 20,
                        ),
                    ],
                  )
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    texto,
                    style: const TextStyle(
                        // color: Color.fromRGBO(9, 31, 72, 1),
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      // Text(
                      //   texto,
                      //   style: const TextStyle(
                      //       // color: Color.fromRGBO(9, 31, 72, 1),
                      //       color: Color.fromRGBO(9, 31, 72, 1),
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),

                      Row(
                        children: [
                          Text(
                            numCircOn.toString(),
                            style: TextStyle(
                                // color: Color.fromRGBO(9, 31, 72, 1),
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '/$numCirc',
                            style: TextStyle(
                                // color: Color.fromRGBO(9, 31, 72, 1),
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            'TA:',
                            style: TextStyle(
                                // color: Color.fromRGBO(9, 31, 72, 1),
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            ta.toString(),
                            style: TextStyle(
                                // color: Color.fromRGBO(9, 31, 72, 1),
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      Row(
                        children: [
                          const Text(
                            'TCP:',
                            style: TextStyle(
                                // color: Color.fromRGBO(9, 31, 72, 1),
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            tcp.toString(),
                            style: TextStyle(
                                // color: Color.fromRGBO(9, 31, 72, 1),
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      // Text('TA: 5'),
                      const SizedBox(
                        width: 2,
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text(
                      //           'Auto:',
                      //           style: TextStyle(
                      //               // color: Color.fromRGBO(9, 31, 72, 1),
                      //               color: Color.fromRGBO(9, 31, 72, 1),
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         Text(
                      //           '2',
                      //           style: TextStyle(
                      //               // color: Color.fromRGBO(9, 31, 72, 1),
                      //               color: Color.fromRGBO(9, 31, 72, 1)
                      //                   .withOpacity(0.7),
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold),
                      //         )
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text(
                      //           'Manual:',
                      //           style: TextStyle(
                      //               // color: Color.fromRGBO(9, 31, 72, 1),
                      //               color: Color.fromRGBO(9, 31, 72, 1),
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         Text(
                      //           '4',
                      //           style: TextStyle(
                      //               // color: Color.fromRGBO(9, 31, 72, 1),
                      //               color: Color.fromRGBO(9, 31, 72, 1)
                      //                   .withOpacity(0.7),
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold),
                      //         )
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text(
                      //           'Off:',
                      //           style: TextStyle(
                      //               // color: Color.fromRGBO(9, 31, 72, 1),
                      //               color: Color.fromRGBO(9, 31, 72, 1),
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         Text(
                      //           '1',
                      //           style: TextStyle(
                      //               // color: Color.fromRGBO(9, 31, 72, 1),
                      //               color: Color.fromRGBO(9, 31, 72, 1)
                      //                   .withOpacity(0.7),
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold),
                      //         )
                      //       ],
                      //     ),
                      //   ],
                      // )

                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text('M'),
                      //     Container(
                      //       height: 18,
                      //       width: 18,
                      //       child: Center(child: Text('4')),
                      //       color: Colors.red,
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ],
              ),
            ),
            const FaIcon(
              FontAwesomeIcons.chevronRight,
              // color: Color.fromRGBO(9, 31, 72, 1)
              color: Colors.black,
            ),
            const SizedBox(
              width: 25,
            )
          ],
        ),
      ),
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;
  final Widget child;

  const _BotonGordoBackground({
    Key? key,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 60,
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color.fromRGBO(240, 240, 229, 1),
        //     blurRadius: 3,
        //   )
        // ],
      ),
      child: child,
    );
  }
}
