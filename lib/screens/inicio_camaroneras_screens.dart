import 'package:appnaturisa/providers/navigation_provider.dart';
import 'package:appnaturisa/screens/camaroneras_screen.dart';
import 'package:appnaturisa/screens/cerrar_sesion_screen.dart';
import 'package:appnaturisa/screens/josefina/home_screen.dart';
import 'package:appnaturisa/screens/josefina/monitoreo_screen.dart';
import 'package:appnaturisa/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InicioCamaronerasScreen extends StatefulWidget {
  // Convertido a StatefulWidget
  const InicioCamaronerasScreen({super.key});

  @override
  State<InicioCamaronerasScreen> createState() =>
      _InicioCamaronerasScreenState();
}

class _InicioCamaronerasScreenState extends State<InicioCamaronerasScreen> {
  // Lista de pantallas que cambiarán cuando se toque una opción
  static final List<Widget> _pages = <Widget>[
    CamaroneraScreen(),
    // MonitoreoScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    // Sincronizar el índice local con el global al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigationProvider =
          Provider.of<NavigationProvider>(context, listen: false);

      // Si el índice global se ha establecido, usarlo
      if (NavigationProvider.globalIndex != navigationProvider.selectedIndex) {
        navigationProvider.setSelectedIndex(NavigationProvider.globalIndex);
      }
    });
  }

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
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _pages[navigationProvider.selectedIndex],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
            BottomAppBar(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    label: 'Inicio',
                    index: 0,
                    selectedIndex: navigationProvider.selectedIndex,
                    onTap: (index) {
                      // Actualizamos tanto el índice local como el global
                      NavigationProvider.setGlobalIndex(index);
                      navigationProvider.setSelectedIndex(index);
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.person,
                    label: 'Perfil',
                    index: 1,
                    selectedIndex: navigationProvider.selectedIndex,
                    onTap: (index) {
                      // Actualizamos tanto el índice local como el global
                      NavigationProvider.setGlobalIndex(index);
                      navigationProvider.setSelectedIndex(index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir los elementos de navegación
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
    required Function(int) onTap,
  }) {
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              color: selectedIndex == index
                  ? const Color.fromARGB(255, 4, 63, 122)
                  : const Color.fromARGB(255, 143, 143, 143),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == index
                    ? const Color.fromARGB(255, 4, 63, 122)
                    : const Color.fromARGB(255, 143, 143, 143),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
