import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  // Variable estática para acceso global al índice
  static int globalIndex = 0;

  int _selectedIndex = 0;

  // Constructor que inicializa con el valor global
  NavigationProvider() {
    _selectedIndex = globalIndex;
  }

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    // Actualizamos también el índice global
    globalIndex = index;
    notifyListeners();
  }

  // Método estático para resetear a la página de inicio desde cualquier parte
  static void resetToHome() {
    globalIndex = 0;
  }

  // Método estático para actualizar el índice desde cualquier parte
  static void setGlobalIndex(int index) {
    globalIndex = index;
  }
}
