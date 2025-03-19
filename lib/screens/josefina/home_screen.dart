import 'dart:io';

import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/screens/josefina/antenas_info_state.dart';
import 'package:appnaturisa/screens/josefina/info_ps_on_off_screen.dart';
import 'package:appnaturisa/screens/josefina/selec_horario_screen.dart';
import 'package:appnaturisa/services/storage_service.dart';
// import 'package:appnaturisa/widgets/curved_gif_carousel.dart';
import 'package:appnaturisa/widgets/headers.dart';
import 'package:appnaturisa/widgets/internet_check.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<dynamic> apiDataList = [];
  bool firstLoad = true;
  int _currentIndex = 0;

  final List<String> imgList = [
    'assets/imageAntena.png',
    'assets/iii.png',
    'assets/image3.jpg',
  ];

  Future<void> _refreshData() async {
    // Simula la recarga de datos
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .reconnectIfNeeded();

      if (!Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .hasError) {
        if (firstLoad) {
          if (PiscinasJosefinaProvider.channel != null) {
            Provider.of<PiscinasJosefinaProvider>(context, listen: false)
                .subscribePiscinasAntenasAndInfoGeneral();
          }
          setState(() {
            firstLoad = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    firstLoad = true;

    WidgetsBinding.instance.removeObserver(this);
    PiscinasJosefinaProvider.channel!.sink.add('unsubscribeAntenas');
    PiscinasJosefinaProvider.subscriptionAntenas?.cancel();
    PiscinasJosefinaProvider.subscriptionAntenas = null;
    PiscinasJosefinaProvider.channel!.sink.add('unsubscribeInfoGeneralPS');
    PiscinasJosefinaProvider.subscriptionInfoGeneralPis?.cancel();
    PiscinasJosefinaProvider.subscriptionInfoGeneralPis = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
          ),
          const HeaderWave(),
          Positioned(
            top: size.height * 0.22,
            left: size.width * 0.4,
            child: Transform.rotate(
              angle: -20 * 3.14159265359 / 90,
              child: Image.asset(
                'assets/plano_josefina.png',
                width: size.width * 0.58,
                height: size.height * 0.30,
                color: const Color.fromRGBO(255, 255, 255, 0.1),
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
          // Positioned(
          //   top: 180,
          //   left: size.width * 0.5 - 140, // Centra el widget horizontalmente
          //   child: _buildStorageCard2(),
          // ),
          Positioned(
            top: size.height * 0.591,
            left: size.width * 0.07,
            right: 0,
            child: Text(
              'Acceso rápido',
              style: GoogleFonts.anton(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          InternetChecker(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: Positioned(
                top: size.height * 0.658,
                left: 0,
                right: 0,
                child: Consumer<PiscinasJosefinaProvider>(
                  builder: (context, antenaProvider, child) {
                    apiDataList = antenaProvider.apiDataListInfoGeneralPis;
                    // print(apiDataList[3][0]);

                    if (PiscinasJosefinaProvider.isLoading2) {
                      // return SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       SizedBox(
                      //         width: size.width * 0.07,
                      //       ),
                      //       ShimmerContainer(title: 'Piscinas'),
                      //       SizedBox(
                      //         width: size.width * 0.045,
                      //       ),
                      //       ShimmerContainer(title: 'Antenas'),
                      //       SizedBox(
                      //         width: size.width * 0.045,
                      //       ),
                      //       ShimmerContainer(title: 'Antenas'),
                      //       SizedBox(
                      //         width: size.width * 0.07,
                      //       ),
                      //     ],
                      //   ),
                      // );

                      return _buildShimmerLoading(size);
                    } else if (antenaProvider.hasError) {
                      // return Center(
                      //   child: Icon(
                      //     Icons.wifi_off_outlined,
                      //     size: 80,
                      //   ),
                      // );

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wifi_off_outlined,
                                size: 60, color: Colors.red),
                            SizedBox(height: 16),
                            Text("Error de conexión",
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      );
                    }

                    // 3. Verifica si los datos están completos para evitar errores de renderizado
                    bool hasCompleteData = _verifyCompleteData(apiDataList);
                    if (!hasCompleteData) {
                      return _buildShimmerLoading(size);
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const InfoPSOnOffScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.waves,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Piscinas',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    // Text(
                                    //   apiDataList.isNotEmpty
                                    //       ? '${apiDataList[1][0]["PiscinasOn"]} encendidas'
                                    //       : '----',
                                    //   style: TextStyle(
                                    //     color: Color.fromRGBO(23, 223, 106, 1),
                                    //     fontSize: 14,
                                    //   ),
                                    // ),

                                    Text(
                                      _getSafeValue(apiDataList, 1, 0,
                                          "PiscinasOn", "encendidas"),
                                      style: TextStyle(
                                        color: Color.fromRGBO(23, 223, 106, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.045,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const AntenasInfoStateScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.rss_feed,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Antenas',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    // Text(
                                    //   apiDataList.isNotEmpty
                                    //       ? '${apiDataList[3][0]["AntenasOff"]} sin señal'
                                    //       : '----',
                                    //   style: const TextStyle(
                                    //     color: Colors.red,
                                    //     fontSize: 14,
                                    //   ),
                                    // ),

                                    Text(
                                      _getSafeValue(apiDataList, 3, 0,
                                          "AntenasOff", "sin señal"),
                                      style: TextStyle(
                                        color: Color.fromRGBO(23, 223, 106, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.045,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const SelecHorarioScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_alarm,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Horario',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'Global',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
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
                        'Josefina',
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
              ],
            ),
          ),

          Positioned(
            left: size.width * 0.06,
            top: size.height * 0.3,
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
        ],
      ),
    );
  }

  // Método para verificar si todos los datos necesarios están disponibles
  bool _verifyCompleteData(List<dynamic> dataList) {
    if (dataList.isEmpty) return false;

    // Verifica que existan los índices que usas
    if (dataList.length < 4) return false;

    // Verifica que cada nivel tenga la estructura esperada
    try {
      // Verifica el primer acceso (piscinas)
      if (dataList[1].isEmpty ||
          dataList[1][0] == null ||
          !dataList[1][0].containsKey("PiscinasOn")) {
        return false;
      }

      // Verifica el segundo acceso (antenas)
      if (dataList[3].isEmpty ||
          dataList[3][0] == null ||
          !dataList[3][0].containsKey("AntenasOff")) {
        return false;
      }

      return true;
    } catch (e) {
      print("Error verificando datos: $e");
      return false;
    }
  }

// Método para recuperar de forma segura los valores
  String _getSafeValue(List<dynamic> dataList, int outerIndex, int innerIndex,
      String key, String suffix) {
    try {
      if (dataList.isNotEmpty &&
          dataList.length > outerIndex &&
          dataList[outerIndex].isNotEmpty &&
          dataList[outerIndex].length > innerIndex &&
          dataList[outerIndex][innerIndex] != null &&
          dataList[outerIndex][innerIndex].containsKey(key)) {
        return "${dataList[outerIndex][innerIndex][key]} $suffix";
      }
    } catch (e) {
      print("Error obteniendo valor seguro: $e");
    }
    return "---- $suffix";
  }

// Método para construir los contenedores de shimmer loading
  Widget _buildShimmerLoading(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: size.width * 0.07),
          ShimmerContainer(title: 'Piscinas'),
          SizedBox(width: size.width * 0.045),
          ShimmerContainer(title: 'Antenas'),
          SizedBox(width: size.width * 0.045),
          ShimmerContainer(title: 'Antenas'),
          SizedBox(width: size.width * 0.07),
        ],
      ),
    );
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
                backgroundColor: const Color.fromRGBO(201, 202, 203, 0.9),
                backgroundImage: StorageService.prefs
                            .getString('profileImage') !=
                        null
                    ? FileImage(
                        File(StorageService.prefs.getString('profileImage')!))
                    : null,
                child: StorageService.prefs.getString('profileImage') == null
                    ? Text(
                        "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                        style: const TextStyle(fontSize: 40),
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStorageCard2() {
    return Container(
      height: 240,
      width: 280,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: PageView.builder(
                itemCount: imgList.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.asset(
                        imgList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Center(
                        child: Text(
                          'Información sobre la imagen',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: (_currentIndex + 1) / imgList.length,
            backgroundColor: Colors.black,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final String title;

  const ShimmerContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}







// import 'dart:io';

// import 'package:appnaturisa/providers/ps_josefina_provider.dart';
// import 'package:appnaturisa/screens/josefina/antenas_info_state.dart';
// import 'package:appnaturisa/screens/josefina/info_ps_on_off_screen.dart';
// import 'package:appnaturisa/screens/josefina/selec_horario_screen.dart';
// import 'package:appnaturisa/services/storage_service.dart';
// import 'package:appnaturisa/widgets/headers.dart';
// import 'package:appnaturisa/widgets/internet_check.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
//   List<dynamic> apiDataList = [];
//   bool firstLoad = true;
//   int _currentIndex = 0;
//   bool _showMapLabels = false;

//   final List<String> imgList = [
//     'assets/imageAntena.png',
//     'assets/iii.png',
//     'assets/image3.jpg',
//   ];

//   Future<void> _refreshData() async {
//     // Simula la recarga de datos
//     await Future.delayed(Duration(seconds: 2));
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<PiscinasJosefinaProvider>(context, listen: false)
//           .reconnectIfNeeded();

//       if (!Provider.of<PiscinasJosefinaProvider>(context, listen: false)
//           .hasError) {
//         if (firstLoad) {
//           if (PiscinasJosefinaProvider.channel != null) {
//             Provider.of<PiscinasJosefinaProvider>(context, listen: false)
//                 .subscribePiscinasAntenasAndInfoGeneral();
//           }
//           setState(() {
//             firstLoad = false;
//           });
//         }
//       }

//       // Mostrar etiquetas del mapa después de un delay para efecto visual
//       Future.delayed(Duration(milliseconds: 800), () {
//         if (mounted) {
//           setState(() {
//             _showMapLabels = true;
//           });
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     firstLoad = true;

//     WidgetsBinding.instance.removeObserver(this);
//     if (PiscinasJosefinaProvider.channel != null) {
//       PiscinasJosefinaProvider.channel!.sink.add('unsubscribeAntenas');
//       PiscinasJosefinaProvider.subscriptionAntenas?.cancel();
//       PiscinasJosefinaProvider.subscriptionAntenas = null;
//       PiscinasJosefinaProvider.channel!.sink.add('unsubscribeInfoGeneralPS');
//       PiscinasJosefinaProvider.subscriptionInfoGeneralPis?.cancel();
//       PiscinasJosefinaProvider.subscriptionInfoGeneralPis = null;
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: size.height,
//             width: size.width,
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 255, 255, 255),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(28),
//                 bottomRight: Radius.circular(28),
//               ),
//             ),
//           ),
//           const HeaderWave(),

//           // Fondo del mapa con opacidad
//           Positioned(
//             top: size.height * 0.08,
//             left: size.width * 0.5,
//             child: Transform.rotate(
//               angle: -20 * 3.14159265359 / 90,
//               child: Image.asset(
//                 'assets/plano_josefina.png',
//                 width: size.width * 0.58,
//                 height: size.height * 0.30,
//                 color: const Color.fromRGBO(255, 255, 255, 0.1),
//               ),
//             ),
//           ),

//           // Dashboard central
//           Positioned(
//             top: size.height * 0.32,
//             left: 0,
//             right: 0,
//             child: Consumer<PiscinasJosefinaProvider>(
//               builder: (context, provider, _) {
//                 return _buildSimpleDashboard(
//                     context, provider.apiDataListInfoGeneralPis);
//               },
//             ),
//           ),

//           // Título de la sección de acceso rápido
//           Positioned(
//             top: size.height * 0.591,
//             left: size.width * 0.07,
//             right: 0,
//             child: Text(
//               'Acceso rápido',
//               style: GoogleFonts.anton(
//                 fontSize: 20,
//                 color: Colors.black,
//               ),
//             ),
//           ),

//           // Sección de acceso rápido
//           InternetChecker(
//             child: RefreshIndicator(
//               onRefresh: _refreshData,
//               child: Positioned(
//                 top: size.height * 0.658,
//                 left: 0,
//                 right: 0,
//                 child: Consumer<PiscinasJosefinaProvider>(
//                   builder: (context, antenaProvider, child) {
//                     apiDataList = antenaProvider.apiDataListInfoGeneralPis;

//                     if (PiscinasJosefinaProvider.isLoading2) {
//                       return _buildShimmerLoading(size);
//                     } else if (antenaProvider.hasError) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.wifi_off_outlined,
//                                 size: 60, color: Colors.red),
//                             SizedBox(height: 16),
//                             Text("Error de conexión",
//                                 style: TextStyle(color: Colors.red)),
//                           ],
//                         ),
//                       );
//                     }

//                     // Verificar si los datos están completos para evitar errores de renderizado
//                     bool hasCompleteData = _verifyCompleteData(apiDataList);
//                     if (!hasCompleteData) {
//                       return _buildShimmerLoading(size);
//                     }

//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           SizedBox(
//                             width: size.width * 0.07,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 PageRouteBuilder(
//                                   pageBuilder: (context, animation,
//                                           secondaryAnimation) =>
//                                       const InfoPSOnOffScreen(),
//                                   transitionsBuilder: (context, animation,
//                                       secondaryAnimation, child) {
//                                     return SlideTransition(
//                                       position: Tween<Offset>(
//                                         begin: const Offset(0.0, 1.0),
//                                         end: Offset.zero,
//                                       ).animate(animation),
//                                       child: child,
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               height: size.height * 0.2,
//                               width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.grey,
//                                   width: 1.0,
//                                 ),
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(25)),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Icon(
//                                       Icons.waves,
//                                       color: Colors.black,
//                                       size: 40,
//                                     ),
//                                     const SizedBox(height: 20),
//                                     Text(
//                                       'Piscinas',
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     Text(
//                                       _getSafeValue(apiDataList, 1, 0,
//                                           "PiscinasOn", "encendidas"),
//                                       style: TextStyle(
//                                         color: Color.fromRGBO(23, 223, 106, 1),
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: size.width * 0.045,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 PageRouteBuilder(
//                                   pageBuilder: (context, animation,
//                                           secondaryAnimation) =>
//                                       const AntenasInfoStateScreen(),
//                                   transitionsBuilder: (context, animation,
//                                       secondaryAnimation, child) {
//                                     return SlideTransition(
//                                       position: Tween<Offset>(
//                                         begin: const Offset(0.0, 1.0),
//                                         end: Offset.zero,
//                                       ).animate(animation),
//                                       child: child,
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               height: size.height * 0.2,
//                               width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.grey,
//                                   width: 1.0,
//                                 ),
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(25)),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Icon(
//                                       Icons.rss_feed,
//                                       color: Colors.black,
//                                       size: 40,
//                                     ),
//                                     const SizedBox(height: 20),
//                                     Text(
//                                       'Antenas',
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     Text(
//                                       _getSafeValue(apiDataList, 3, 0,
//                                           "AntenasOff", "sin señal"),
//                                       style: TextStyle(
//                                         color: Color.fromRGBO(23, 223, 106, 1),
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: size.width * 0.045,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 PageRouteBuilder(
//                                   pageBuilder: (context, animation,
//                                           secondaryAnimation) =>
//                                       const SelecHorarioScreen(),
//                                   transitionsBuilder: (context, animation,
//                                       secondaryAnimation, child) {
//                                     return SlideTransition(
//                                       position: Tween<Offset>(
//                                         begin: const Offset(0.0, 1.0),
//                                         end: Offset.zero,
//                                       ).animate(animation),
//                                       child: child,
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               height: size.height * 0.2,
//                               width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.grey,
//                                   width: 1.0,
//                                 ),
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(25)),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Icon(
//                                       Icons.access_alarm,
//                                       color: Colors.black,
//                                       size: 40,
//                                     ),
//                                     const SizedBox(height: 20),
//                                     Text(
//                                       'Horario',
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Global',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: size.width * 0.07,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),

//           // AppBar personalizado
//           Positioned(
//             top: size.height * 0.066,
//             left: 0,
//             right: 0,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // IconButton(
//                       //   icon: Icon(Icons.arrow_back, color: Colors.white),
//                       //   onPressed: () {
//                       //     Navigator.pop(context);
//                       //   },
//                       // ),
//                       GestureDetector(
//                         onTap: () => _showAvatarDialog(context),
//                         child: CircleAvatar(
//                           radius: 30,
//                           backgroundColor:
//                               const Color.fromRGBO(201, 202, 203, 0.9),
//                           backgroundImage:
//                               StorageService.prefs.getString('profileImage') !=
//                                       null
//                                   ? FileImage(File(StorageService.prefs
//                                       .getString('profileImage')!))
//                                   : null,
//                           child:
//                               StorageService.prefs.getString('profileImage') ==
//                                       null
//                                   ? Text(
//                                       "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
//                                       style: GoogleFonts.roboto(fontSize: 12),
//                                     )
//                                   : null,
//                         ),
//                       ),
//                       Text(
//                         "Josefina",
//                         style: GoogleFonts.roboto(
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // NUEVO MÉTODO: Dashboard simple pero elegante
//   Widget _buildSimpleDashboard(
//       BuildContext context, List<dynamic> apiDataList) {
//     final size = MediaQuery.of(context).size;

//     // Obtener datos de forma segura
//     int piscinasOn = _getSafeValueAsInt(apiDataList, 1, 0, "PiscinasOn", 0);
//     int piscinasTotal =
//         _getSafeValueAsInt(apiDataList, 1, 0, "PiscinasTotal", 71);
//     int antenasOff = _getSafeValueAsInt(apiDataList, 3, 0, "AntenasOff", 0);
//     int antenasTotal =
//         _getSafeValueAsInt(apiDataList, 3, 0, "AntenasTotal", 96);

//     return Container(
//       width: size.width * 0.9,
//       height: size.height * 0.22,
//       margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Título del panel
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.dashboard_rounded,
//                   size: 18,
//                   color: const Color.fromARGB(255, 4, 63, 122),
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   'Estado del Sistema',
//                   style: GoogleFonts.roboto(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: const Color.fromARGB(255, 4, 63, 122),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Línea divisoria
//           Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.2)),

//           // Contenido principal - 2 filas con información
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Primera fila: Piscinas y Antenas
//                   Row(
//                     children: [
//                       // Piscinas info
//                       Expanded(
//                         child: _buildSimpleInfoItem(
//                           icon: Icons.waves,
//                           title: 'Piscinas Activas',
//                           value: '$piscinasOn/$piscinasTotal',
//                           color: Colors.blue,
//                         ),
//                       ),

//                       // Separador vertical
//                       Container(
//                         height: 40,
//                         width: 1,
//                         color: Colors.grey.withOpacity(0.3),
//                         margin: EdgeInsets.symmetric(horizontal: 15),
//                       ),

//                       // Antenas info
//                       Expanded(
//                         child: _buildSimpleInfoItem(
//                           icon: Icons.network_wifi,
//                           title: 'Antenas Operativas',
//                           value: '${antenasTotal - antenasOff}/$antenasTotal',
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Segunda fila: Estado general y Última actualización
//                   Row(
//                     children: [
//                       // Estado del sistema
//                       Expanded(
//                         child: _buildSimpleInfoItem(
//                           icon: Icons.check_circle_outline,
//                           title: 'Estado General',
//                           value: 'Operativo',
//                           color: Colors.green,
//                           showDot: true,
//                         ),
//                       ),

//                       // Separador vertical
//                       Container(
//                         height: 40,
//                         width: 1,
//                         color: Colors.grey.withOpacity(0.3),
//                         margin: EdgeInsets.symmetric(horizontal: 15),
//                       ),

//                       // Última actualización
//                       Expanded(
//                         child: _buildSimpleInfoItem(
//                           icon: Icons.update,
//                           title: 'Actualizado',
//                           value: 'Hace 5 min',
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget auxiliar para cada elemento de información
//   Widget _buildSimpleInfoItem({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color color,
//     bool showDot = false,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: color,
//             size: 16,
//           ),
//         ),
//         SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 10,
//                   color: Colors.black54,
//                 ),
//               ),
//               SizedBox(height: 2),
//               Row(
//                 children: [
//                   Text(
//                     value,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   if (showDot) ...[
//                     SizedBox(width: 4),
//                     Container(
//                       width: 6,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Obtiene un valor entero de forma segura
//   int _getSafeValueAsInt(List<dynamic> dataList, int outerIndex, int innerIndex,
//       String key, int defaultValue) {
//     try {
//       if (dataList.isNotEmpty &&
//           dataList.length > outerIndex &&
//           dataList[outerIndex].isNotEmpty &&
//           dataList[outerIndex].length > innerIndex &&
//           dataList[outerIndex][innerIndex] != null &&
//           dataList[outerIndex][innerIndex].containsKey(key)) {
//         return int.tryParse(dataList[outerIndex][innerIndex][key].toString()) ??
//             defaultValue;
//       }
//     } catch (e) {
//       print("Error obteniendo valor entero: $e");
//     }
//     return defaultValue;
//   }

//   // Método para verificar si todos los datos necesarios están disponibles
//   bool _verifyCompleteData(List<dynamic> dataList) {
//     if (dataList.isEmpty) return false;

//     // Verifica que existan los índices que usas
//     if (dataList.length < 4) return false;

//     // Verifica que cada nivel tenga la estructura esperada
//     try {
//       // Verifica el primer acceso (piscinas)
//       if (dataList[1].isEmpty ||
//           dataList[1][0] == null ||
//           !dataList[1][0].containsKey("PiscinasOn")) {
//         return false;
//       }

//       // Verifica el segundo acceso (antenas)
//       if (dataList[3].isEmpty ||
//           dataList[3][0] == null ||
//           !dataList[3][0].containsKey("AntenasOff")) {
//         return false;
//       }

//       return true;
//     } catch (e) {
//       print("Error verificando datos: $e");
//       return false;
//     }
//   }

//   // Método para recuperar de forma segura los valores
//   String _getSafeValue(List<dynamic> dataList, int outerIndex, int innerIndex,
//       String key, String suffix) {
//     try {
//       if (dataList.isNotEmpty &&
//           dataList.length > outerIndex &&
//           dataList[outerIndex].isNotEmpty &&
//           dataList[outerIndex].length > innerIndex &&
//           dataList[outerIndex][innerIndex] != null &&
//           dataList[outerIndex][innerIndex].containsKey(key)) {
//         return "${dataList[outerIndex][innerIndex][key]} $suffix";
//       }
//     } catch (e) {
//       print("Error obteniendo valor seguro: $e");
//     }
//     return "---- $suffix";
//   }

//   // Método para construir los contenedores de shimmer loading
//   Widget _buildShimmerLoading(Size size) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(width: size.width * 0.07),
//           ShimmerContainer(title: 'Piscinas'),
//           SizedBox(width: size.width * 0.045),
//           ShimmerContainer(title: 'Antenas'),
//           SizedBox(width: size.width * 0.045),
//           ShimmerContainer(title: 'Horario'),
//           SizedBox(width: size.width * 0.07),
//         ],
//       ),
//     );
//   }

//   void _showAvatarDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             child: Center(
//               child: CircleAvatar(
//                 radius: 100,
//                 backgroundColor: const Color.fromRGBO(201, 202, 203, 0.9),
//                 backgroundImage: StorageService.prefs
//                             .getString('profileImage') !=
//                         null
//                     ? FileImage(
//                         File(StorageService.prefs.getString('profileImage')!))
//                     : null,
//                 child: StorageService.prefs.getString('profileImage') == null
//                     ? Text(
//                         "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
//                         style: const TextStyle(fontSize: 40),
//                       )
//                     : null,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class ShimmerContainer extends StatelessWidget {
//   final String title;

//   const ShimmerContainer({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         height: size.height * 0.2,
//         width: size.width * 0.4,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Center(
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
