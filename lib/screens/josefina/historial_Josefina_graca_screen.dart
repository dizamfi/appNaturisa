// import 'package:appgraca/providers/ps_graca_provider.dart';
// import 'package:flutter/material.dart';

// class HistorialAireacionGracaScreen extends StatefulWidget {
//   const HistorialAireacionGracaScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HistorialAireacionGracaScreenState createState() =>
//       _HistorialAireacionGracaScreenState();
// }

// class _HistorialAireacionGracaScreenState
//     extends State<HistorialAireacionGracaScreen> {
//   DateTime?
//       selectedDate; // Inicialmente null para identificar si se seleccionó una fecha
//   // final List<Map<String, dynamic>> piscinas = List.generate(20, (index) {
//   //   return {
//   //     'nombre': 'Piscina ${index + 1}',
//   //     'porcentaje': (index + 1) * 5 % 100.toDouble(),
//   //     'horasTrabajadas': ((index + 1) * 2.5).toDouble(),
//   //   };
//   // });

//   Map<String, dynamic>? piscinasData;
//   bool isLoading = false;
//   bool hasError = false;

//   void _selectDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2050),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             dialogBackgroundColor: Colors.blueGrey[50],
//             colorScheme: const ColorScheme.light(
//               primary: Colors.green,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.blue,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         String formattedDate =
//             "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

//         // Fecha final (un día después de la seleccionada)
//         DateTime newEndDate = picked.add(Duration(days: 1));
//         String endDate =
//             "${newEndDate.year}-${newEndDate.month.toString().padLeft(2, '0')}-${newEndDate.day.toString().padLeft(2, '0')}";

//         print(formattedDate);
//         print(endDate);

//         _fetchPiscinasData(formattedDate, endDate);
//       });
//     }
//   }

//   Future<void> _fetchPiscinasData(String fechaInicio, String fechaFin) async {
//     setState(() {
//       isLoading = true;
//       hasError = false;
//     });
//     try {
//       // Simulación de la llamada a la API
//       final Map<String, dynamic> data =
//           await PiscinasGracaProvider.getPiscinasHistorialGraca(
//               {"fechaInicio": fechaInicio, "fechaFin": fechaFin},
//               'http://192.168.153.101:2020',
//               '/api/graca/psGeneral/historial');
//       print(data);

//       setState(() {
//         piscinasData = data;
//       });
//     } catch (e) {
//       setState(() {
//         hasError = true;
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           scrolledUnderElevation: 0,
//           toolbarHeight: 80,
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   color: Colors.transparent,
//                   // height: 200,
//                   height: size.height * 0.1,
//                   // width: 30,
//                   width: size.width * 0.083,

//                   child: const Icon(
//                     Icons.arrow_back_ios_new_rounded,
//                     size: 18,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 50),
//                 child: Text(
//                   'Historial',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: _selectDate,
//                 icon: const Icon(
//                   Icons.calendar_today,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Container(
//           color: Colors.white,
//           width: double.infinity,
//           height: double.infinity,
//           child: selectedDate == null
//               ? _buildInitialScreen()
//               : _buildPiscinasGrid(),
//         ));
//   }

//   Widget _buildInitialScreen() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: const [
//           Icon(Icons.history,
//               size: 80,
//               // color: Colors.grey,
//               color: Colors.black54),
//           SizedBox(height: 16),
//           Text(
//             'Por favor, seleccione una fecha para ver el historial.',
//             style: TextStyle(fontSize: 16),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPiscinasGrid() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             'Fecha seleccionada: ${selectedDate!.toLocal().toString().split(' ')[0]}',
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 30),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 1,
//               ),
//               itemCount: piscinasData?.length,
//               itemBuilder: (context, index) {
//                 // final piscina = piscinas[index];
//                 // return PiscinaCard(
//                 //   nombre: piscina['nombre'],
//                 //   porcentaje: piscina['porcentaje'],
//                 //   horasTrabajadas: piscina['horasTrabajadas'],
//                 // );

//                 final piscinaId = piscinasData?.keys.elementAt(
//                     index); // Obtienes el identificador de la piscina
//                 final piscina = piscinasData?[piscinaId]?[
//                     0]; // Accedes a la primera entrada en la lista correspondiente

//                 return PiscinaCard(
//                   nombre:
//                       piscinaId ?? '', // Usamos el id de la piscina como nombre
//                   porcentaje: piscina?['promedioEstado'] ??
//                       0, // Accedemos al valor de 'promedioEstado'
//                   horasTrabajadas: piscina?['promedioHoras'] ??
//                       0, // Accedemos al valor de 'promedioHoras'
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PiscinaCard extends StatelessWidget {
//   final String nombre;
//   final int porcentaje;
//   final int horasTrabajadas;

//   PiscinaCard({
//     required this.nombre,
//     required this.porcentaje,
//     required this.horasTrabajadas,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//           side: BorderSide(
//             width: 0,
//           )),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               nombre,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 8),
//             CircularProgressIndicator(
//               value: porcentaje /
//                   100.0, // Asegúrate de dividir entre 100.0 para obtener un double
//               strokeWidth: 6,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 porcentaje > 50 ? Colors.green : Colors.orange,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '${porcentaje.toStringAsFixed(1)}% trabajado',
//               style: TextStyle(fontSize: 14),
//             ),
//             // SizedBox(height: 8),
//             Text(
//               '${horasTrabajadas.toStringAsFixed(1)} horas',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:flutter/material.dart';

class HistorialAireacionJosefinaScreen extends StatefulWidget {
  const HistorialAireacionJosefinaScreen({super.key});

  @override
  _HistorialAireacionJosefinaScreenState createState() =>
      _HistorialAireacionJosefinaScreenState();
}

class _HistorialAireacionJosefinaScreenState
    extends State<HistorialAireacionJosefinaScreen> {
  DateTime? selectedDate;
  Map<String, dynamic>? piscinasData;
  bool isLoading = false;
  bool hasError = false;

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.blueGrey[50],
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        String formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        DateTime newEndDate = picked.add(Duration(days: 1));
        String endDate =
            "${newEndDate.year}-${newEndDate.month.toString().padLeft(2, '0')}-${newEndDate.day.toString().padLeft(2, '0')}";
        _fetchPiscinasData(formattedDate, endDate);
      });
    }
  }

  Future<void> _fetchPiscinasData(String fechaInicio, String fechaFin) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    // Cambiar
    try {
      final Map<String, dynamic> data =
          await PiscinasJosefinaProvider.getPiscinasHistorialAireacionJosefina(
              {"fechaInicio": fechaInicio, "fechaFin": fechaFin},
              'http://192.168.153.101:2020',
              '/api/graca/psGeneral/historial');
      setState(() {
        piscinasData = data;
      });
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        // Eliminar la propiedad title y actions, y reemplazar con flexibleSpace
        flexibleSpace: Stack(
          children: [
            // Título centrado absolutamente en relación a la pantalla
            Positioned.fill(
              child: Center(
                child: Text(
                  'Historial',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Calendario posicionado absolutamente a la derecha
            Positioned(
              top: MediaQuery.of(context).padding.top +
                  15, // Considera el statusbar
              right: 15, // Margen derecho
              child: IconButton(
                onPressed: _selectDate,
                icon: const Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
              ),
            ),

            // Botón atrás si es necesario
            // Positioned(
            //   top: MediaQuery.of(context).padding.top + 15,
            //   left: 8,
            //   child: GestureDetector(
            //     onTap: () => Navigator.pop(context),
            //     child: Container(
            //       color: Colors.transparent,
            //       height: 40,
            //       width: 40,
            //       child: const Icon(
            //         Icons.arrow_back_ios_new_rounded,
            //         size: 18,
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        // Eliminar la propiedad actions completamente
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child:
            selectedDate == null ? _buildInitialScreen() : _buildPiscinasGrid(),
      ),
    );
  }

  Widget _buildInitialScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.history, size: 80, color: Colors.black54),
          SizedBox(height: 16),
          Text(
            'Por favor, seleccione una fecha para ver el historial.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPiscinasGrid() {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
    }

    if (hasError) {
      return const Center(child: Text('No hay registros para esta fecha'));
    }

    if (piscinasData == null || piscinasData!.isEmpty) {
      return const Center(child: Text('No hay datos disponibles.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Fecha seleccionada: ${selectedDate!.toLocal().toString().split(' ')[0]}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: piscinasData?.length,
              itemBuilder: (context, index) {
                final piscinaId = piscinasData?.keys.elementAt(index);
                final piscina = piscinasData?[piscinaId]?[0];
                return PiscinaCard(
                  nombre: piscinaId ?? '',
                  porcentaje: piscina?['promedioEstado'] ?? 0,
                  horasTrabajadas: piscina?['promedioHoras'] ?? 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PiscinaCard extends StatelessWidget {
  final String nombre;
  final int porcentaje;
  final int horasTrabajadas;

  PiscinaCard({
    required this.nombre,
    required this.porcentaje,
    required this.horasTrabajadas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(width: 0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nombre,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            CircularProgressIndicator(
              value: porcentaje / 100.0,
              strokeWidth: 6,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                porcentaje > 50 ? Colors.green : Colors.orange,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${porcentaje.toStringAsFixed(1)}% trabajado',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              '${horasTrabajadas.toStringAsFixed(1)} horas',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}









// import 'package:appgraca/providers/ps_graca_provider.dart';
// import 'package:flutter/material.dart';

// class HistorialAireacionGracaScreen extends StatefulWidget {
//   const HistorialAireacionGracaScreen({super.key});

//   @override
//   _HistorialAireacionGracaScreenState createState() =>
//       _HistorialAireacionGracaScreenState();
// }

// class _HistorialAireacionGracaScreenState
//     extends State<HistorialAireacionGracaScreen> {
//   DateTime? selectedDate;
//   Map<String, dynamic>? piscinasData;
//   bool isLoading = false;
//   bool hasError = false;

//   void _selectDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2050),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         _fetchPiscinasData();
//       });
//     }
//   }

//   Future<void> _fetchPiscinasData() async {
//     setState(() {
//       isLoading = true;
//       hasError = false;
//     });
//     try {
//       // Simulación de la llamada a la API
//       final Map<String, dynamic> data =
//           await PiscinasGracaProvider.getPiscinasHistorialGraca(
//               {"fechaInicio": "2025-02-05", "fechaFin": "2025-02-06"},
//               'http://192.168.153.101:2020',
//               '/api/graca/psGeneral/historial');
//       setState(() {
//         piscinasData = data;
//       });
//     } catch (e) {
//       setState(() {
//         hasError = true;
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Historial'),
//           actions: [
//             IconButton(
//               onPressed: _selectDate,
//               icon: const Icon(Icons.calendar_today),
//             ),
//           ],
//         ),
//         body: Container(
//           padding: const EdgeInsets.all(16.0),
//           child: selectedDate == null
//               ? _buildInitialScreen()
//               : isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : hasError
//                       ? _buildErrorScreen()
//                       : _buildPiscinasGrid(),
//         ));
//   }

//   Widget _buildInitialScreen() {
//     return const Center(
//       child: Text('Seleccione una fecha para ver el historial.'),
//     );
//   }

//   Widget _buildErrorScreen() {
//     return const Center(
//       child: Text('Ocurrió un error al cargar los datos. Inténtelo de nuevo.'),
//     );
//   }

//   Widget _buildPiscinasGrid() {
//     if (piscinasData == null || piscinasData!.isEmpty) {
//       return const Center(child: Text('No hay datos disponibles.'));
//     }
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: 1,
//       ),
//       itemCount: piscinasData!.length,
//       itemBuilder: (context, index) {
//         final key = piscinasData!.keys.elementAt(index);
//         final data = piscinasData![key][0];
//         return PiscinaCard(
//           nombre: key,
//           porcentaje: data['promedioEstado'].toDouble(),
//           horasTrabajadas: data['promedioHoras'].toDouble(),
//         );
//       },
//     );
//   }
// }

// class PiscinaCard extends StatelessWidget {
//   final String nombre;
//   final double porcentaje;
//   final double horasTrabajadas;

//   const PiscinaCard({
//     required this.nombre,
//     required this.porcentaje,
//     required this.horasTrabajadas,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             CircularProgressIndicator(
//               value: porcentaje / 100.0,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 porcentaje > 50 ? Colors.green : Colors.orange,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text('${porcentaje.toStringAsFixed(1)}% trabajado'),
//             Text('${horasTrabajadas.toStringAsFixed(1)} horas trabajadas'),
//           ],
//         ),
//       ),
//     );
//   }
// }
