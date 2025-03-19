// // Archivo: d:\Melacorp\Naturisa\appnaturisa\lib\utils\data_access_utils.dart
// import 'package:flutter/material.dart';

// class DataAccessUtils {
//   /// Función genérica para acceder a valores anidados de forma segura
//   static T? getNestedValue<T>(
//       dynamic data, List<dynamic> path, T defaultValue) {
//     try {
//       dynamic current = data;
//       for (var key in path) {
//         if (current == null) return defaultValue;
//         if (key is int) {
//           if (current is List && current.length > key) {
//             current = current[key];
//           } else {
//             return defaultValue;
//           }
//         } else {
//           if (current is Map && current.containsKey(key)) {
//             current = current[key];
//           } else {
//             return defaultValue;
//           }
//         }
//       }
//       return current as T? ?? defaultValue;
//     } catch (e) {
//       debugPrint('Error accediendo a datos: $e');
//       return defaultValue;
//     }
//   }

//   /// Función para verificar si los datos están completos
//   static bool areDataComplete(List<dynamic>? data, List<int> requiredLengths) {
//     if (data == null || data.isEmpty) return false;
//     if (data.length < requiredLengths.length) return false;

//     for (int i = 0; i < requiredLengths.length; i++) {
//       if (i >= data.length) return false;
//       if (data[i] == null) return false;
//       if (data[i] is List && (data[i] as List).isEmpty) return false;
//       if (requiredLengths[i] > 0 &&
//           data[i] is List &&
//           (data[i] as List).length < requiredLengths[i]) return false;
//     }

//     return true;
//   }
// }

// /// Widget reutilizable para pantallas de carga
// class LoadingScreen extends StatelessWidget {
//   const LoadingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

// /// Widget reutilizable para pantallas de error
// class ErrorScreen extends StatelessWidget {
//   final String message;
//   final VoidCallback? onRetry;

//   const ErrorScreen({
//     Key? key,
//     this.message = 'Datos incompletos o en sincronización',
//     this.onRetry,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.warning_amber_rounded, size: 50, color: Colors.amber),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           if (onRetry != null) ...[
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: onRetry,
//               child: Text('Reintentar'),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DataAccessUtils {
  /// Función genérica para acceder a valores anidados de forma segura
  static T getNestedValue<T>(dynamic data, List<dynamic> path, T defaultValue) {
    try {
      dynamic current = data;
      for (var key in path) {
        if (current == null) return defaultValue;
        if (key is int) {
          if (current is List && current.length > key) {
            current = current[key];
          } else {
            return defaultValue;
          }
        } else {
          if (current is Map && current.containsKey(key)) {
            current = current[key];
          } else {
            return defaultValue;
          }
        }
      }
      return current as T? ?? defaultValue;
    } catch (e) {
      debugPrint('Error accediendo a datos: $e');
      return defaultValue;
    }
  }

  /// Función para verificar si los datos están completos
  static bool areDataComplete(List<dynamic>? data, List<int> requiredLengths) {
    if (data == null || data.isEmpty) return false;
    if (data.length < requiredLengths.length) return false;

    for (int i = 0; i < requiredLengths.length; i++) {
      if (i >= data.length) return false;
      if (data[i] == null) return false;
      if (data[i] is List && (data[i] as List).isEmpty) return false;
      if (requiredLengths[i] > 0 &&
          data[i] is List &&
          (data[i] as List).length < requiredLengths[i]) return false;
    }

    return true;
  }
}

/// Widget reutilizable para pantallas de carga
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// Widget reutilizable para pantallas de error
class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorScreen({
    Key? key,
    this.message = 'Datos incompletos o en sincronización',
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded, size: 50, color: Colors.amber),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ],
      ),
    );
  }
}
