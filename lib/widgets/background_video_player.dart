import 'package:appnaturisa/providers/navigation_provider.dart';
import 'package:appnaturisa/screens/josefina/comunicaciones_josefina_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GifCarousel extends StatefulWidget {
  const GifCarousel({super.key});

  @override
  _GifCarouselState createState() => _GifCarouselState();
}

class _GifCarouselState extends State<GifCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  double _progress = 0.0;

  final List<String> _gifPaths = [
    'assets/prueba2.gif',
    'assets/imageAntena.png',
    'assets/iii.png',
  ];

  final List<List<String>> _textLines = [
    ['Monitorea', 'tu Camaronera', 'en tiempo real'],
    ['Revisa el', 'estado de las', 'comunicaciones'],
    ['Consulta', 'historiales de', 'tu camaronera'],
  ];

  List<bool> _barsCompleted = [false, false, false];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 40), (Timer timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _markBarAsCompleted();
          _moveToNextPage();
        }
      });
    });
  }

  void _markBarAsCompleted() {
    _barsCompleted[_currentPage] = true;
    _progress = 0.0;
  }

  void _moveToNextPage() {
    if (_currentPage < _gifPaths.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.jumpToPage(0);
        setState(() {
          _currentPage = 0;
          _barsCompleted = [false, false, false];
        });
      });
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      if (page > _currentPage) {
        // Avance manual: Marca las barras anteriores como completadas
        for (int i = 0; i < page; i++) {
          _barsCompleted[i] = true;
        }
      } else if (page < _currentPage) {
        // Retroceso manual: Vacía la barra del GIF actual y reinicia el progreso
        _barsCompleted[page] = false;
        _progress = 0.0;
      }

      _currentPage = page;
      _startAutoScroll(); // Reinicia el temporizador para pintar progresivamente
    });
  }

  void _navigateBasedOnGif(BuildContext context) {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    switch (_currentPage) {
      case 0:
        navigationProvider.setSelectedIndex(1);
        break;
      case 1:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ComunicacionesJosefinaScreen(),
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
                const Duration(milliseconds: 600), // Duración de la transición
          ),
        );

        // Navigator.pop(context); // Volver al InicioScreen
        break;
      case 2:
        navigationProvider.setSelectedIndex(3);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // PageView para mostrar los GIFs
          PageView.builder(
            controller: _pageController,
            itemCount: _gifPaths.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _gifPaths[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
            onPageChanged: _onPageChanged,
          ),

          // Texto dinámico
          Positioned(
            top: 220.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _textLines[_currentPage]
                      .map((line) => Text(
                            line,
                            style: GoogleFonts.anton(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ))
                      .toList(),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateBasedOnGif(context);
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(23, 223, 106, 1),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_outward_rounded,
                          size: 30, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Indicador de progreso
          Positioned(
            bottom: 50.0,
            left: 20.0,
            child: Row(
              children: List.generate(_gifPaths.length, (index) {
                return Container(
                  width: 65,
                  height: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.0),
                    child: LinearProgressIndicator(
                      value: _barsCompleted[index]
                          ? 1.0 // Barra completada
                          : (index == _currentPage
                              ? _progress
                              : 0.0), // Barra en progreso
                      color: const Color.fromRGBO(23, 223, 106, 1),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// Pantallas de ejemplo
class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla 1')),
      body: const Center(child: Text('Contenido de la pantalla 1')),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla 2')),
      body: const Center(child: Text('Contenido de la pantalla 2')),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla 3')),
      body: const Center(child: Text('Contenido de la pantalla 3')),
    );
  }
}
