import 'dart:io';

import 'package:appnaturisa/helpers/theme.dart';
import 'package:appnaturisa/screens/josefina/aireacion_josefina_screen.dart';
import 'package:appnaturisa/screens/josefina/bombeo/bombeo_josefina_screen.dart';
import 'package:appnaturisa/screens/josefina/comunicaciones_josefina_screen.dart';
import 'package:appnaturisa/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final String id;

  ItemBoton(this.icon, this.texto, this.color1, this.color2, this.id);
}

class MonitoreoScreen extends StatelessWidget {
  const MonitoreoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(children: [
      Container(
          // height: 690,
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              // gradient: _getWeatherGradient(),
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28))),
          child: ClipRRect(
              // Esto recorta el contenido fuera de los bordes
              borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ))),

      Container(
        // height: 420,
        height: size.height * 0.553,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            // color: Color(0xFF212121), // Negro
            // color: Color.fromRGBO(18, 34, 23, 0.859),
            // color: Color.fromRGBO(1, 39, 8, 0.9),
            gradient: LinearGradient(
              colors: [
                // Color.fromARGB(255, 4, 63, 122), // Azul oscuro
                AppTheme.primaryBlue,
                // Color(0xFF003366), // Azul oscuro
                AppTheme.primaryBlue,
                // Color(0xFF0073CC), // Azul medio
                // Color(0xFF00A3FF), // Azul claro
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
                bottomRight: Radius.circular(0))),
      ),

      // HeaderBordesRedondeados(
      //   color: Color.fromRGBO(18, 34, 23, 0.859),
      //   urlImagem: 'assets/mapa_graca.png',
      //   inclinacion: 0,
      //   height: size.height,
      //   width: size.width,
      // ),
      Positioned(
        left: size.width * 0.06,
        top: size.height * 0.25,
        child: Column(
          children: [
            // Text(
            //   'Finca Camaronera',
            //   style: GoogleFonts.anton(
            //     color: Colors.white,
            //     fontSize: 20,
            //   ),
            // ),
            SizedBox(height: size.height * 0.03
                // height: 5,
                ),
            Text(
              'Finca ',
              style: GoogleFonts.anton(
                color: Colors.white,
                // color: Colors.black,
                fontSize: 30,
              ),
            ),
            Text(
              'Josefina',
              style: GoogleFonts.anton(
                color: Colors.white,
                // color: Colors.black,

                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: size.height * 0.18,
        // right: size.width * 0.000,
        left: size.width * 0.5,
        child: Transform.rotate(
          angle: -20 * 3.14159265359 / 90,
          child: Image.asset(
            'assets/plano_josefina.png',
            width: size.width * 0.53,
            height: size.height * 0.25,
            // color: const Color.fromRGBO(255, 255, 255, 0.1),
            // width: 190,
            // height: 190,
          ),
        ),
      ),
      Positioned(
        // top: 75,
        top: size.height * 0.1,
        left: size.width * 0.06,
        child: Image.asset(
          'assets/camaron.png',
          color: const Color.fromRGBO(255, 255, 255, 0.1),
          // width: 100,
          // height: 145,
          width: size.width * 0.28,
          height: size.height * 0.192,
        ),
      ),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      //   child: ListView(
      //     children: [
      // SizedBox(
      //   height: size.height * 0.32,
      // ),
      //       ...itemMap
      //     ],
      //   ),
      // ),

      Positioned(
          // top: 50,
          top: size.height * 0.066,
          left: 0,
          right: 0,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _showAvatarDialog(context),
                        child: CircleAvatar(
                          radius: 30, // Imagen de ejemplo
                          backgroundColor:
                              // const Color.fromRGBO(
                              //     201, 202, 203, 0.9), // Tamaño del avatar
                              Colors.white,
                          backgroundImage:
                              StorageService.prefs.getString('profileImage') !=
                                      null
                                  ? FileImage(File(StorageService.prefs
                                      .getString('profileImage')!))
                                  : null,
                          child: StorageService.prefs
                                      .getString('profileImage') ==
                                  null
                              ? Text(
                                  "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}")
                              : null,
                        ),
                      ),
                      // Text(
                      //   'Gran Camarón ',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 18,
                      //   ),
                      // ),
                      const Text(
                        'Monitoreo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),

                      const Text(
                        'Monit',
                        style:
                            TextStyle(color: Colors.transparent, fontSize: 17),
                      ),
                      // Spacer()
                    ],
                  ),
                ),

                // Positioned(
                //   bottom: 60,
                //   left: 0,
                //   right: 0, // Asegúrate de expandir horizontalmente
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 30),
                //     child: Row(
                //       children: List.generate(
                //         3, // Número de tarjetas
                //         (index) => Padding(
                //           padding: const EdgeInsets.only(right: 10),
                //           child: _FitnessCard(),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // )
                // Positioned(
                //   bottom: 50,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                //     child: Row(
                //       children: [
                //         ClipPath(
                //           clipper: CurvedClipper(),
                //           child: Container(
                //             height: 300,
                //             width: 250,
                //             decoration: BoxDecoration(
                //               // color: Colors.white10,
                //               border: Border.all(
                //                 color: Colors.grey,
                //                 width: 1.0,
                //               ),
                //               borderRadius: const BorderRadius.only(
                //                   bottomLeft: Radius.circular(30),
                //                   bottomRight: Radius.circular(30),
                //                   topLeft: Radius.circular(15),
                //                   topRight: Radius.circular(15)),
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(
                  // height: 220
                  height: size.height * 0.29,
                ),

                SizedBox(
                  height: size.height *
                      0.45, // Ajusta la altura según sea necesario
                  width: size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: 3, // Número de tarjetas
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: index == 0
                              ? const _FitnessCard(
                                  icon: Icon(
                                    Icons.air,
                                    color: Colors.black,
                                  ),
                                  subTitulo:
                                      'Monitorea las piscinas con todos sus tableros',
                                  titulo: 'Aireación',
                                  destination: AireacionJosefinaScreen(),
                                )
                              : index == 1
                                  ? const _FitnessCard(
                                      icon: Icon(
                                        Icons.water_drop,
                                        color: Colors.black,
                                      ),
                                      subTitulo:
                                          'Monitorea el bombeo de agua en tiempo real',
                                      titulo: 'Bombeo',
                                      destination:
                                          BombeoJosefinaScreen(), // Necesitarás crear esta pantalla
                                    )
                                  : const _FitnessCard(
                                      icon: Icon(
                                          FontAwesomeIcons.towerBroadcast,
                                          color: Colors.black),
                                      subTitulo:
                                          'Monitorea la comunicación de todas las antenas',
                                      titulo: 'Comunicaciones',
                                      destination:
                                          ComunicacionesJosefinaScreen(),
                                    ));
                    },
                  ),
                ),
              ]))
    ]);
  }
}

class _FitnessCard extends StatelessWidget {
  final Icon icon;
  final String titulo;
  final String subTitulo;
  final Widget destination; // Pantalla de destino

  const _FitnessCard({
    required this.icon,
    required this.titulo,
    required this.subTitulo,
    required this.destination, // Recibe la pantalla de destino como parámetro
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        // width: 250,
        height: size.height * 0.415,
        width: size.width * 0.695,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(240, 240, 229, 1),
                  color: Colors.white,
                  // border: Border.all(
                  //   color: Color.fromRGBO(240, 240, 229, 1),
                  //   width: 1.0,
                  // ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        // height: 80
                        height: size.height * 0.1), // Espacio para el avatar

                    Text(
                      titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                        // height: 5
                        height: size.height * 0.007),

                    // Descripción
                    Text(
                      subTitulo,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                        // height: 60
                        height: size.height * 0.079),

                    // Botón Ver detalles
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            // Color.fromARGB(255, 12, 55, 100), // Azul oscuro
                            AppTheme.primaryBlue,
                            // Color(0xFF003366), // Azul oscuro
                            AppTheme.primaryBlue,
                            // Color.fromARGB(255, 4, 63, 122), // Azul oscuro

                            // Color(0xFF0073CC), // A
                            //zul medio
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => destination,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ver detalles',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Logo circular que sobresale de la tarjeta
            Positioned(
              // top: 10,
              top: size.height * 0.02,
              // left: 20,
              left: size.width * 0.055,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: icon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Clipper personalizado para la curva superior
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.40,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

void _showAvatarDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircleAvatar(
              radius: 100,
              backgroundColor:
                  // const Color.fromRGBO(
                  //     201, 202, 203, 0.9), // Tamaño ampliado del avatar
                  Colors.white,
              backgroundImage:
                  StorageService.prefs.getString('profileImage') != null
                      ? FileImage(
                          File(StorageService.prefs.getString('profileImage')!))
                      : null,
              child: StorageService.prefs.getString('profileImage') == null
                  ? Text(
                      "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                      style: const TextStyle(fontSize: 40), // Fuente más grande
                    )
                  : null,
            ),
          ),
        ),
      );
    },
  );
}
