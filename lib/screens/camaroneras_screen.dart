// import 'dart:io';

// import 'package:appnaturisa/screens/josefina/historial_screen.dart';
// import 'package:appnaturisa/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CamaroneraScreen extends StatelessWidget {
//   CamaroneraScreen({super.key});
//   // final List<Map<String, String>> fincas = [
//   //   {"nombre": "Finca Josefina", "imagen": "assets/plano_josefina.png"},
//   //   {"nombre": "Finca Maricultura", "imagen": "assets/plano_maricultura.png"},
//   //   {"nombre": "Finca Naturisa", "imagen": "assets/plano_naturisa.png"},
//   //   {"nombre": "Finca Pesjolla", "imagen": "assets/plano_pesjolla.png"},
//   //   {"nombre": "Finca RioNilo", "imagen": "assets/plano_rionilo.png"},
//   // ];

//   // Lista de pantallas que cambiarán cuando se toque una opción
//   // static const List<Widget> _pages = <Widget>[
//   //   ProfileScreen(),
//   // ];

//   final List<Map<String, String>> fincas = [
//     {"nombre": "Finca Josefina", "imagen": "assets/plano_josefina.png"},
//     {"nombre": "Finca Maricultura", "imagen": "assets/plano_maricultura.png"},
//     {"nombre": "Finca Naturisa", "imagen": "assets/plano_naturisa.png"},
//     {"nombre": "Finca Pesjolla", "imagen": "assets/plano_pesjolla.png"},
//     {"nombre": "Finca RioNilo", "imagen": "assets/plano_rionilo.png"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final nombre = StorageService.prefs.getString('nombre') ?? 'Usuario';

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 70, // Ajusta la altura del AppBar
//         title: Row(
//           children: [
//             GestureDetector(
//               onTap: () => _showAvatarDialog(context),
//               child: CircleAvatar(
//                 radius: 18, // Tamaño del avatar
//                 // backgroundColor: const Color.fromRGBO(201, 202, 203, 0.9),
//                 backgroundColor: Colors.white,
//                 backgroundImage: StorageService.prefs
//                             .getString('profileImage') !=
//                         null
//                     ? FileImage(
//                         File(StorageService.prefs.getString('profileImage')!))
//                     : null,
//                 child: StorageService.prefs.getString('profileImage') == null
//                     ? Text(
//                         "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
//                         style: GoogleFonts.roboto(
//                             color: Colors.black,
//                             fontSize: 12), // Fuente más pequeña
//                       )
//                     : null,
//               ),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               "Naturisa",
//               style: GoogleFonts.roboto(color: Colors.white),
//             ),
//           ],
//         ),
//         backgroundColor: const Color.fromARGB(255, 4, 63, 122), // Azul oscuro
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.search,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // Acción al presionar el ícono de búsqueda
//             },
//           ),
//         ],
//       ),
//       // backgroundColor:
//       //     const Color.fromARGB(255, 240, 240, 240), // Fondo más claro
//       // backgroundColor: Colors.white,
//       backgroundColor: const Color.fromARGB(255, 4, 63, 122),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 15),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'Bienvenido, $nombre',
//                 style: GoogleFonts.roboto(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//             const SizedBox(height: 30),
//             // const SizedBox(height: 20),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 20),
//             //   child: Text(
//             //     'A continuación, se muestran todas las fincas automatizadas',
//             //     style: GoogleFonts.roboto(
//             //       fontSize: 16,
//             //       color: Colors.white,
//             //     ),
//             //     textAlign: TextAlign.center,
//             //   ),
//             // ),
//             // const SizedBox(height: 10),
//             Container(
//               width: double.infinity,
//               height: size.height * 0.65,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   )),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       'A continuación, se muestran todas las fincas automatizadas',
//                       style: GoogleFonts.roboto(
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Container(
//                     color: Colors.white,
//                     width: double.infinity,
//                     height: size.height * 0.55,
//                     child: Swiper(
//                       itemCount: fincas.length,
//                       layout: SwiperLayout.STACK,
//                       itemWidth: size.width * 0.8,
//                       itemHeight: size.height * 0.45,
//                       viewportFraction: 0.6,
//                       scale: 0.8,
//                       autoplay: true,
//                       autoplayDelay: 3000,
//                       itemBuilder: (BuildContext context, int index) {
//                         final finca = fincas[index];
//                         final heroId = 'swiper-${finca["nombre"]}';

//                         return GestureDetector(
//                           onTap: () {
//                             if (finca["nombre"] == "Finca Josefina") {
//                               Navigator.pushNamed(context, 'inicio_screen');
//                             }
//                             // Acción al tocar la tarjeta
//                           },
//                           child: Hero(
//                             tag: heroId,
//                             child: Container(
//                               padding: const EdgeInsets.all(
//                                   25), // Padding interno de la tarjeta
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 10,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         color: Colors
//                                             .white, // Fondo blanco para la imagen
//                                         child: Image.asset(
//                                           finca["imagen"]!,
//                                           fit: BoxFit.cover,
//                                           width: double.infinity,
//                                           height: double.infinity,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 25,
//                                     ),
//                                     Text(
//                                       finca["nombre"]!,
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.roboto(
//                                         color: Colors.black,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       pagination: const SwiperPagination(
//                         builder: DotSwiperPaginationBuilder(
//                           activeColor: Color.fromARGB(255, 4, 63, 122),
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: Container(
//       //   decoration: const BoxDecoration(
//       //     border: Border(
//       //       top: BorderSide(
//       //         color: Colors.grey, // Color de la línea
//       //         width: 0.2, // Ancho de la línea
//       //       ),
//       //     ),
//       //   ),
//       //   child: BottomNavigationBar(
//       //     // elevation: 0,
//       //     backgroundColor: Colors.white,
//       //     items: const [
//       //       BottomNavigationBarItem(
//       //         backgroundColor: Colors.white,
//       //         icon: Icon(Icons.home),
//       //         label: 'Home',
//       //       ),
//       //       BottomNavigationBarItem(
//       //         icon: Icon(Icons.person),
//       //         label: 'Perfil',
//       //       ),
//       //     ],
//       //     selectedItemColor: const Color.fromARGB(255, 4, 63, 122),
//       //     unselectedItemColor: Colors.grey,
//       //     onTap: (index) {
//       //       // Acción al tocar los elementos del menú inferior
//       //       if (index == 0) {
//       //         // Navegar a Home
//       //       } else if (index == 1) {
//       //         // Navegar a Perfil
//       //       }
//       //     },
//       //   ),
//       // ),
//     );
//   }
// }

// void _showAvatarDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (context) {
//       return GestureDetector(
//         onTap: () {
//           Navigator.of(context).pop();
//         },
//         child: Dialog(
//           backgroundColor: Colors.transparent,
//           child: Center(
//             child: CircleAvatar(
//               radius: 100,
//               backgroundColor: const Color.fromRGBO(
//                   201, 202, 203, 0.9), // Tamaño ampliado del avatar
//               backgroundImage:
//                   StorageService.prefs.getString('profileImage') != null
//                       ? FileImage(
//                           File(StorageService.prefs.getString('profileImage')!))
//                       : null,
//               child: StorageService.prefs.getString('profileImage') == null
//                   ? Text(
//                       "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
//                       style:
//                           GoogleFonts.roboto(fontSize: 40), // Fuente más grande
//                     )
//                   : null,
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

import 'dart:io';

import 'package:appnaturisa/helpers/theme.dart';
import 'package:appnaturisa/screens/josefina/historial_screen.dart';
import 'package:appnaturisa/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CamaroneraScreen extends StatelessWidget {
  CamaroneraScreen({super.key});

  final List<Map<String, String>> fincas = [
    {"nombre": "Finca Josefina", "imagen": "assets/plano_josefina.png"},
    {"nombre": "Finca Maricultura", "imagen": "assets/plano_maricultura.png"},
    {"nombre": "Finca Naturisa", "imagen": "assets/plano_naturisa.png"},
    {"nombre": "Finca Pesjolla", "imagen": "assets/plano_pesjolla.png"},
    {"nombre": "Finca RioNilo", "imagen": "assets/plano_rionilo.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final nombre = StorageService.prefs.getString('nombre') ?? 'Usuario';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: AppTheme.primaryBlue,
          title: Row(
            children: [
              GestureDetector(
                onTap: () => _showAvatarDialog(context),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  backgroundImage: StorageService.prefs
                              .getString('profileImage') !=
                          null
                      ? FileImage(
                          File(StorageService.prefs.getString('profileImage')!))
                      : null,
                  child: StorageService.prefs.getString('profileImage') == null
                      ? Text(
                          "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                          style: TextStyle(
                            color: AppTheme.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Naturisa",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.search,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       // Acción al presionar el ícono de búsqueda
          //     },
          //   ),
          // ],
        ),
        backgroundColor: Colors.transparent, // Hacemos transparente el Scaffold
        body: Container(
          // Aplicamos el gradiente al contenedor principal
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryBlue, // Color base
                Color(0xFF0A4A8C), // Versión ligeramente más clara
                Color(0xFF0C5DA6), // Aún más claro hacia abajo
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección superior con el saludo
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
                child: Text(
                  'Bienvenido, $nombre',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Contenedor blanco que ocupa todo el espacio restante
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'A continuación, se muestran todas las fincas automatizadas',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textDark,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Swiper que ocupa el resto del espacio disponible
                      Expanded(
                        child: Swiper(
                          itemCount: fincas.length,
                          layout: SwiperLayout.STACK,
                          itemWidth: size.width * 0.8,
                          itemHeight: size.height * 0.45,
                          viewportFraction: 0.6,
                          scale: 0.8,
                          autoplay: true,
                          autoplayDelay: 3000,
                          itemBuilder: (BuildContext context, int index) {
                            final finca = fincas[index];
                            final heroId = 'swiper-${finca["nombre"]}';

                            return GestureDetector(
                              onTap: () {
                                if (finca["nombre"] == "Finca Josefina") {
                                  Navigator.pushNamed(context, 'inicio_screen');
                                } else if (finca["nombre"] ==
                                    "Finca Maricultura") {
                                  Navigator.pushNamed(
                                      context, 'maricultura_screen');
                                }
                              },
                              child: Hero(
                                tag: heroId,
                                child: Container(
                                  padding: const EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.shadowColor,
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            color: Colors.white,
                                            child: Image.asset(
                                              finca["imagen"]!,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 25),
                                        Text(
                                          finca["nombre"]!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppTheme.primaryBlue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              activeColor: AppTheme.primaryBlue,
                              color: AppTheme.mediumGray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
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
              backgroundColor: AppTheme.lightGray,
              backgroundImage:
                  StorageService.prefs.getString('profileImage') != null
                      ? FileImage(
                          File(StorageService.prefs.getString('profileImage')!))
                      : null,
              child: StorageService.prefs.getString('profileImage') == null
                  ? Text(
                      "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                      style: TextStyle(
                        fontSize: 40,
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      );
    },
  );
}
