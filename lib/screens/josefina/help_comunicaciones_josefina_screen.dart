import 'package:appnaturisa/widgets/network_animated.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpComunicacionesJosefinaScreen extends StatelessWidget {
  const HelpComunicacionesJosefinaScreen({super.key});

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
        //   padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
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
              height: 270,
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
                      height: 110,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '-##',
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
                        Text('Potencia de la antena'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TA##-#',
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
                        Text('Tablero en piscina - N° tablero'),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.red,
                          size: 20,
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
                        Text('Sin comunicación'),
                      ],
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
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10),
              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              height: 95,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.amber,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TA##-#',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text('-##'),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child:
                            const Icon(Icons.network_wifi, color: Colors.green),
                      )
                    ],
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 1,
                  //   color: Colors.grey,
                  // ),
                  NetworkAnimated(signal: false)
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
          height: 50,
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
            child: Row(
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
          ),
        ),
      ],
    );
  }
}
