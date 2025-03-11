import 'package:appnaturisa/providers/navigation_provider.dart';
import 'package:appnaturisa/screens/camaroneras_screen.dart';
import 'package:appnaturisa/screens/cerrar_sesion_screen.dart';
import 'package:appnaturisa/screens/josefina/home_screen.dart';
import 'package:appnaturisa/screens/josefina/monitoreo_screen.dart';
import 'package:appnaturisa/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InicioCamaronerasScreen extends StatelessWidget {
  const InicioCamaronerasScreen({super.key});

  // Lista de pantallas que cambiarán cuando se toque una opción
  static final List<Widget> _pages = <Widget>[
    CamaroneraScreen(),
    // MonitoreoScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CerrarSesionScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Usar CurvedAnimation para personalizar la curva y duración
              final fadeAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, // Puedes probar diferentes curvas
              );

              return FadeTransition(
                opacity: fadeAnimation,
                child: child,
              );
            },
            transitionDuration:
                const Duration(milliseconds: 250), // Duración de la transición
          ),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedSwitcher(
          duration:
              const Duration(milliseconds: 250), // Duración de la transición
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _pages[navigationProvider
              .selectedIndex], // Cambia el contenido según el índice seleccionado
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
            BottomAppBar(
              // elevation: 5,
              // shape: const CircularNotchedRectangle(),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    label: 'Inicio',
                    index: 0,
                    selectedIndex: navigationProvider.selectedIndex,
                    onTap: navigationProvider.setSelectedIndex,
                  ),
                  _buildNavItem(
                    icon: Icons.person,
                    label: 'Perfil',
                    index: 1,
                    selectedIndex: navigationProvider.selectedIndex,
                    onTap: navigationProvider.setSelectedIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construir los elementos de navegación con icono y texto personalizado
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
    required Function(int) onTap,
  }) {
    return InkWell(
      onTap: () => onTap(index), // Detecta el toque de forma precisa
      borderRadius:
          BorderRadius.circular(8), // Añade un borde redondeado opcional
      splashColor: Colors.transparent, // Elimina el efecto de splash
      highlightColor: Colors.transparent, // Elimina el efecto de highlight
      hoverColor: Colors.transparent, // Elimina el efecto de hover
      focusColor: Colors.transparent, // Elimina el efecto de focus
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 18), // Ajustar el padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              color: selectedIndex == index
                  ? const Color.fromARGB(255, 4, 63, 122)
                  : const Color.fromARGB(255, 143, 143, 143), // Color del ícono
            ),
            const SizedBox(height: 4), // Ajustar la separación
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == index
                    ? const Color.fromARGB(255, 4, 63, 122)
                    : const Color.fromARGB(
                        255, 143, 143, 143), // Color del texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
