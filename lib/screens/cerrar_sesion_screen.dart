import 'package:appnaturisa/providers/navigation_provider.dart';
import 'package:appnaturisa/providers/user_provider.dart';
import 'package:appnaturisa/screens/inicio_sesion_screens.dart';
import 'package:appnaturisa/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class CerrarSesionScreen extends StatelessWidget {
  const CerrarSesionScreen({super.key});

  String _obtenerFechaHoraActual() {
    // Capturar la fecha y hora actual
    DateTime ahora = DateTime.now();

    // Formatear la fecha y hora
    String formato = DateFormat('dd/MM/yyyy, hh:mm a').format(ahora);

    print(formato);

    return formato;
  }

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      // transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //   return FadeTransition(opacity: animation, child: child);
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    String? user = StorageService.prefs.getString('user');

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 0,
        // leadingWidth: 0,

        // centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      // Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
      body: PopScope(
        canPop: false,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: 10,
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      // color: Color.fromRGBO(12, 31, 122, 0.9),
                      color: Colors.black,
                      size: 45,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        // color: Color.fromRGBO(12, 31, 122, 0.9),
                        color: Colors.black,
                        size: 45,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Cerrar sesión...',
                        style: TextStyle(
                            // color: Color.fromRGBO(12, 31, 122, 0.9),
                            color: Colors.black,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '¿Estás seguro que deseas cerrar sesión?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   top: MediaQuery.of(context).size.height * 0.45,
                //   width: MediaQuery.of(context).size.width * 0.7,
                //   child: Icon(
                //     Icons.lock_outline_rounded, // Ícono de candado cerrado
                //     size: 130, // Tamaño del ícono
                //     color: Colors.grey, // Color del ícono
                //   ),
                // ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.8,
                  bottom: 80,
                  child: TextButton(
                    onPressed: () {
                      navigationProvider.setSelectedIndex(0);

                      // final fecha =

                      UserProvider.updateUser(user!, {
                        "estado": "desconectado",
                        "ultconexion": _obtenerFechaHoraActual()
                      });

                      Navigator.of(context).pushAndRemoveUntil(
                        _createRoute(InicioSesionScreen()),
                        (Route<dynamic> route) => false,
                      );
                      // Navigator.pushReplacementNamed(
                      //     context, 'inicio_sesion_screen');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 141, 142, 143),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        // horizontal: 120.0,
                      ),
                      side: const BorderSide(color: Colors.black26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: const Text(
                      'Cerrar sesión',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
