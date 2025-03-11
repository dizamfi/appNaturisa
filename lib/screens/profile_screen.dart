import 'dart:io';

import 'package:appnaturisa/providers/user_provider.dart';
import 'package:appnaturisa/screens/cerrar_sesion_screen.dart';
import 'package:appnaturisa/screens/josefina/edit_profile_screen.dart';
import 'package:appnaturisa/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Callback que se usará como listener
  void _profileUpdatedListener() {
    if (UserProvider.profileUpdated.value) {
      if (mounted) {
        setState(() {});
      }
      // Reinicia el valor del ValueNotifier para evitar actualizaciones repetidas
      UserProvider.profileUpdated.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    UserProvider.profileUpdated.addListener(_profileUpdatedListener);
  }

  @override
  void dispose() {
    super.dispose();
    UserProvider.profileUpdated.removeListener(_profileUpdatedListener);
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
        toolbarHeight: 0,
        // leadingWidth: 0,

        // centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color.fromRGBO(201, 202, 203, 0.5),
                    backgroundImage: StorageService.prefs
                                .getString('profileImage') !=
                            null
                        ? FileImage(File(
                            StorageService.prefs.getString('profileImage')!))
                        : null,
                    child:
                        StorageService.prefs.getString('profileImage') == null
                            ? Text(
                                "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                                style: GoogleFonts.roboto(fontSize: 24),
                              )
                            : null,
                  ),
                  const SizedBox(height: 20),

                  // Nombre y Cargo
                  Text(
                    "${StorageService.prefs.getString('nombre')!} "
                    "${StorageService.prefs.getString('apellido')}",
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    StorageService.prefs.getString('cargo')!,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Última conexión: ${StorageService.prefs.getString('ultconexion')!}",
                    style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // Botón Editar Perfil

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const EditProfileScreen(),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 63, 122),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Editar perfil',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       PageRouteBuilder(
                  //         pageBuilder:
                  //             (context, animation, secondaryAnimation) =>
                  //                 const EditProfileScreen(),
                  //         transitionsBuilder:
                  //             (context, animation, secondaryAnimation, child) {
                  //           return SlideTransition(
                  //             position: Tween<Offset>(
                  //               begin: const Offset(0.0, 1.0),
                  //               end: Offset.zero,
                  //             ).animate(animation),
                  //             child: child,
                  //           );
                  //         },
                  //       ),
                  //     );
                  //     // Acción de editar perfil
                  //   },
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: const Color.fromARGB(255, 141, 142, 143),
                  //     padding: const EdgeInsets.symmetric(
                  //       vertical: 8.0,
                  //       horizontal: 20.0,
                  //     ),
                  //     side: const BorderSide(color: Colors.black26),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20.0),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     'Editar perfil',
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  // ),

                  const SizedBox(height: 40),

                  // Información Adicional
                  _buildInfoTile(
                      title: 'Email',
                      value: StorageService.prefs.getString('email') ??
                          'diiszamb@espol.edu.ec'),
                  _buildInfoTile(
                      title: 'Teléfono',
                      value: StorageService.prefs.getString('celular') ??
                          '+593 9 9999 9999'),
                  // _buildInfoTile(
                  //     title: 'Ubicación',
                  //     value: StorageService.prefs.getString('ubicacion') ??
                  //         'No disponible'),
                  // _buildInfoTile(
                  //     title: 'Fecha de Ingreso',
                  //     value: StorageService.prefs.getString('fechaIngreso') ??
                  //         'No disponible'),
                  // _buildInfoTile(
                  //     title: 'ID de Empleado',
                  //     value: StorageService.prefs.getString('idEmpleado') ??
                  //         'No disponible'),

                  const SizedBox(height: 40),

                  // Botón Cerrar Sesión
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const CerrarSesionScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final fadeAnimation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              );

                              return FadeTransition(
                                opacity: fadeAnimation,
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 250),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black26),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Cerrar sesión',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         PageRouteBuilder(
                  //           pageBuilder:
                  //               (context, animation, secondaryAnimation) =>
                  //                   const EditProfileScreen(),
                  //           transitionsBuilder: (context, animation,
                  //               secondaryAnimation, child) {
                  //             return SlideTransition(
                  //               position: Tween<Offset>(
                  //                 begin: const Offset(0.0, 1.0),
                  //                 end: Offset.zero,
                  //               ).animate(animation),
                  //               child: child,
                  //             );
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: const Color.fromARGB(255, 4, 63, 122),
                  //       padding: const EdgeInsets.symmetric(vertical: 15),
                  //       textStyle: const TextStyle(fontSize: 18),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(25),
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Cerrar sesión',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
