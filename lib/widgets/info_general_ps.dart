// import 'package:flutter/material.dart';

// class InfoGeneralPS extends StatelessWidget {
//   const InfoGeneralPS({
//     super.key,
//     required this.apiDataList,
//   });

//   final List apiDataList;

//   // Función para verificar si apiDataList está vacía o contiene solo arreglos vacíos
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
//     // print(apiDataList);

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

//   Widget _buildContent() {
//     if (!_datosDisponibles() || apiDataList[0].isEmpty) {
//       _buildContentLoading();
//     }

//     try {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 10, right: 15),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Horas Trabajo',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'Semanal',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ), // Tamaño más pequeño
//                         ],
//                       ),
//                       const SizedBox(
//                           height: 5), // Espacio entre columnas si lo necesitas

//                       apiDataList.isNotEmpty && apiDataList[0].isNotEmpty
//                           ? Text(
//                               apiDataList[0][0]['Hrs_Trab_Act']?.toString() ??
//                                   '0',
//                               style: const TextStyle(color: Colors.black),
//                             )
//                           : const Text(
//                               'H/Sem',
//                               style: TextStyle(color: Colors.black),
//                             )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, right: 30),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Horas Trabajo',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'Semanal',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ), // Tamaño más pequeño
//                         ],
//                       ),
//                       const SizedBox(
//                           height: 5), // Espacio entre columnas si lo necesitas

//                       apiDataList.isNotEmpty && apiDataList[0].isNotEmpty
//                           ? Text(
//                               apiDataList[0][0]['Hrs_Trab_Sem']?.toString() ??
//                                   '0',
//                               style: const TextStyle(color: Colors.black),
//                             )
//                           : const Text(
//                               'H/Sem',
//                               style: TextStyle(color: Colors.black),
//                             )
//                     ],
//                   ),
//                 ),
//                 const Icon(
//                   Icons.access_alarm,
//                   color: Colors.black,
//                   size: 45,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Container(
//               height: 1,
//               width: double.infinity,
//               color: Colors.grey,
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 10, right: 15),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Energia Cons',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'Dia Actual',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ), // Tamaño más pequeño
//                         ],
//                       ),
//                       const SizedBox(
//                           height: 5), // Espacio entre columnas si lo necesitas

//                       apiDataList.isNotEmpty && apiDataList[0].isNotEmpty
//                           ? Text(
//                               apiDataList[0][0]['Ener_Mes_Act']?.toString() ??
//                                   '0',
//                               style: const TextStyle(color: Colors.black),
//                             )
//                           : const Text(
//                               'KWh/M',
//                               style: TextStyle(color: Colors.black),
//                             )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, right: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Energia Cons',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'Dia Anterior',
//                             style: TextStyle(
//                                 // color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ), // Tamaño más pequeño
//                         ],
//                       ),
//                       const SizedBox(
//                           height: 5), // Espacio entre columnas si lo necesitas

//                       apiDataList.isNotEmpty && apiDataList[0].isNotEmpty
//                           ? Text(
//                               apiDataList[0][0]['Ener_Mes_Pas']?.toString() ??
//                                   '0',
//                               style: const TextStyle(color: Colors.black),
//                             )
//                           : const Text(
//                               'KWh/M',
//                               style: TextStyle(color: Colors.black),
//                             )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print('Error en InfoGeneralPS: $e');
//       return Container(
//         constraints: const BoxConstraints(
//             minWidth: 100,
//             maxWidth: double.infinity,
//             maxHeight: double.infinity,
//             minHeight: 90),
//         margin: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(1),
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           boxShadow: const [
//             BoxShadow(
//               color: Color.fromRGBO(9, 31, 72, 1),
//               blurRadius: 3,
//             )
//           ],
//         ),
//         child: const Center(
//           child: Text(
//             'Error al cargar los datos',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       );
//     }
//   }

//   // Proceder con la creación del widget original cuando hay datos disponibles

//   Widget _buildContentLoading() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, top: 10, right: 15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Horas Trabajo',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           'Semanal',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ), // Tamaño más pequeño
//                       ],
//                     ),
//                     const SizedBox(
//                         height: 5), // Espacio entre columnas si lo necesitas

//                     Text(
//                       'H/Sem',
//                       style: const TextStyle(color: Colors.black),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, right: 30),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Horas Trabajo',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           'Semanal',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ), // Tamaño más pequeño
//                       ],
//                     ),
//                     const SizedBox(
//                         height: 5), // Espacio entre columnas si lo necesitas

//                     Text(
//                       'H/Sem',
//                       style: const TextStyle(color: Colors.black),
//                     )
//                   ],
//                 ),
//               ),
//               const Icon(
//                 Icons.access_alarm,
//                 color: Colors.black,
//                 size: 45,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Container(
//             height: 1,
//             width: double.infinity,
//             color: Colors.grey,
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, top: 10, right: 15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Energia Cons',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           'Dia Actual',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ), // Tamaño más pequeño
//                       ],
//                     ),
//                     const SizedBox(
//                         height: 5), // Espacio entre columnas si lo necesitas

//                     Text(
//                       'KWh/M',
//                       style: const TextStyle(color: Colors.black),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, right: 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Energia Cons',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           'Dia Anterior',
//                           style: TextStyle(
//                               // color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ), // Tamaño más pequeño
//                       ],
//                     ),
//                     const SizedBox(
//                         height: 5), // Espacio entre columnas si lo necesitas

//                     Text(
//                       'KWh/M',
//                       style: const TextStyle(color: Colors.black),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:appnaturisa/utils/data_access_utils.dart';

class InfoGeneralPS extends StatelessWidget {
  const InfoGeneralPS({
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
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    try {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Horas Trabajo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Semanal',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DataAccessUtils.getNestedValue(
                            apiDataList, [0, 0, 'Hrs_Trab_Act'], '0'),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Horas Trabajo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Semanal',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DataAccessUtils.getNestedValue(
                            apiDataList, [0, 0, 'Hrs_Trab_Sem'], '0'),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size.width * 0.025),
                const Icon(
                  Icons.access_alarm,
                  color: Colors.black,
                  size: 45,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Energia Cons',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Dia Actual',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DataAccessUtils.getNestedValue(
                            apiDataList, [0, 0, 'Ener_Mes_Act'], '0'),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Energia Cons',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Dia Anterior',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DataAccessUtils.getNestedValue(
                            apiDataList, [0, 0, 'Ener_Mes_Pas'], '0'),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                // SizedBox(width: 45),
                SizedBox(width: size.width * 0.1),

                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.electric_bolt,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error en InfoGeneralPS: $e');
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Error al cargar los datos',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }
}
