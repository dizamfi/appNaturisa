// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class PiscinasReporteScreen extends StatefulWidget {
//   const PiscinasReporteScreen({super.key});

//   @override
//   _PiscinasReporteScreenState createState() => _PiscinasReporteScreenState();
// }

// class _PiscinasReporteScreenState extends State<PiscinasReporteScreen> {
//   DateTime _selectedDate = DateTime.now();
//   bool _isDateSelected = false;
//   bool _isPiscinaSelected = false;
//   String _selectedPiscina = "Piscina 22A"; // Piscina predeterminada
//   double trabajoPiscinaOn = 65;
//   double trabajoPiscinaOff = 35;
//   double usoPromedio = 65;

//   List<double> usoPorHora =
//       List.generate(24, (index) => (index % 2 == 0) ? 70.0 : 40.0);

//   Future<void> _selectDate(BuildContext context) async {
//     if (!_isPiscinaSelected) {
//       // Si no se ha seleccionado una piscina, muestra el AlertDialog
//       _showPiscinaAlert(context);
//       return;
//     }

//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             // Cambia el color de fondo del diálogo
//             dialogBackgroundColor: Colors.blueGrey[50],
//             // Personaliza la paleta de colores del date picker
//             colorScheme: ColorScheme.light(
//               primary: Colors
//                   .green, // Color de los elementos principales (por ejemplo, encabezado)
//               onPrimary: Colors.white, // Color del texto sobre el encabezado
//               onSurface: Colors.black, // Color del texto en el cuerpo
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor:
//                     Colors.blue, // Color de los botones como "OK" y "CANCEL"
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _isDateSelected = true;
//         _updateDataForSelectedDate();
//       });
//     }
//   }

//   void _updateDataForSelectedDate() {
//     trabajoPiscinaOn = (_selectedDate.day % 2 == 0) ? 70 : 60;
//     trabajoPiscinaOff = 100 - trabajoPiscinaOn;
//     usoPromedio = trabajoPiscinaOn;
//     usoPorHora = List.generate(
//         24, (index) => (index % 2 == 0) ? trabajoPiscinaOn : trabajoPiscinaOff);
//   }

//   // Función para mostrar un alert dialog si la piscina no está seleccionada
//   void _showPiscinaAlert(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: const Text('Seleccionar Piscina'),
//           content: const Text(
//               'Debes seleccionar una piscina antes de elegir una fecha.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Aceptar'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         toolbarHeight: 80,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 color: Colors.transparent,
//                 // height: 200,
//                 height: size.height * 0.1,
//                 // width: 30,
//                 width: size.width * 0.083,
//                 child: const Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   size: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 50),
//               child: Text(
//                 'Reportes',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 _selectDate(context);
//               },
//               icon: const Icon(
//                 Icons.calendar_today,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         width: double.infinity,
//         height: double.infinity,
//         child: !_isDateSelected
//             ? _buildInitialView()
//             : SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // const SizedBox(
//                     //   height: 10,
//                     // ),
//                     Center(
//                         child: Text(
//                       _selectedPiscina, // Muestra la piscina seleccionada
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     )),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Fecha seleccionada: ',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           _selectedDate.toLocal().toString().split(' ')[0],
//                           style: const TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 35,
//                     ),
//                     const Text(
//                       'Porcentaje de trabajo al día',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         SizedBox(
//                           height: 200,
//                           width: 200,
//                           child: PieChart(
//                             PieChartData(
//                               sections: [
//                                 PieChartSectionData(
//                                   value: trabajoPiscinaOn,
//                                   color: Colors.green,
//                                   title:
//                                       '${trabajoPiscinaOn.toStringAsFixed(1)}%',
//                                   radius: 60,
//                                   titleStyle: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 PieChartSectionData(
//                                   value: trabajoPiscinaOff,
//                                   color: Colors.grey,
//                                   title:
//                                       '${trabajoPiscinaOff.toStringAsFixed(1)}%',
//                                   radius: 60,
//                                   titleStyle: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   const CircleAvatar(
//                                     radius: 6,
//                                     backgroundColor: Colors.green,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'On - ${trabajoPiscinaOn.toStringAsFixed(1)}%',
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   const CircleAvatar(
//                                     radius: 6,
//                                     backgroundColor: Colors.grey,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Off - ${trabajoPiscinaOff.toStringAsFixed(1)}%',
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Porcentajes de trabajo por hora',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 16),
//                     Container(
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[40],
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             blurRadius: 2,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 300,
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: SizedBox(
//                                 width: 1200,
//                                 child: BarChart(
//                                   BarChartData(
//                                     barGroups: List.generate(24, (index) {
//                                       final percentage = usoPorHora[index];
//                                       return BarChartGroupData(
//                                         x: index,
//                                         barRods: [
//                                           BarChartRodData(
//                                             toY: percentage,
//                                             color: percentage >= 70
//                                                 ? Colors.green
//                                                 : Colors.orange,
//                                             width: 12,
//                                           ),
//                                         ],
//                                       );
//                                     }),
//                                     titlesData: FlTitlesData(
//                                       bottomTitles: AxisTitles(
//                                         sideTitles: SideTitles(
//                                           showTitles: true,
//                                           reservedSize: 40,
//                                           getTitlesWidget: (value, meta) {
//                                             return Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 8.0),
//                                               child: Text(
//                                                 "${value.toInt()}h",
//                                                 style: TextStyle(fontSize: 12),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       leftTitles: AxisTitles(
//                                         sideTitles: SideTitles(
//                                           showTitles: true,
//                                           getTitlesWidget: (value, meta) {
//                                             return Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 4.0),
//                                               child: Text(
//                                                 "${value.toInt()}%",
//                                                 style: TextStyle(fontSize: 10),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     maxY: 100,
//                                     gridData: FlGridData(show: true),
//                                     borderData: FlBorderData(
//                                       border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black26),
//                                         left: BorderSide(color: Colors.black26),
//                                       ),
//                                     ),
//                                     groupsSpace: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//       floatingActionButton: _isDateSelected
//           ? FloatingActionButton.extended(
//               onPressed: () {
//                 setState(() {
//                   _isDateSelected = false;
//                 });
//               },
//               backgroundColor: Colors.black,
//               label: Row(
//                 children: [
//                   Icon(
//                     Icons.repeat_rounded,
//                     size: 20,
//                     color: Colors.white,
//                   ),
//                   SizedBox(width: 8), // Espaciado entre el ícono y el texto
//                   Text(
//                     'Piscinas',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : null,
//     );
//   }

//   Widget _buildInitialView() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             'assets/report_image.svg', // Reemplaza con tu SVG
//             height: 250,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Selecciona una piscina para ver su estado',
//             style: TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 20),
//           DropdownButton<String>(
//             dropdownColor: Colors.white,
//             // menuWidth: 200,
//             menuMaxHeight: 250,
//             value: _selectedPiscina,
//             items: <String>[
//               'Piscina 22A',
//               'Piscina 22B',
//               'Piscina 24',
//               'Piscina 25',
//               'Piscina 26',
//               'Piscina 27',
//               'Piscina 28',
//               'Piscina 29',
//               'Piscina 30',
//               'Piscina 31',
//               'Piscina 32',
//               'Piscina 33A',
//               'Piscina 33B',
//               'Piscina 34B'
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 _selectedPiscina = newValue!;
//                 _isPiscinaSelected = true;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PiscinasReporteScreen extends StatefulWidget {
  const PiscinasReporteScreen({super.key});

  @override
  _PiscinasReporteScreenState createState() => _PiscinasReporteScreenState();
}

class _PiscinasReporteScreenState extends State<PiscinasReporteScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _isDateSelected = false;
  bool _isPiscinaSelected = false;
  String _selectedPiscina = "Piscina 22A"; // Piscina predeterminada
  double trabajoPiscinaOn = 65;
  double trabajoPiscinaOff = 35;
  double usoPromedio = 65;
  bool isLoading = false;
  bool hasError = false;

  dynamic mapeoPiscinas = {
    'Piscina 22A': 'ps22a',
    'Piscina 22B': 'ps22b',
    'Piscina 24': 'ps024',
    'Piscina 25': 'ps025',
    'Piscina 26': 'ps026',
    'Piscina 27': 'ps027',
    'Piscina 28': 'ps028',
    'Piscina 29': 'ps029',
    'Piscina 30': 'ps030',
    'Piscina 31': 'ps031',
    'Piscina 32': 'ps032',
    'Piscina 33A': 'ps33a',
    'Piscina 33B': 'ps33b',
    'Piscina 34B': 'ps34b'
  };

  List<double> usoPorHora =
      List.generate(24, (index) => (index % 2 == 0) ? 70.0 : 40.0);

  Future<void> _selectDate(BuildContext context) async {
    if (!_isPiscinaSelected) {
      // Si no se ha seleccionado una piscina, muestra el AlertDialog
      _showPiscinaAlert(context);
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Cambia el color de fondo del diálogo
            dialogBackgroundColor: Colors.blueGrey[50],
            // Personaliza la paleta de colores del date picker
            colorScheme: ColorScheme.light(
              primary: Colors
                  .green, // Color de los elementos principales (por ejemplo, encabezado)
              onPrimary: Colors.white, // Color del texto sobre el encabezado
              onSurface: Colors.black, // Color del texto en el cuerpo
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.blue, // Color de los botones como "OK" y "CANCEL"
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _isDateSelected = true;
        String formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        DateTime newEndDate = picked.add(Duration(days: 1));
        String endDate =
            "${newEndDate.year}-${newEndDate.month.toString().padLeft(2, '0')}-${newEndDate.day.toString().padLeft(2, '0')}";

        String namePs = mapeoPiscinas[_selectedPiscina];
        _updateDataForSelectedDate(formattedDate, endDate, namePs);
      });
    }
  }

  Future<void> _updateDataForSelectedDate(
      String fechaInicio, String fechaFin, String namePiscina) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
// Llamar a la API y obtener los datos
      var result =
          await PiscinasJosefinaProvider.getPiscinasHistorialAireacionJosefina(
              {
            "fechaInicio": fechaInicio,
            "fechaFin": fechaFin
          }, // Asegúrate de enviar las fechas adecuadas
              'http://192.168.153.101:2020', // Base URL de tu API
              '/api/graca/$namePiscina/historial' // Endpoint adecuado
              );

      if (result != null && result['ok']) {
        setState(() {
          trabajoPiscinaOn = result['porcentajeEncendido'].toDouble() ?? 0.0;
          trabajoPiscinaOff = 100 - trabajoPiscinaOn;
          usoPromedio = trabajoPiscinaOn;

          // Asegúrate de que 'arregloPorcentajeEncendido' tenga al menos 24 horas
          usoPorHora = List.generate(
            24,
            (index) => result['arregloPorcentajeEncendido']
                    [index % result['arregloPorcentajeEncendido'].length]
                .toDouble(),
          );
        });
      }
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

  // Función para mostrar un alert dialog si la piscina no está seleccionada
  void _showPiscinaAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Seleccionar Piscina'),
          content: const Text(
              'Debes seleccionar una piscina antes de elegir una fecha.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                // height: 200,
                height: size.height * 0.1,
                // width: 30,
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
                'Reportes',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _selectDate(context);
              },
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: !_isDateSelected ? _buildInitialView() : _buildReportePiscina(),
      ),
      floatingActionButton: _isDateSelected
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _isDateSelected = false;
                });
              },
              backgroundColor: Colors.black,
              label: Row(
                children: [
                  Icon(
                    Icons.repeat_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8), // Espaciado entre el ícono y el texto
                  Text(
                    'Piscinas',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildReportePiscina() {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
    }

    if (hasError) {
      return const Center(child: Text('No hay registros para esta fecha'));
    }
    // if (piscinasData == null || piscinasData!.isEmpty) {
    //   return const Center(child: Text('No hay datos disponibles.'));
    // }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 10,
          // ),
          Center(
              child: Text(
            _selectedPiscina, // Muestra la piscina seleccionada
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Fecha seleccionada: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                _selectedDate.toLocal().toString().split(' ')[0],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
            'Porcentaje de trabajo al día',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: trabajoPiscinaOn,
                        color: Colors.green,
                        title: '${trabajoPiscinaOn.toStringAsFixed(1)}%',
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: trabajoPiscinaOff,
                        color: Colors.grey,
                        title: '${trabajoPiscinaOff.toStringAsFixed(1)}%',
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'On - ${trabajoPiscinaOn.toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Off - ${trabajoPiscinaOff.toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Porcentajes de trabajo por hora',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[40],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1200,
                      child: BarChart(
                        BarChartData(
                          barGroups: List.generate(24, (index) {
                            final percentage = usoPorHora[index];
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: percentage,
                                  color: percentage >= 70
                                      ? Colors.green
                                      : Colors.orange,
                                  width: 12,
                                ),
                              ],
                            );
                          }),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "${value.toInt()}h",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(
                                      "${value.toInt()}%",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          maxY: 100,
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(
                            border: Border(
                              bottom: BorderSide(color: Colors.black26),
                              left: BorderSide(color: Colors.black26),
                            ),
                          ),
                          groupsSpace: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/report_image.svg', // Reemplaza con tu SVG
            height: 250,
          ),
          const SizedBox(height: 20),
          Text(
            'Selecciona una piscina para ver su estado',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            dropdownColor: Colors.white,
            // menuWidth: 200,
            menuMaxHeight: 250,
            value: _selectedPiscina,
            items: <String>[
              'Piscina 22A',
              'Piscina 22B',
              'Piscina 24',
              'Piscina 25',
              'Piscina 26',
              'Piscina 27',
              'Piscina 28',
              'Piscina 29',
              'Piscina 30',
              'Piscina 31',
              'Piscina 32',
              'Piscina 33A',
              'Piscina 33B',
              'Piscina 34B'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedPiscina = newValue!;
                _isPiscinaSelected = true;
              });
            },
          ),
        ],
      ),
    );
  }
}
