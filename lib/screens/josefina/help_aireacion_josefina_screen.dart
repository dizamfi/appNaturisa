import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpAireacionGracaScreen extends StatelessWidget {
  const HelpAireacionGracaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 0,
        // leadingWidth: 0,

        // centerTitle: true,
        automaticallyImplyLeading: false,
        // title: Padding(
        //   padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       const Text('Simbología',
        //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        //       // Spacer(),
        //       // SizedBox(
        //       //   width: double.infinity,
        //       // ),
        //       IconButton(
        //         onPressed: () => Navigator.pop(context),
        //         icon: const Icon(Icons.close),
        //         iconSize: 30,
        //       )
        //     ],
        //   ),
        // ),
      ),
      body: PopScope(
        canPop: false,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Simbología',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      iconSize: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    OptionsHelp(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                  ],
                )
              ],
            ),
          ),
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
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 78,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        Text('Piscina encendida'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        Text('Piscina apagada'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PS##',
                          style: TextStyle(
                              // color: Color.fromRGBO(9, 31, 72, 1),
                              color: Color.fromRGBO(9, 31, 72, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                        Text('Nombre Piscina'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '#/#',
                          style: TextStyle(
                              // color: Color.fromRGBO(9, 31, 72, 1),
                              color: Color.fromRGBO(9, 31, 72, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                        Text('Circuito on / total circuito'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TA',
                          style: TextStyle(
                              // color: Color.fromRGBO(9, 31, 72, 1),
                              color: Color.fromRGBO(9, 31, 72, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                        Text('Tableros sin compensación'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TCP',
                          style: TextStyle(
                              // color: Color.fromRGBO(9, 31, 72, 1),
                              color: Color.fromRGBO(9, 31, 72, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                        Text('Tableros con compensación'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.solidCircle,
                    color: Colors.green,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  const Text(
                    'PS##',
                    style: TextStyle(
                        // color: Color.fromRGBO(9, 31, 72, 1),
                        color: Color.fromRGBO(9, 31, 72, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '#/#',
                    style: TextStyle(
                        // color: Color.fromRGBO(9, 31, 72, 1),
                        color:
                            const Color.fromRGBO(9, 31, 72, 1).withOpacity(0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'TA',
                    style: TextStyle(
                        // color: Color.fromRGBO(9, 31, 72, 1),
                        color: Color.fromRGBO(9, 31, 72, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: Text(
                      'TCP',
                      style: TextStyle(
                          // color: Color.fromRGBO(9, 31, 72, 1),
                          color: Color.fromRGBO(9, 31, 72, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    // color: Color.fromRGBO(9, 31, 72, 1)
                    color: Color.fromRGBO(9, 31, 72, 1),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          width: double.infinity,
          height: 142,
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
                    Icon(Icons.gps_fixed_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Mapa general de las piscinas'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Notificaciones '),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.filter_alt_sharp),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Filtro'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                      // size: 20,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Alarma'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      Icons.warning_amber_rounded,
                      color: Colors.yellow,
                      // size: 20,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Advertencia'),
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
