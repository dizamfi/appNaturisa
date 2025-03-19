// import 'package:flutter/material.dart';

// class ControlRemoto extends StatelessWidget {
//   const ControlRemoto({
//     super.key,
//     required this.apiDataList,
//   });

//   final List apiDataList;

//   // Función para verificar si apiDataList tiene datos válidos
//   bool _datosDisponibles() {
//     if (apiDataList.isEmpty) return false;

//     // Verifica si hay al menos un elemento no vacío en apiDataList
//     for (var sublist in apiDataList) {
//       if (sublist is List && sublist.isNotEmpty) {
//         return true;
//       }
//     }

//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Estructura básica del Container que se mantiene en todos los casos
//     return Container(
//       constraints: const BoxConstraints(
//           minWidth: 100,
//           maxWidth: double.infinity,
//           maxHeight: double.infinity,
//           minHeight: 90),
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(1),
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(9, 31, 72, 1),
//             blurRadius: 3,
//           )
//         ],
//       ),
//       child: _buildContent(),
//     );
//   }

//   // Método para construir el contenido del widget dependiendo de si hay datos disponibles o no
//   Widget _buildContent() {
//     if (!_datosDisponibles() || apiDataList[0].isEmpty) {
//       _buildContentLoading();
//     }

//     try {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Control Remoto',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(10),
//                     padding: const EdgeInsets.all(5),
//                     decoration: const BoxDecoration(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                     ),
//                     child: const Text(
//                       'Operación',
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.symmetric(vertical: 0),
//                     decoration: const BoxDecoration(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                     ),
//                     child: const Text(
//                       'Hora Inicio',
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.symmetric(vertical: 0),
//                     decoration: const BoxDecoration(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                     ),
//                     child: const Text(
//                       'Hora Fin',
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(10),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 4, 63, 122),
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromRGBO(255, 255, 255, 1),
//                           blurRadius: 3,
//                         )
//                       ],
//                     ),
//                     child: Center(
//                       child: apiDataList.isNotEmpty &&
//                               apiDataList[0].isNotEmpty &&
//                               apiDataList[0][0] != null
//                           ? !apiDataList[0][0]['Bloq_Auto_Hora']
//                               ? const Text(
//                                   'Auto',
//                                   style: TextStyle(color: Colors.white),
//                                 )
//                               : const Text(
//                                   'Manual',
//                                   style: TextStyle(color: Colors.white),
//                                 )
//                           : const Text('Auto',
//                               style: TextStyle(color: Colors.transparent)),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//                     decoration: const BoxDecoration(
//                       color: Colors.transparent,
//                     ),
//                     child: apiDataList.isNotEmpty &&
//                             apiDataList[0].isNotEmpty &&
//                             apiDataList[0][0] != null
//                         ? Text(
//                             apiDataList[0][0]['Hora_Ini_1']?.toString() ?? '',
//                             style: const TextStyle(color: Colors.black),
//                           )
//                         : const Text('00:00:00',
//                             style: TextStyle(color: Colors.transparent)),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                     decoration: const BoxDecoration(
//                       color: Colors.transparent,
//                     ),
//                     child: apiDataList.isNotEmpty &&
//                             apiDataList[0].isNotEmpty &&
//                             apiDataList[0][0] != null
//                         ? Text(
//                             apiDataList[0][0]['Hora_Fin_2']?.toString() ?? '',
//                             style: const TextStyle(color: Colors.black),
//                           )
//                         : const Text('00:00:00',
//                             style: TextStyle(color: Colors.transparent)),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 width: 35,
//               ),
//               const Icon(
//                 Icons.settings_remote_outlined,
//                 size: 70,
//               )
//             ],
//           ),
//         ],
//       );
//     } catch (e) {
//       print('Error en ControlRemoto: $e');
//       return const Center(
//         child: Text(
//           'Error al cargar los datos',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.red,
//           ),
//         ),
//       );
//     }
//   }

//   Widget _buildContentLoading() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Control Remoto',
//               style:
//                   TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Row(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.all(10),
//                   padding: const EdgeInsets.all(5),
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                   ),
//                   child: const Text(
//                     'Operación',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(5),
//                   padding: const EdgeInsets.symmetric(vertical: 0),
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                   ),
//                   child: const Text(
//                     'Hora Inicio',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(5),
//                   padding: const EdgeInsets.symmetric(vertical: 0),
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                   ),
//                   child: const Text(
//                     'Hora Fin',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 )
//               ],
//             ),
//             Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.all(10),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                   decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 4, 63, 122),
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromRGBO(255, 255, 255, 1),
//                         blurRadius: 3,
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(5),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(5),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(
//               width: 35,
//             ),
//             const Icon(
//               Icons.settings_remote_outlined,
//               size: 70,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:appnaturisa/utils/data_access_utils.dart'; // Añadir esta importación

class ControlRemoto extends StatelessWidget {
  const ControlRemoto({
    super.key,
    required this.apiDataList,
  });

  final List apiDataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          minHeight: 90),
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
      child: _buildContent(),
    );
  }

  // Método para construir el contenido del widget
  Widget _buildContent() {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Control Remoto',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Text(
                      'Operación',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Text(
                      'Hora Inicio',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Text(
                      'Hora Fin',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 4, 63, 122),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Center(
                      // Usar DataAccessUtils para acceso seguro
                      child: Text(
                        !DataAccessUtils.getNestedValue(
                                apiDataList, [0, 0, 'Bloq_Auto_Hora'], false)
                            ? 'Auto'
                            : 'Manual',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    // Usar DataAccessUtils para acceso seguro
                    child: Text(
                      DataAccessUtils.getNestedValue(
                              apiDataList, [0, 0, 'Hora_Ini_1'], '00:00:00')
                          .toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    // Usar DataAccessUtils para acceso seguro
                    child: Text(
                      DataAccessUtils.getNestedValue(
                              apiDataList, [0, 0, 'Hora_Fin_2'], '00:00:00')
                          .toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 35,
              ),
              const Icon(
                Icons.settings_remote_outlined,
                size: 70,
              )
            ],
          ),
        ],
      );
    } catch (e) {
      // En caso de error inesperado, mostrar mensaje
      debugPrint('Error en ControlRemoto: $e');
      return const Center(
        child: Text(
          'Error al cargar los datos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      );
    }
  }
}
