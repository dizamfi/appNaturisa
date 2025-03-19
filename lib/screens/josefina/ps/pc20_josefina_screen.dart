// // import 'package:animate_do/animate_do.dart';

// // import 'package:appsantapriscila/providers/ps_california_provider.dart';
// // import 'package:appsantapriscila/screens/california/aireacion/screens/help_piscina_california_screen.dart';
// // import 'package:appsantapriscila/screens/construction_screen.dart';
// // import 'package:appsantapriscila/services/storage_service.dart';
// // import 'package:appsantapriscila/widgets/card_tablero_aire.dart';
// // import 'package:appsantapriscila/widgets/shimmer_loading%20.dart';
// import 'package:appnaturisa/providers/ps_josefina_provider.dart';
// import 'package:appnaturisa/screens/josefina/ps/help_piscina_josefina_screen.dart';
// import 'package:appnaturisa/utils/data_access_utils.dart';
// import 'package:appnaturisa/widgets/card_tablero_aire.dart';
// import 'package:appnaturisa/widgets/control_remoto.dart';
// import 'package:appnaturisa/widgets/headers.dart';
// import 'package:appnaturisa/widgets/info_general_ps.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:provider/provider.dart';

// import '../../../../widgets/slideshow.dart';

// class PC20JosefinaScreen extends StatefulWidget {
//   const PC20JosefinaScreen({super.key});

//   @override
//   State<PC20JosefinaScreen> createState() => _PC20JosefinaScreenState();
// }

// class _PC20JosefinaScreenState extends State<PC20JosefinaScreen>
//     with WidgetsBindingObserver {
//   List<dynamic> apiDataList = [];
//   bool firstLoad = true;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<PiscinasJosefinaProvider>(context, listen: false)
//           .reconnectIfNeeded();
//       if (firstLoad) {
//         // Espera a que el canal WebSocket esté inicializado
//         if (PiscinasJosefinaProvider.channel != null) {
//           // EbProvider.channel!.sink.add('subscribe1B');
//           Provider.of<PiscinasJosefinaProvider>(context, listen: false)
//               .subscribePC20();
//           // print('Suscripción a SD realizada.');
//         }
//         setState(() {
//           firstLoad = false;
//         });
//       }
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // Intentar reconectar si es necesario cuando los dependientes cambian
//     Provider.of<PiscinasJosefinaProvider>(context, listen: false)
//         .reconnectIfNeeded();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       // La app está en segundo plano
//       PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPC20');
//     } else if (state == AppLifecycleState.resumed) {
//       // La app volvió al primer plano
//       if (PiscinasJosefinaProvider.channel != null) {
//         // EbProvider.channel!.sink.add('subscribe1B');
//         Provider.of<PiscinasJosefinaProvider>(context, listen: false)
//             .subscribePC20();
//         // print('Suscripción a SD realizada.');
//       }
//     }
//   }

//   @override
//   void dispose() {
//     firstLoad = true;
//     WidgetsBinding.instance.removeObserver(this);
//     PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPC20');
//     PiscinasJosefinaProvider.subscriptionPC20?.cancel();
//     PiscinasJosefinaProvider.subscriptionPC20 = null;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return PopScope(
//       canPop: true, // Si quieres controlar si se permite o no el retroceso
//       onPopInvokedWithResult: (bool didPop, Object? result) async {},
//       child: PopScope(
//         canPop: true, // Si quieres controlar si se permite o no el retroceso
//         onPopInvokedWithResult: (bool didPop, Object? result) async {
//           if (mounted) {
//             // StorageService.saveFlag(true, 'FlagAireCali');
//             // Ejecutar el código después de que el frame actual termine de renderizar
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               final provider =
//                   Provider.of<PiscinasJosefinaProvider>(context, listen: false);

//               // Intentar reconectar si es necesario
//               provider.reconnectIfNeeded();

//               // Verifica si el canal WebSocket está inicializado
//               if (PiscinasJosefinaProvider.channel != null) {
//                 // provider.subscribePiscinasInfoGeneralGraca();

//                 // print('Suscripción a SD realizada.');
//               }
//             });

//             Navigator.canPop(context);
//           }
//         },
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           extendBodyBehindAppBar: true,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent, // Fondo transparente
//             elevation: 0, // Sin sombra
//             scrolledUnderElevation: 0,
//             toolbarHeight: 80, // Ajusta la altura según sea necesario
//             centerTitle: true,
//             automaticallyImplyLeading:
//                 false, // Evita el botón de regreso predeterminado
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context); // Función para regresar
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//                     // height: 200,
//                     height: size.height * 0.1,
//                     // width: 30,
//                     width: size.width * 0.083,
//                     // color: Colors.amber,
//                     child: const Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       size: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 50),
//                   child: Text(
//                     'Precria 20',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             const HelpPiscinaJosefinaScreen(),
//                         transitionsBuilder:
//                             (context, animation, secondaryAnimation, child) {
//                           return SlideTransition(
//                             position: Tween<Offset>(
//                               begin: const Offset(0.0, 1.0),
//                               end: Offset.zero,
//                             ).animate(animation),
//                             child: child,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//                     // height: 200,
//                     height: size.height * 0.1,
//                     // width: 30,
//                     width: size.width * 0.083,
//                     child: const Icon(
//                       Icons.help_outline_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           body: Consumer<PiscinasJosefinaProvider>(
//               builder: (context, ebProvider, child) {
//             apiDataList = ebProvider.apiDataListPC20;

//             // Verificar si el proveedor tiene error
//             if (ebProvider.hasError) {
//               return ErrorScreen(
//                 message: 'Error de conexión: ${ebProvider.errorMessage}',
//                 onRetry: () => ebProvider.subscribePC20(),
//               );
//             }

//             // Verificar si está cargando
//             if (PiscinasJosefinaProvider.isLoading2) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: Color.fromARGB(255, 4, 63, 122),
//                 ),
//               );
//             }

//             // Verificar que los datos estén completos
//             bool datosCompletos =
//                 DataAccessUtils.areDataComplete(apiDataList, [3]);

//             if (!datosCompletos || apiDataList.isEmpty) {
//               return ErrorScreen(
//                 message: 'Datos incompletos o en sincronización',
//                 onRetry: () => ebProvider.subscribePC20(),
//               );
//             }

//             return Stack(
//               children: [
//                 // Container(
//                 //   height: 200,
//                 //   width: MediaQuery.of(context).size.width,
//                 //   decoration: const BoxDecoration(
//                 //       // color: Color(0xFF212121), // Negro
//                 //       // color: Color.fromRGBO(18, 34, 23, 0.859),
//                 //       // color: Color.fromRGBO(1, 39, 8, 0.9),
//                 //       color: Color.fromRGBO(18, 34, 23, 0.859),
//                 //       borderRadius: BorderRadius.only(
//                 //           bottomLeft: Radius.circular(20),
//                 //           bottomRight: Radius.circular(20))),
//                 // ),

//                 const Positioned(top: -100, left: 0, child: PinkBox()),

//                 // Positioned(
//                 //   top: 60,
//                 //   left: 0,
//                 //   right: 0,
//                 //   child: Row(
//                 //     crossAxisAlignment: CrossAxisAlignment.center,
//                 //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 //     children: const [
//                 //       Icon(
//                 //         Icons.arrow_back_ios_new_rounded,
//                 //         size: 18,
//                 //         color: Colors.white,
//                 //       ),
//                 //       const Text(
//                 //         'Piscina 22A',
//                 //         style: TextStyle(
//                 //             fontSize: 18,
//                 //             color: Colors.white,
//                 //             fontWeight: FontWeight.bold),
//                 //       ),
//                 //       Icon(
//                 //         Icons.history,
//                 //         color: Colors.white,
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),

//                 // Positioned(top: 400, left: -30, child: PinkBox()),
//                 PiscinasJosefinaProvider.isLoading2
//                     ? const Center(
//                         child: CircularProgressIndicator(
//                           color: Color.fromARGB(255, 4, 63, 122),
//                         ),
//                       )
//                     : SafeArea(
//                         child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 2, right: 2, top: 0, bottom: 0),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   // Barra superior

//                                   const Text(
//                                     'Tableros',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Container(
//                                     constraints: BoxConstraints(
//                                         minWidth: 100,
//                                         maxWidth:
//                                             MediaQuery.of(context).size.width *
//                                                 0.99,
//                                         // maxHeight: MediaQuery.of(context).size.height * 0.335,
//                                         minHeight: 100),
//                                     // width: 160,

//                                     // width: 400,
//                                     height: 274,

//                                     child: SlideShow(
//                                         bulletPrimario: 10,
//                                         bulletSecundario: 8,
//                                         colorPrimario: const Color.fromARGB(
//                                             255, 4, 63, 122),
//                                         slides: [
//                                           CardTableroAire(
//                                             tablero: 'TA20-1',
//                                             numCircuito: 3,
//                                             sizeCirc: 18,
//                                             numAirOn:
//                                                 DataAccessUtils.getNestedValue(
//                                                     apiDataList,
//                                                     [0, 0, "Num_Air_On"],
//                                                     0),
//                                             statComm:
//                                                 DataAccessUtils.getNestedValue(
//                                                     apiDataList,
//                                                     [
//                                                       1,
//                                                       0,
//                                                       "TA_20_01.Stat_Comm"
//                                                     ],
//                                                     false),
//                                             imputsLN:
//                                                 DataAccessUtils.getNestedValue(
//                                                     apiDataList,
//                                                     [1, 0, "TA_20_01.Inputs"],
//                                                     0),
//                                           ),
//                                         ]),
//                                   ),

//                                   const SizedBox(
//                                     height: 15,
//                                   ),

//                                   const Text(
//                                     'General Piscina',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold),
//                                   ),

//                                   Container(
//                                     constraints: BoxConstraints(
//                                         minWidth: 100,
//                                         maxWidth:
//                                             MediaQuery.of(context).size.width *
//                                                 0.98,
//                                         // maxHeight: MediaQuery.of(context).size.height * 0.335,
//                                         minHeight: 100),
//                                     // width: 160,

//                                     // width: 400,
//                                     height: 240,

//                                     child: SlideShow(
//                                         bulletPrimario: 10,
//                                         bulletSecundario: 8,
//                                         colorPrimario: const Color.fromARGB(
//                                             255, 4, 63, 122),
//                                         slides: [
//                                           ControlRemoto(
//                                             apiDataList: apiDataList,
//                                           ),
//                                           InfoGeneralPS(
//                                             apiDataList: apiDataList,
//                                           ),
//                                         ]),
//                                   ),

//                                   const Text(
//                                     'Comunicaciones',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),

//                                   Container(
//                                     constraints: BoxConstraints(
//                                         minWidth: 100,
//                                         maxWidth:
//                                             MediaQuery.of(context).size.width *
//                                                 0.9,
//                                         // maxHeight: MediaQuery.of(context).size.height * 0.335,
//                                         minHeight: 100),
//                                     // width: 330,
//                                     height: 100,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(1),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(20)),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                             color: Color.fromRGBO(9, 31, 72, 1),
//                                             blurRadius: 3,
//                                           )
//                                         ]),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         const Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Text(
//                                               'TA20-1',
//                                               style: TextStyle(
//                                                   // fontSize: 20,
//                                                   color: Color.fromRGBO(
//                                                       9, 31, 72, 1),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             _buildStatusIcon(
//                                                 DataAccessUtils.getNestedValue(
//                                                     apiDataList,
//                                                     [2, 0, 'Stat_TA20-1'],
//                                                     false)),
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             _buildSignalIcon(
//                                                 DataAccessUtils.getNestedValue(
//                                                     apiDataList,
//                                                     [2, 0, 'Pot_TA20-1'],
//                                                     -100)),
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Text(DataAccessUtils.getNestedValue(
//                                                     apiDataList,
//                                                     [2, 0, 'Pot_TA20-1'],
//                                                     0)
//                                                 .toString()),
//                                           ],
//                                         ),
//                                         Image.asset('assets/antenaIcono.png',
//                                             width: 70, height: 70)
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 15,
//                                   ),
//                                 ],
//                               ),
//                             )),
//                       ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// // Método auxiliar para el icono de estado
// Widget _buildStatusIcon(bool isActive) {
//   return isActive
//       ? const Icon(Icons.check_circle, color: Colors.green)
//       : const Icon(Icons.close_rounded, color: Colors.red);
// }

// // Método auxiliar para el icono de señal
// Widget _buildSignalIcon(int potencia) {
//   if (potencia >= -67) {
//     return const Icon(Icons.network_wifi, color: Colors.green);
//   } else if (potencia <= -68 && potencia >= -79) {
//     return const Icon(Icons.network_wifi, color: Colors.orangeAccent);
//   } else if (potencia <= -80) {
//     return const Icon(Icons.network_wifi, color: Colors.red);
//   } else {
//     return const Text('');
//   }
// }

import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/screens/josefina/ps/help_piscina_josefina_screen.dart';
import 'package:appnaturisa/utils/data_access_utils.dart';
import 'package:appnaturisa/widgets/card_tablero_aire.dart';
import 'package:appnaturisa/widgets/control_remoto.dart';
import 'package:appnaturisa/widgets/headers.dart';
import 'package:appnaturisa/widgets/info_general_ps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/slideshow.dart';

class PC20JosefinaScreen extends StatefulWidget {
  const PC20JosefinaScreen({super.key});

  @override
  State<PC20JosefinaScreen> createState() => _PC20JosefinaScreenState();
}

class _PC20JosefinaScreenState extends State<PC20JosefinaScreen>
    with WidgetsBindingObserver {
  List<dynamic> apiDataList = [];
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .reconnectIfNeeded();
      if (firstLoad) {
        if (PiscinasJosefinaProvider.channel != null) {
          Provider.of<PiscinasJosefinaProvider>(context, listen: false)
              .subscribePC20();
          debugPrint('[PC20] Suscripción inicial realizada');
        }
        setState(() {
          firstLoad = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<PiscinasJosefinaProvider>(context, listen: false)
        .reconnectIfNeeded();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      if (PiscinasJosefinaProvider.channel != null) {
        PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPC20');
        debugPrint('[PC20] Cancelando suscripción (app en segundo plano)');
      }
    } else if (state == AppLifecycleState.resumed) {
      if (PiscinasJosefinaProvider.channel != null) {
        Provider.of<PiscinasJosefinaProvider>(context, listen: false)
            .subscribePC20();
        debugPrint('[PC20] Resuscripción al volver a primer plano');
      }
    }
  }

  @override
  void dispose() {
    firstLoad = true;
    WidgetsBinding.instance.removeObserver(this);
    if (PiscinasJosefinaProvider.channel != null) {
      PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPC20');
      debugPrint('[PC20] Cancelando suscripción (dispose)');
    }
    PiscinasJosefinaProvider.subscriptionPC20?.cancel();
    PiscinasJosefinaProvider.subscriptionPC20 = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {},
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final provider =
                  Provider.of<PiscinasJosefinaProvider>(context, listen: false);
              provider.reconnectIfNeeded();
            });
            Navigator.canPop(context);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: 80,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: size.height * 0.1,
                    width: size.width * 0.083,
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Precria 20',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HelpPiscinaJosefinaScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                    color: Colors.transparent,
                    height: size.height * 0.1,
                    width: size.width * 0.083,
                    child: const Icon(
                      Icons.help_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              // PinkBox siempre visible
              const Positioned(top: -110, left: 0, child: PinkBox()),

              // Contenido que depende de los datos
              SafeArea(
                child: Consumer<PiscinasJosefinaProvider>(
                  builder: (context, ebProvider, child) {
                    apiDataList = ebProvider.apiDataListPC20;

                    // Verificar si el proveedor tiene error
                    if (ebProvider.hasError) {
                      return Center(
                        child: ErrorScreen(
                          message:
                              'Error de conexión: ${ebProvider.errorMessage}',
                          onRetry: () => ebProvider.subscribePC20(),
                        ),
                      );
                    }

                    // Verificar si está cargando
                    if (PiscinasJosefinaProvider.isLoading2) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 4, 63, 122),
                        ),
                      );
                    }

                    // Verificar que los datos estén completos
                    bool datosCompletos = apiDataList.length >= 3 &&
                        (apiDataList[0]?.isNotEmpty ?? false) &&
                        (apiDataList[1]?.isNotEmpty ?? false) &&
                        (apiDataList[2]?.isNotEmpty ?? false);

                    if (!datosCompletos) {
                      return Center(
                        child: ErrorScreen(
                          message: 'Datos incompletos o en sincronización',
                          onRetry: () => ebProvider.subscribePC20(),
                        ),
                      );
                    }

                    // Si los datos están completos, mostramos todo el contenido
                    return Column(
                      children: [
                        // Texto "Tableros" (ahora solo visible cuando los datos están cargados)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Tableros',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Contenido principal
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2, right: 2, top: 0, bottom: 0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.99,
                                      minHeight: 100,
                                    ),
                                    height: 274,
                                    child: SlideShow(
                                      bulletPrimario: 10,
                                      bulletSecundario: 8,
                                      colorPrimario:
                                          const Color.fromARGB(255, 4, 63, 122),
                                      slides: [
                                        CardTableroAire(
                                          tablero: 'TA20-1',
                                          numCircuito: 3,
                                          sizeCirc: 18,
                                          numAirOn:
                                              DataAccessUtils.getNestedValue(
                                                  apiDataList,
                                                  [0, 0, "Num_Air_On"],
                                                  0),
                                          statComm:
                                              DataAccessUtils.getNestedValue(
                                                  apiDataList,
                                                  [1, 0, "TA_20_01.Stat_Comm"],
                                                  false),
                                          imputsLN:
                                              DataAccessUtils.getNestedValue(
                                                  apiDataList,
                                                  [1, 0, "TA_20_01.Inputs"],
                                                  0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'General Piscina',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.98,
                                      minHeight: 100,
                                    ),
                                    height: 240,
                                    child: SlideShow(
                                      bulletPrimario: 10,
                                      bulletSecundario: 8,
                                      colorPrimario:
                                          const Color.fromARGB(255, 4, 63, 122),
                                      slides: [
                                        ControlRemoto(
                                          apiDataList: apiDataList,
                                        ),
                                        InfoGeneralPS(
                                          apiDataList: apiDataList,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    'Comunicaciones',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                      minHeight: 100,
                                    ),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(1),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(9, 31, 72, 1),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'TA20-1',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    9, 31, 72, 1),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildStatusIcon(
                                              DataAccessUtils.getNestedValue(
                                                  apiDataList,
                                                  [2, 0, 'Stat_TA20-1'],
                                                  false),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildSignalIcon(
                                              DataAccessUtils.getNestedValue(
                                                  apiDataList,
                                                  [2, 0, 'Pot_TA20-1'],
                                                  -100),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              DataAccessUtils.getNestedValue(
                                                      apiDataList,
                                                      [2, 0, 'Pot_TA20-1'],
                                                      0)
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                        Image.asset('assets/antenaIcono.png',
                                            width: 70, height: 70),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Método auxiliar para el icono de estado
Widget _buildStatusIcon(bool isActive) {
  return isActive
      ? const Icon(Icons.check_circle, color: Colors.green)
      : const Icon(Icons.close_rounded, color: Colors.red);
}

// Método auxiliar para el icono de señal
Widget _buildSignalIcon(int potencia) {
  if (potencia >= -67) {
    return const Icon(Icons.network_wifi, color: Colors.green);
  } else if (potencia <= -68 && potencia >= -79) {
    return const Icon(Icons.network_wifi, color: Colors.orangeAccent);
  } else if (potencia <= -80) {
    return const Icon(Icons.network_wifi, color: Colors.red);
  } else {
    return const Text('');
  }
}

// Clase ErrorScreen incluida para referencia
class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorScreen({
    Key? key,
    this.message = 'Datos incompletos o en sincronización',
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning_amber_rounded, size: 50, color: Colors.amber),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 4, 63, 122),
              foregroundColor: Colors.white,
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ],
    );
  }
}
