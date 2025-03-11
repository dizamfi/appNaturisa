// import 'package:appgraca/providers/ps_graca_provider.dart';
// import 'package:appgraca/widgets/network_animated.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AntenasInfoStateScreen extends StatefulWidget {
//   const AntenasInfoStateScreen({super.key});

//   @override
//   State<AntenasInfoStateScreen> createState() => _AntenasInfoStateScreenState();
// }

// class _AntenasInfoStateScreenState extends State<AntenasInfoStateScreen>
//     with WidgetsBindingObserver {
//   List<dynamic> apiDataList = [];
//   bool firstLoad = true;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<PiscinasGracaProvider>(context, listen: false)
//           .reconnectIfNeeded();
//       if (firstLoad) {
//         // Espera a que el canal WebSocket esté inicializado
//         if (PiscinasGracaProvider.channel != null) {
//           // EbProvider.channel!.sink.add('subscribe1B');
//           Provider.of<PiscinasGracaProvider>(context, listen: false)
//               .subscribePiscinasAntenas();
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
//     Provider.of<PiscinasGracaProvider>(context, listen: false)
//         .reconnectIfNeeded();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       // La app está en segundo plano
//       PiscinasGracaProvider.channel!.sink.add('unsubscribeAntenas');
//     } else if (state == AppLifecycleState.resumed) {
//       // La app volvió al primer plano
//       if (PiscinasGracaProvider.channel != null) {
//         // EbProvider.channel!.sink.add('subscribe1B');
//         Provider.of<PiscinasGracaProvider>(context, listen: false)
//             .subscribePiscinasAntenas();
//         // print('Suscripción a SD realizada.');
//       }
//     }
//   }

//   @override
//   void dispose() {
//     firstLoad = true;
//     WidgetsBinding.instance.removeObserver(this);
//     PiscinasGracaProvider.channel!.sink.add('unsubscribeAntenas');
//     PiscinasGracaProvider.subscriptionAntenas?.cancel();
//     PiscinasGracaProvider.subscriptionAntenas = null;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent, // Fondo transparente
//         elevation: 0, // Sin sombra
//         scrolledUnderElevation: 0,
//         toolbarHeight: 80, // Ajusta la altura según sea necesario
//         centerTitle: true,
//         automaticallyImplyLeading:
//             false, // Evita el botón de regreso predeterminado
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context); // Función para regresar
//               },
//               child: const SizedBox(
//                 height: 30,
//                 width: 30,
//                 // color: Colors.amber,
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   size: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 50),
//               child: Text(
//                 'Estado antenas',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                   // fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//               width: 30,
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 25,
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 // Primera instancia de NetworkAnimated
//                 // Ajusta el tamaño según sea necesario
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                   height: 195,
//                   width: 400,
//                   decoration: BoxDecoration(
//                     // color: Colors.amber,
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 1.0,
//                     ),
//                     borderRadius: const BorderRadius.all(Radius.circular(25)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'PS039',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       const Text('TA 01'),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const NetworkAnimated(
//                         signal: false,
//                       ),
//                       const Text('TA 02'),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const NetworkAnimated(
//                         signal: true,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                   height: 195,
//                   width: 400,
//                   decoration: BoxDecoration(
//                     // color: Colors.amber,
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 1.0,
//                     ),
//                     borderRadius: const BorderRadius.all(Radius.circular(25)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'PS039',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       const Text('TA 01'),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const NetworkAnimated(
//                         signal: true,
//                       ),
//                       const Text('TA 02'),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const NetworkAnimated(
//                         signal: false,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                   height: 195,
//                   width: 400,
//                   decoration: BoxDecoration(
//                     // color: Colors.amber,
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 1.0,
//                     ),
//                     borderRadius: const BorderRadius.all(Radius.circular(25)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'PS039',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       const Text('TA 01'),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const NetworkAnimated(
//                         signal: false,
//                       ),
//                       const Text('TA 02'),
//                       Container(
//                         height: 1,
//                         width: double.infinity,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const NetworkAnimated(
//                         signal: true,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Agrega más instancias si lo deseas
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/widgets/network_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AntenasInfoStateScreen extends StatefulWidget {
  const AntenasInfoStateScreen({super.key});

  @override
  State<AntenasInfoStateScreen> createState() => _AntenasInfoStateScreenState();
}

class _AntenasInfoStateScreenState extends State<AntenasInfoStateScreen>
    with WidgetsBindingObserver {
  List<Map<String, dynamic>> filteredData = [];
  bool firstLoad = true;

  // List<Map<String, dynamic>> processAndFilterData(List<dynamic> data) {
  //   if (data.isEmpty) {
  //     return [];
  //   }

  //   // Mapa temporal para agrupar tableros por piscina
  //   Map<String, List<Map<String, dynamic>>> groupedData = {};
  //   List<Map<String, dynamic>> specialTableros =
  //       []; // Lista para tableros PTP y AP

  //   for (var item in data[2]) {
  //     item.forEach((key, value) {
  //       if (key is String && key.contains("Stat")) {
  //         // Extraer la piscina del nombre del tablero (entre "TA" y "-")
  //         String tableroCompleto = key.split("_")[1];

  //         if (key.contains("PTP") || key.contains("AP")) {
  //           // Si es un tablero PTP o AP, agrégalo a la lista separada
  //           specialTableros.add({
  //             "nombre": tableroCompleto,
  //             "status": value == "true" ? true : false,
  //           });
  //         } else {
  //           // Si no es PTP ni AP, agrúpalo por piscina
  //           int indexGuion = tableroCompleto.indexOf('-');
  //           String piscina = indexGuion != -1
  //               ? tableroCompleto.substring(2, indexGuion)
  //               : 'Desconocida';

  //           groupedData.putIfAbsent(piscina, () => []);

  //           groupedData[piscina]!.add({
  //             "nombre": tableroCompleto,
  //             "status": value == "true" ? true : false,
  //           });
  //         }
  //       }
  //     });
  //   }

  //   // Convertir el mapa agrupado a la estructura final
  //   List<Map<String, dynamic>> result = [];
  //   groupedData.forEach((piscina, tableros) {
  //     // Solo agregar la piscina si al menos un tablero tiene `status: false`
  //     if (tableros.any((tablero) => tablero["status"] == false)) {
  //       result.add({
  //         "piscina": piscina,
  //         "tableros": tableros,
  //       });
  //     }
  //   });

  //   // Agregar los tableros PTP y AP a la lista de resultados
  //   specialTableros.forEach((tablero) {
  //     result.add({
  //       "piscina":
  //           tablero["nombre"], // Usar el nombre del tablero como "piscina"
  //       "tableros": [tablero], // Crear una lista con un solo tablero
  //     });
  //   });

  //   return result;
  // }

  List<Map<String, dynamic>> processAndFilterData(List<dynamic> data) {
    if (data.isEmpty) {
      return [];
    }

    // Mapa temporal para agrupar tableros por piscina
    Map<String, List<Map<String, dynamic>>> groupedData = {};
    List<Map<String, dynamic>> specialTableros =
        []; // Lista para tableros PTP y AP

    for (var item in data[2]) {
      item.forEach((key, value) {
        if (key is String && key.contains("Stat")) {
          // Extraer la piscina del nombre del tablero (entre "TA" y "-")
          String tableroCompleto = key.split("_")[1];

          if (key.contains("PTP") || key.contains("AP")) {
            // Si es un tablero PTP o AP, agrégalo a la lista separada
            if (value == "false") {
              specialTableros.add({
                "nombre": tableroCompleto,
                "status": false,
              });
            }
          } else {
            // Si no es PTP ni AP, agrúpalo por piscina
            int indexGuion = tableroCompleto.indexOf('-');
            String piscina = indexGuion != -1
                ? tableroCompleto.substring(2, indexGuion)
                : 'Desconocida';

            groupedData.putIfAbsent(piscina, () => []);

            if (value == "false") {
              groupedData[piscina]!.add({
                "nombre": tableroCompleto,
                "status": false,
              });
            }
          }
        }
      });
    }

    // Convertir el mapa agrupado a la estructura final
    List<Map<String, dynamic>> result = [];
    groupedData.forEach((piscina, tableros) {
      // Solo agregar la piscina si al menos un tablero tiene `status: false`
      if (tableros.isNotEmpty) {
        result.add({
          "piscina": piscina,
          "tableros": tableros,
        });
      }
    });

    // Agregar los tableros PTP y AP a la lista de resultados
    specialTableros.forEach((tablero) {
      result.add({
        "piscina":
            tablero["nombre"], // Usar el nombre del tablero como "piscina"
        "tableros": [tablero], // Crear una lista con un solo tablero
      });
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    color: Colors.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Estado antenas',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
        body: Consumer<PiscinasJosefinaProvider>(
            builder: (context, psProvider, child) {
          filteredData =
              processAndFilterData(psProvider.apiDataListInfoGeneralPis);
          // print(filteredData);
          if (!PiscinasJosefinaProvider.isLoading2) {
          } else if (psProvider.hasError) {
            return Center(child: Text('Error: ${psProvider.errorMessage}'));
          }

          return filteredData.isEmpty
              ? const Center(
                  child: Text(
                    'No hay piscinas con tableros sin comunicación.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(25),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final piscina = filteredData[index];
                    return PiscinaCard(
                      piscina: piscina,
                    );
                  },
                );
        }));
  }
}

class PiscinaCard extends StatelessWidget {
  final Map<String, dynamic> piscina;

  const PiscinaCard({super.key, required this.piscina});

  @override
  Widget build(BuildContext context) {
    String piscinaNombre = piscina["piscina"];
    String tipoPiscina = "";

    // Intenta convertir el nombre de la piscina a un número
    int? numeroPiscina = int.tryParse(piscinaNombre);

    if (numeroPiscina != null) {
      if (numeroPiscina < 100 && numeroPiscina != 20) {
        tipoPiscina = " Piscina ";
      } else if (numeroPiscina > 100 || numeroPiscina == 20) {
        tipoPiscina = " Precría ";
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tipoPiscina + piscinaNombre,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ...piscina["tableros"].asMap().entries.map<Widget>((entry) {
            int index = entry.key;
            Map<String, dynamic> tablero = entry.value;

            return Column(
              children: [
                Text(tablero["nombre"]),
                const SizedBox(height: 5),
                NetworkAnimated(signal: tablero["status"]),
                // Añadir Divider solo si no es el último tablero
                if (index != piscina["tableros"].length - 1)
                  const Divider(color: Colors.grey),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
