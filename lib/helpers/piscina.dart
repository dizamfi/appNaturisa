import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Piscina {
  static List<Widget> circuitosActivos(int inputLN, int numCirc, double size) {
    List<Widget> widgets = [];
    final listCircuitos = [
      // 1 << 13,
      // 1 << 14,
      // 1 << 15,
      // 1 << 0,
      // 1 << 1,
      // 1 << 2,
      // 1 << 3,
      // 1 << 4,
      // 1 << 5,
      // 1 << 6,
      // 1 << 7,
      // 1 << 8,

      1 << 13,
      1 << 14,
      1 << 15,
      1 << 0,
      1 << 1,
      1 << 2,
    ];

    for (int i = 0; i < numCirc; i++) {
      if ((listCircuitos[i] & inputLN) != 0) {
        widgets.add(FaIcon(
          FontAwesomeIcons.powerOff,
          color: Colors.green,
          size: size,
        ));
        widgets.add(const SizedBox(
          width: 3,
        ));
      } else {
        widgets.add(FaIcon(
          FontAwesomeIcons.powerOff,
          color: Colors.grey,
          size: size,
        ));
        widgets.add(const SizedBox(
          width: 3,
        ));
      }
    }
    return widgets;
  }

  static bool contieneSoloArreglosVacios(List apiDataList) {
    if (apiDataList.isEmpty) {
      return true; // Si la lista principal está vacía, retorna verdadero
    }

    for (var element in apiDataList) {
      if (element is List) {
        if (element.isNotEmpty) {
          return false; // Si encuentra un arreglo no vacío, retorna falso
        }
      } else {
        return false; // Si encuentra un elemento que no es una lista, retorna falso
      }
    }

    return true; // Si todos los elementos son arreglos vacíos, retorna verdadero
  }
}
