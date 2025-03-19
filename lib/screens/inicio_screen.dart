import 'package:appnaturisa/providers/navigation_provider.dart';
import 'package:appnaturisa/screens/camaroneras_screen.dart';
import 'package:appnaturisa/screens/cerrar_sesion_screen.dart';
import 'package:appnaturisa/screens/inicio_camaroneras_screens.dart';
import 'package:appnaturisa/screens/josefina/historial_screen.dart';
import 'package:appnaturisa/screens/josefina/home_screen.dart';
import 'package:appnaturisa/screens/josefina/monitoreo_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  // Lista de pantallas que cambiarán cuando se toque una opción
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    MonitoreoScreen(),
    HistorialReportesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        // Resetear el índice globalmente
        NavigationProvider.resetToHome();

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const InicioCamaronerasScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final fadeAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              );

              return FadeTransition(
                opacity: fadeAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 250),
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
            // Reemplazo del BottomAppBar para mejor alineación
            BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                height: 60, // Altura fija para el contenedor
                child: Row(
                  children: [
                    _buildNavItem(
                      icon: Icons.home,
                      label: 'Inicio',
                      index: 0,
                      selectedIndex: navigationProvider.selectedIndex,
                      onTap: navigationProvider.setSelectedIndex,
                    ),
                    _buildNavItem(
                      icon: FontAwesomeIcons.gears,
                      label: 'Monitoreo',
                      index: 1,
                      selectedIndex: navigationProvider.selectedIndex,
                      onTap: navigationProvider.setSelectedIndex,
                    ),
                    _buildNavItem(
                      icon: Icons.history,
                      label: 'Historial',
                      index: 2,
                      selectedIndex: navigationProvider.selectedIndex,
                      onTap: navigationProvider.setSelectedIndex,
                    ),
                  ],
                ),
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
    final bool isSelected = selectedIndex == index;
    final Color activeColor = const Color.fromARGB(255, 4, 63, 122);
    final Color inactiveColor = const Color.fromARGB(255, 143, 143, 143);

    return Expanded(
      // Usar Expanded para distribuir uniformemente
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: SizedBox(
          height: 60, // Altura fija para asegurar consistencia
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centro vertical
            children: [
              FaIcon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 22, // Tamaño consistente
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? activeColor : inactiveColor,
                  // fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
