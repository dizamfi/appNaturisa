// import 'dart:io';

// import 'package:appnaturisa/providers/user_provider.dart';
// import 'package:appnaturisa/screens/cerrar_sesion_screen.dart';
// import 'package:appnaturisa/screens/josefina/edit_profile_screen.dart';
// import 'package:appnaturisa/screens/josefina/historial_Josefina_graca_screen.dart';
// import 'package:appnaturisa/screens/josefina/piscina_reporte_screen.dart';
// import 'package:appnaturisa/services/storage_service.dart';
// import 'package:flutter/material.dart';

// class HistorialReporteScreen extends StatefulWidget {
//   const HistorialReporteScreen({super.key});

//   @override
//   State<HistorialReporteScreen> createState() => _HistorialReporteScreenState();
// }

// class _HistorialReporteScreenState extends State<HistorialReporteScreen> {
//   // Callback que se usará como listener
//   void _profileUpdatedListener() {
//     if (UserProvider.profileUpdated.value) {
//       if (mounted) {
//         setState(() {});
//       }
//       // Reinicia el valor del ValueNotifier para evitar actualizaciones repetidas
//       UserProvider.profileUpdated.value = false;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // UserProvider.profileUpdated.addListener(() {
//     //   if (UserProvider.profileUpdated.value) {
//     //     setState(() {});
//     //     UserProvider.profileUpdated.value = false;
//     //   }
//     // });
//     UserProvider.profileUpdated.addListener(_profileUpdatedListener);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // UserProvider.profileUpdated.removeListener(() {});
//     UserProvider.profileUpdated.removeListener(_profileUpdatedListener);
//     // super.dispose();
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
//         toolbarHeight: 0,
//         // leadingWidth: 0,

//         // centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: Container(
//         height: size.height,
//         width: size.width,
//         decoration: const BoxDecoration(
//             // gradient: _getWeatherGradient(),
//             color: Color.fromARGB(255, 255, 255, 255),
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(28),
//                 bottomRight: Radius.circular(28))),
//         child: ClipRRect(
//           // Esto recorta el contenido fuera de los bordes
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(40),
//             bottomRight: Radius.circular(40),
//           ),
//           // padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     // Avatar y nombres
//                     CircleAvatar(
//                       radius: 50, // Imagen de ejemplo
//                       backgroundColor: const Color.fromRGBO(
//                           201, 202, 203, 0.9), // Tamaño del avatar
//                       backgroundImage: StorageService.prefs
//                                   .getString('profileImage') !=
//                               null
//                           ? FileImage(File(
//                               StorageService.prefs.getString('profileImage')!))
//                           : null,
//                       child: StorageService.prefs.getString('profileImage') ==
//                               null
//                           ? Text(
//                               "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}")
//                           : null,
//                     ),
//                     const SizedBox(height: 20),

//                     Text(
//                       "${StorageService.prefs.getString('nombre')!} "
//                       "${StorageService.prefs.getString('apellido')}",
//                       style: const TextStyle(
//                           fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       StorageService.prefs.getString('cargo')!,
//                       style: const TextStyle(fontSize: 18, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Última conexión: ${StorageService.prefs.getString('ultconexion')!}",
//                       style: const TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 30),

//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder:
//                                 (context, animation, secondaryAnimation) =>
//                                     const EditProfileScreen(),
//                             transitionsBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               return SlideTransition(
//                                 position: Tween<Offset>(
//                                   begin: const Offset(0.0, 1.0),
//                                   end: Offset.zero,
//                                 ).animate(animation),
//                                 child: child,
//                               );
//                             },
//                           ),
//                         );
//                         // Acción de editar perfil
//                       },
//                       style: TextButton.styleFrom(
//                         foregroundColor:
//                             const Color.fromARGB(255, 141, 142, 143),
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8.0,
//                           horizontal: 20.0,
//                         ),
//                         side: const BorderSide(color: Colors.black26),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                       child: const Text(
//                         'Editar perfil',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     // Opciones de perfil
//                     // _buildProfileOption(
//                     //   icon: Icons.edit,
//                     //   label: 'Editar perfil',
//                     //   onTap: () {
//                     //     // Lógica para editar perfil
//                     //   },
//                     // ),
//                     _buildProfileOption(
//                       icon: Icons.history,
//                       label: 'Historial de registros',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder:
//                                 (context, animation, secondaryAnimation) =>
//                                     const HistorialAireacionJosefinaScreen(),
//                             transitionsBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               return SlideTransition(
//                                 position: Tween<Offset>(
//                                   begin: const Offset(0.0, 1.0),
//                                   end: Offset.zero,
//                                 ).animate(animation),
//                                 child: child,
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                     _buildProfileOption(
//                       icon: Icons.report,
//                       label: 'Reportes',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder:
//                                 (context, animation, secondaryAnimation) =>
//                                     const PiscinasReporteScreen(),
//                             transitionsBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               return SlideTransition(
//                                 position: Tween<Offset>(
//                                   begin: const Offset(0.0, 1.0),
//                                   end: Offset.zero,
//                                 ).animate(animation),
//                                 child: child,
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 30),

//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder:
//                                 (context, animation, secondaryAnimation) =>
//                                     const CerrarSesionScreen(),
//                             transitionsBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               // Usar CurvedAnimation para personalizar la curva y duración
//                               final fadeAnimation = CurvedAnimation(
//                                 parent: animation,
//                                 curve: Curves
//                                     .easeInOut, // Puedes probar diferentes curvas
//                               );

//                               return FadeTransition(
//                                 opacity: fadeAnimation,
//                                 child: child,
//                               );
//                             },
//                             transitionDuration: const Duration(
//                                 milliseconds: 250), // Duración de la transición
//                           ),
//                         );
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         // disabledBackgroundColor: Colors.amber,
//                         // elevation: 0,
//                         foregroundColor:
//                             const Color.fromARGB(255, 141, 142, 143),
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 20.0,
//                           horizontal: 120.0,
//                         ),
//                         side: const BorderSide(color: Colors.black26),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(100.0),
//                         ),
//                       ),
//                       child: const Text(
//                         'Cerrar sesión',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Método auxiliar para crear las opciones del perfil
//   Widget _buildProfileOption({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blue),
//       title: Text(label),
//       trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//       onTap: onTap,
//     );
//   }
// }

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ChartContainer extends StatelessWidget {
//   final String title;
//   final Widget child;

//   const ChartContainer({required this.title, required this.child, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(0, 0, 0, 0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color.fromRGBO(9, 31, 72, 1),
//             ),
//           ),
//           const SizedBox(height: 16),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class HistorialReportesScreen extends StatefulWidget {
//   const HistorialReportesScreen({super.key});

//   @override
//   State<HistorialReportesScreen> createState() =>
//       _HistorialReportesScreenState();
// }

// class _HistorialReportesScreenState extends State<HistorialReportesScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
//   DateTime _endDate = DateTime.now();
//   String _selectedPiscina = 'Todas';
//   String _selectedTipoReporte = 'Aireación';

//   final List<String> _piscinas = [
//     'Todas',
//     'PC106',
//     'PC107',
//     'PC108',
//     'PC111',
//     'PC113',
//     'PC114'
//   ];
//   final List<String> _tiposReporte = [
//     'Aireación',
//     'Bombeo',
//     'Consumo Energético'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       initialDateRange: DateTimeRange(
//         start: _startDate,
//         end: _endDate,
//       ),
//       firstDate: DateTime(2021),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color.fromRGBO(9, 31, 72, 1),
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Color.fromRGBO(9, 31, 72, 1),
//             ),
//             dialogBackgroundColor: Colors.white,
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null &&
//         picked != DateTimeRange(start: _startDate, end: _endDate)) {
//       setState(() {
//         _startDate = picked.start;
//         _endDate = picked.end;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Historial y Reportes',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             )),
//         backgroundColor: const Color.fromRGBO(9, 31, 72, 1),
//         elevation: 0,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           tabs: const [
//             Tab(text: 'Dashboard'),
//             Tab(text: 'Reportes'),
//             Tab(text: 'Gráficas'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildDashboardTab(),
//           _buildReportesTab(),
//           _buildGraficasTab(),
//         ],
//       ),
//     );
//   }

//   Widget _buildDashboardTab() {
//     return Container(
//       color: const Color.fromRGBO(245, 247, 250, 1),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildFilterSection(),
//             const SizedBox(height: 20),
//             _buildSummaryCards(),
//             const SizedBox(height: 20),
//             _buildRecentActivitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(0, 0, 0, 0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Filtros',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color.fromRGBO(9, 31, 72, 1),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: InkWell(
//                   onTap: () => _selectDateRange(context),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 16),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${DateFormat('dd/MM/yyyy').format(_startDate)} - ${DateFormat('dd/MM/yyyy').format(_endDate)}',
//                           style: TextStyle(color: Colors.grey.shade700),
//                         ),
//                         const Icon(Icons.calendar_today, size: 16),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // Aplicar filtros
//                 },
//                 icon: const Icon(Icons.filter_list),
//                 label: const Text('Aplicar'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromRGBO(9, 31, 72, 1),
//                   foregroundColor: Colors.white,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: DropdownButtonFormField<String>(
//                   value: _selectedPiscina,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     labelText: 'Piscina',
//                   ),
//                   items: _piscinas.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedPiscina = newValue!;
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: DropdownButtonFormField<String>(
//                   value: _selectedTipoReporte,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     labelText: 'Tipo de Reporte',
//                   ),
//                   items: _tiposReporte.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedTipoReporte = newValue!;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryCards() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Resumen General',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color.fromRGBO(9, 31, 72, 1),
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _buildSummaryCard(
//                 'Total Horas Aireación',
//                 '320.5',
//                 'horas',
//                 Icons.access_time,
//                 Colors.blue,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildSummaryCard(
//                 'Consumo Energético',
//                 '4,321',
//                 'kWh',
//                 Icons.bolt,
//                 Colors.orange,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: _buildSummaryCard(
//                 'Total Bombeos',
//                 '85',
//                 'operaciones',
//                 Icons.water,
//                 Colors.green,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildSummaryCard(
//                 'Piscina + Activa',
//                 'PC108',
//                 '98.5 hrs',
//                 Icons.star,
//                 Colors.purple,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryCard(
//       String title, String value, String units, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(0, 0, 0, 0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 14,
//                 ),
//               ),
//               Icon(
//                 icon,
//                 color: color,
//                 size: 24,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: TextStyle(
//               color: color,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             units,
//             style: TextStyle(
//               color: Colors.grey.shade700,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecentActivitySection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(0, 0, 0, 0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Actividad Reciente',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromRGBO(9, 31, 72, 1),
//                 ),
//               ),
//               Text(
//                 'Ver Todo',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildActivityItem(
//             'PC108',
//             'Aireación',
//             '08:30 - 14:45',
//             '6.25 horas',
//             '09/03/2025',
//             Colors.green,
//           ),
//           const Divider(),
//           _buildActivityItem(
//             'PC111',
//             'Bombeo',
//             '10:15 - 12:30',
//             '2.25 horas',
//             '09/03/2025',
//             Colors.blue,
//           ),
//           const Divider(),
//           _buildActivityItem(
//             'PC107',
//             'Aireación',
//             '07:00 - 13:30',
//             '6.5 horas',
//             '08/03/2025',
//             Colors.green,
//           ),
//           const Divider(),
//           _buildActivityItem(
//             'PC113',
//             'Bombeo',
//             '14:00 - 16:15',
//             '2.25 horas',
//             '08/03/2025',
//             Colors.blue,
//           ),
//           const Divider(),
//           _buildActivityItem(
//             'PC106',
//             'Aireación',
//             '09:45 - 15:30',
//             '5.75 horas',
//             '07/03/2025',
//             Colors.green,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActivityItem(String piscina, String tipo, String horario,
//       String duracion, String fecha, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 10,
//             height: 10,
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   piscina,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   tipo,
//                   style: TextStyle(
//                     color: color,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   horario,
//                   style: const TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   duracion,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             fecha,
//             style: TextStyle(
//               color: Colors.grey.shade600,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReportesTab() {
//     return Container(
//       color: const Color.fromRGBO(245, 247, 250, 1),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildFilterSection(),
//             const SizedBox(height: 20),
//             _buildReportesList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildReportesList() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(0, 0, 0, 0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Reportes Disponibles',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromRGBO(9, 31, 72, 1),
//                 ),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // Exportar o generar nuevo reporte
//                 },
//                 icon: const Icon(Icons.add, size: 16),
//                 label: const Text('Nuevo Reporte'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromRGBO(9, 31, 72, 1),
//                   foregroundColor: Colors.white,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildTableHeader(),
//           const Divider(),
//           _buildTableRow('Reporte Semanal Aireación', 'Todas',
//               '01/03/2025 - 07/03/2025', 'PDF'),
//           const Divider(),
//           _buildTableRow('Consumo Energético Mensual', 'PC108',
//               '01/02/2025 - 29/02/2025', 'Excel'),
//           const Divider(),
//           _buildTableRow('Histórico de Bombeos', 'PC106',
//               '15/01/2025 - 15/02/2025', 'PDF'),
//           const Divider(),
//           _buildTableRow(
//               'Resumen Operativo', 'Todas', '01/01/2025 - 31/01/2025', 'Excel'),
//           const Divider(),
//           _buildTableRow('Anomalías Detectadas', 'PC111',
//               '01/02/2025 - 29/02/2025', 'PDF'),
//           const Divider(),
//           _buildTableRow('Rendimiento de Aireación', 'PC114',
//               '01/01/2025 - 31/01/2025', 'Excel'),
//           const Divider(),
//           _buildTableRow(
//               'Horarios de Bombeo', 'PC113', '15/02/2025 - 01/03/2025', 'PDF'),
//           const SizedBox(height: 16),
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios, size: 16),
//                   onPressed: () {},
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: const Color.fromRGBO(9, 31, 72, 1),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: const Text(
//                     '1',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text('2'),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text('3'),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.arrow_forward_ios, size: 16),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTableHeader() {
//     return const Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: Text(
//             'Nombre del Reporte',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color.fromRGBO(9, 31, 72, 1),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             'Piscina',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color.fromRGBO(9, 31, 72, 1),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 3,
//           child: Text(
//             'Período',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color.fromRGBO(9, 31, 72, 1),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             'Acciones',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color.fromRGBO(9, 31, 72, 1),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTableRow(
//       String nombre, String piscina, String periodo, String tipo) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               nombre,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(piscina),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(periodo),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: tipo == 'PDF'
//                         ? Colors.red.withOpacity(0.1)
//                         : Colors.green.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Text(
//                     tipo,
//                     style: TextStyle(
//                       color: tipo == 'PDF' ? Colors.red : Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.download, size: 20),
//                   onPressed: () {},
//                   color: Colors.blue,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGraficasTab() {
//     return Container(
//       color: const Color.fromRGBO(245, 247, 250, 1),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildFilterSection(),
//             const SizedBox(height: 20),
//             _buildLineChartSection(),
//             const SizedBox(height: 20),
//             _buildBarChartSection(),
//             const SizedBox(height: 20),
//             _buildPieChartSection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLineChartSection() {
//     return ChartContainer(
//       title: 'Horas de Aireación por Piscina',
//       child: AspectRatio(
//         aspectRatio: 1.70,
//         child: Padding(
//           padding: const EdgeInsets.only(
//             right: 18,
//             left: 12,
//             top: 24,
//             bottom: 12,
//           ),
//           child: LineChart(
//             LineChartData(
//               gridData: FlGridData(
//                 show: true,
//                 drawVerticalLine: true,
//                 horizontalInterval: 1,
//                 verticalInterval: 1,
//               ),
//               titlesData: FlTitlesData(
//                 show: true,
//                 rightTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 topTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 30,
//                     interval: 1,
//                     getTitlesWidget: bottomTitleWidgets,
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 1,
//                     getTitlesWidget: leftTitleWidgets,
//                     reservedSize: 42,
//                   ),
//                 ),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: const Color(0xff37434d)),
//               ),
//               minX: 0,
//               maxX: 6,
//               minY: 0,
//               maxY: 6,
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: const [
//                     FlSpot(0, 3),
//                     FlSpot(1, 2),
//                     FlSpot(2, 5),
//                     FlSpot(3, 3.1),
//                     FlSpot(4, 4),
//                     FlSpot(5, 3),
//                     FlSpot(6, 4),
//                   ],
//                   isCurved: true,
//                   color: const Color.fromRGBO(9, 31, 72, 1),
//                   barWidth: 3,
//                   isStrokeCapRound: true,
//                   dotData: FlDotData(
//                     show: true,
//                   ),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     color: const Color.fromRGBO(9, 31, 72, 1).withOpacity(0.2),
//                   ),
//                 ),
//                 LineChartBarData(
//                   spots: const [
//                     FlSpot(0, 2),
//                     FlSpot(1, 4),
//                     FlSpot(2, 3.5),
//                     FlSpot(3, 5),
//                     FlSpot(4, 3.8),
//                     FlSpot(5, 2),
//                     FlSpot(6, 2.8),
//                   ],
//                   isCurved: true,
//                   color: Colors.blue,
//                   barWidth: 3,
//                   isStrokeCapRound: true,
//                   dotData: FlDotData(
//                     show: true,
//                   ),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     color: Colors.blue.withOpacity(0.2),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 12,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('Mar 3', style: style);
//         break;
//       case 1:
//         text = const Text('Mar 4', style: style);
//         break;
//       case 2:
//         text = const Text('Mar 5', style: style);
//         break;
//       case 3:
//         text = const Text('Mar 6', style: style);
//         break;
//       case 4:
//         text = const Text('Mar 7', style: style);
//         break;
//       case 5:
//         text = const Text('Mar 8', style: style);
//         break;
//       case 6:
//         text = const Text('Mar 9', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 12,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '1h';
//         break;
//       case 2:
//         text = '2h';
//         break;
//       case 3:
//         text = '3h';
//         break;
//       case 4:
//         text = '4h';
//         break;
//       case 5:
//         text = '5h';
//         break;
//       default:
//         return Container();
//     }

//     return Text(text, style: style, textAlign: TextAlign.left);
//   }

//   Widget _buildPieChartSection() {
//     return ChartContainer(
//       title: 'Distribución de Tipos de Reporte',
//       child: AspectRatio(
//         aspectRatio: 1,
//         child: PieChart(
//           PieChartData(
//             sections: [
//               PieChartSectionData(
//                 color: Colors.blue,
//                 value: 40,
//                 title: 'Aireación',
//                 radius: 50,
//                 titleStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               PieChartSectionData(
//                 color: Colors.orange,
//                 value: 30,
//                 title: 'Bombeo',
//                 radius: 50,
//                 titleStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               PieChartSectionData(
//                 color: Colors.green,
//                 value: 30,
//                 title: 'Consumo Energético',
//                 radius: 50,
//                 titleStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBarChartSection() {
//     return ChartContainer(
//         title: 'Consumo Energético por Piscina',
//         child: AspectRatio(
//             aspectRatio: 1.3,
//             child: Padding(
//                 padding: const EdgeInsets.only(
//                   right: 18,
//                   left: 12,
//                   top: 24,
//                   bottom: 12,
//                 ),
//                 child: BarChart(BarChartData(barGroups: [
//                   BarChartGroupData(
//                     x: 0,
//                     barRods: [
//                       BarChartRodData(
//                         toY: 450,
//                         color: Colors.blue,
//                         width: 22,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(6),
//                           topRight: Radius.circular(6),
//                         ),
//                       )
//                     ],
//                   ),
//                   BarChartGroupData(
//                     x: 1,
//                     barRods: [
//                       BarChartRodData(
//                         toY: 620,
//                         color: Colors.blue,
//                         width: 22,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(6),
//                           topRight: Radius.circular(6),
//                         ),
//                       )
//                     ],
//                   ),
//                   BarChartGroupData(
//                     x: 2,
//                     barRods: [
//                       BarChartRodData(
//                         toY: 380,
//                         color: Colors.blue,
//                         width: 22,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(6),
//                           topRight: Radius.circular(6),
//                         ),
//                       )
//                     ],
//                   ),
//                 ])))));
//   }
// }

import 'package:appnaturisa/helpers/theme.dart';
import 'package:appnaturisa/screens/josefina/piscina_reporte_screen.dart';
import 'package:flutter/material.dart';
import 'package:appnaturisa/screens/josefina/historial_Josefina_graca_screen.dart';

class HistorialReportesScreen extends StatefulWidget {
  const HistorialReportesScreen({super.key});

  @override
  State<HistorialReportesScreen> createState() =>
      _HistorialReportesScreenState();
}

class _HistorialReportesScreenState extends State<HistorialReportesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Estados para filtros en la pestaña Historial
  String _selectedHistorialType = 'Aireación';
  final List<String> _historialTypes = [
    'Aireación',
    'Bombeo',
    'Actividad General'
  ];

  // Estados para filtros en la pestaña Reportes
  String _selectedReporteType = 'Consumo Energético';
  final List<String> _reporteTypes = [
    'Consumo Energético',
    'Rendimiento',
    'Anomalías'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {}); // Actualizar UI cuando cambia de pestaña
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primaryBlue,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 20, // Aumentar altura para el TabBar
        title: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              icon: Icon(Icons.history),
              text: 'Historial',
            ),
            Tab(
              icon: Icon(Icons.description),
              text: 'Reportes',
            ),
          ],
        ),
        // Eliminar la propiedad bottom
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHistorialTab(),
          _buildReportesTab(),
        ],
      ),
    );
  }

  Widget _buildHistorialTab() {
    // Mostrar la pantalla de historial existente
    return Column(
      children: [
        // Sección de filtros para historial
        // Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         AppTheme.primaryBlue,
        //         Color(0xFF0A4A8C),
        //         Color(0xFF0C5DA6),
        //       ],
        //       stops: const [0.0, 0.5, 1.0],
        //     ),
        //   ),
        //   padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        //   child: Card(
        //     elevation: 4,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             children: [
        //               const Icon(
        //                 Icons.filter_list,
        //                 size: 20,
        //                 color: AppTheme.primaryBlue,
        //               ),
        //               const SizedBox(width: 8),
        //               Text(
        //                 'Tipo de historial:',
        //                 style: TextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.w500,
        //                   color: AppTheme.textDark.withOpacity(0.8),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(height: 12),
        //           _buildTypeChips(
        //             _historialTypes,
        //             _selectedHistorialType,
        //             (value) => setState(() => _selectedHistorialType = value),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        // Contenido del historial (integración con historial_josefina_graca_screen)
        Expanded(
          child: _selectedHistorialType == 'Aireación'
              ? const HistorialAireacionJosefinaScreen()
              : _buildPlaceholderContent(_selectedHistorialType),
        ),
      ],
    );
  }

  Widget _buildReportesTab() {
    return Column(
      children: [
        // Sección de filtros para reportes
        // Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         AppTheme.primaryBlue,
        //         Color(0xFF0A4A8C),
        //         Color(0xFF0C5DA6),
        //       ],
        //       stops: const [0.0, 0.5, 1.0],
        //     ),
        //   ),
        //   padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        //   child: Card(
        //     elevation: 4,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             children: [
        //               const Icon(
        //                 Icons.filter_list,
        //                 size: 20,
        //                 color: AppTheme.primaryBlue,
        //               ),
        //               const SizedBox(width: 8),
        //               Text(
        //                 'Tipo de reporte:',
        //                 style: TextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.w500,
        //                   color: AppTheme.textDark.withOpacity(0.8),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(height: 12),
        //           _buildTypeChips(
        //             _reporteTypes,
        //             _selectedReporteType,
        //             (value) => setState(() => _selectedReporteType = value),
        //           ),

        //           // Selección de fechas
        //           const SizedBox(height: 16),
        //           InkWell(
        //             onTap: () {
        //               // Mostrar selector de fechas
        //             },
        //             child: Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 16, vertical: 12),
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: AppTheme.mediumGray),
        //                 borderRadius: BorderRadius.circular(8),
        //               ),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     'Seleccionar rango de fechas',
        //                     style: TextStyle(
        //                       color: AppTheme.textDark.withOpacity(0.7),
        //                     ),
        //                   ),
        //                   Icon(
        //                     Icons.calendar_today,
        //                     size: 18,
        //                     color: AppTheme.accentBlue,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        // Contenido de reportes
        Expanded(
          child: _selectedHistorialType == 'Aireación'
              ? const PiscinasReporteScreen()
              : _buildPlaceholderContent(_selectedHistorialType),
        ),
      ],
    );
  }

  // Widget para los chips de selección de tipo
  Widget _buildTypeChips(
      List<String> options, String selected, Function(String) onSelected) {
    return Wrap(
      spacing: 8,
      children: options.map((type) {
        final bool isSelected = selected == type;

        return ChoiceChip(
          label: Text(type),
          selected: isSelected,
          selectedColor: AppTheme.accentBlue.withOpacity(0.7),
          backgroundColor: AppTheme.lightGray,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textDark,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          onSelected: (bool selected) {
            if (selected) {
              onSelected(type);
            }
          },
        );
      }).toList(),
    );
  }

  // Contenido de placeholder para secciones no implementadas
  Widget _buildPlaceholderContent(String type) {
    IconData icon;
    switch (type) {
      case 'Bombeo':
        icon = Icons.water_drop;
        break;
      case 'Actividad General':
        icon = Icons.dashboard;
        break;
      default:
        icon = Icons.air;
    }

    return Container(
      color: AppTheme.lightGray,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Información de Historial',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.lightGray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.mediumGray),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 64,
                        color: AppTheme.accentBlue.withOpacity(0.5),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Historial de $type',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textDark.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Seleccione filtros para visualizar información',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textDark.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Contenido de reportes según el tipo seleccionado
  Widget _buildReporteContent(String tipo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reporte de $tipo',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(height: 16),

                // Contenido del reporte según el tipo
                _buildReporteDataTable(tipo),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Sección de acciones
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Acciones',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildActionButton(
                      'Exportar',
                      Icons.file_download,
                      () {
                        // Acción de exportar
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildActionButton(
                      'Compartir',
                      Icons.share,
                      () {
                        // Acción de compartir
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildActionButton(
                      'Imprimir',
                      Icons.print,
                      () {
                        // Acción de imprimir
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tabla de datos de reporte según tipo
  Widget _buildReporteDataTable(String tipo) {
    List<DataRow> rows = [];

    switch (tipo) {
      case 'Consumo Energético':
        rows = [
          DataRow(cells: [
            DataCell(Text('PC106')),
            DataCell(Text('1,250 kWh')),
            DataCell(Text('08/03/2025')),
          ]),
          DataRow(cells: [
            DataCell(Text('PC108')),
            DataCell(Text('980 kWh')),
            DataCell(Text('07/03/2025')),
          ]),
          DataRow(cells: [
            DataCell(Text('PC111')),
            DataCell(Text('1,340 kWh')),
            DataCell(Text('06/03/2025')),
          ]),
        ];
        break;

      case 'Rendimiento':
        rows = [
          DataRow(cells: [
            DataCell(Text('PC107')),
            DataCell(Text('92%')),
            DataCell(Text('08/03/2025')),
          ]),
          DataRow(cells: [
            DataCell(Text('PC113')),
            DataCell(Text('87%')),
            DataCell(Text('07/03/2025')),
          ]),
          DataRow(cells: [
            DataCell(Text('PC114')),
            DataCell(Text('94%')),
            DataCell(Text('06/03/2025')),
          ]),
        ];
        break;

      case 'Anomalías':
        rows = [
          DataRow(cells: [
            DataCell(Text('PC108')),
            DataCell(Text('Sobrecalentamiento')),
            DataCell(Text('08/03/2025')),
          ]),
          DataRow(cells: [
            DataCell(Text('PC111')),
            DataCell(Text('Presión baja')),
            DataCell(Text('05/03/2025')),
          ]),
          DataRow(cells: [
            DataCell(Text('PC106')),
            DataCell(Text('Fluctuación')),
            DataCell(Text('04/03/2025')),
          ]),
        ];
        break;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 30,
        headingRowColor: MaterialStateProperty.all(AppTheme.lightGray),
        columns: [
          DataColumn(
            label: Text(
              'Piscina',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              tipo == 'Anomalías' ? 'Descripción' : 'Medición',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Fecha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
          ),
        ],
        rows: rows,
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 18),
        label: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppTheme.primaryBlue,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: AppTheme.primaryBlue.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}
