import 'package:appnaturisa/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ParametrosGeneralesBombeo extends StatelessWidget {
  final int grupoNumero;
  final bool isActive;
  final int numeroBombas;
  final int numeroBombasActivas;
  final Map<dynamic, dynamic> tcpData;

  const ParametrosGeneralesBombeo({
    super.key,
    required this.grupoNumero,
    required this.isActive,
    required this.tcpData,
    required this.numeroBombas,
    required this.numeroBombasActivas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: isActive
              ? AppTheme.primaryBlue.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado mejorado con Bombas Activas integrado
          Row(
            children: [
              // Icono de grupo
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.primaryBlue.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FontAwesomeIcons.layerGroup,
                  color: isActive ? AppTheme.primaryBlue : Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Título del grupo
              Text(
                'Grupo $grupoNumero',
                style: TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              // Indicador de bombas activas + estado
              Row(
                children: [
                  // Bombas activas
                  const SizedBox(width: 4),
                  Text(
                    '$numeroBombasActivas/$numeroBombas',
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Estado activo/inactivo
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.green.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: isActive ? Colors.green : Colors.grey,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isActive ? 'Activo' : 'Inactivo',
                          style: TextStyle(
                            color: isActive ? Colors.green : Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: AppTheme.mediumGray.withOpacity(0.5)),
          const SizedBox(height: 16),

          // SECCIÓN: BANCO DE CAPACITORES
          // Encabezado con título y botón de detalles
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.batteryHalf,
                color: AppTheme.primaryBlue,
                size: 16,
              ),
              const SizedBox(width: 8),
              const Text(
                'Banco de Capacitores',
                style: TextStyle(
                  color: AppTheme.primaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () =>
                    _mostrarDetallesCapacitores(context, grupoNumero, tcpData),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: Icon(
                  FontAwesomeIcons.chartLine,
                  size: 12,
                ),
                label: Text('Detalles'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Indicadores de capacitores con mejor alineación
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildMiniIndicador(
                    'Factor de Potencia',
                    tcpData['FP'] ?? '0.00',
                    Colors.purple,
                    FontAwesomeIcons.gaugeHigh,
                  ),
                ),
                Expanded(
                  child: _buildMiniIndicador(
                    'Potencia',
                    tcpData['Pot Inst'] ?? '0 Kw',
                    Colors.green,
                    FontAwesomeIcons.lightbulb,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(color: AppTheme.mediumGray.withOpacity(0.5)),
          const SizedBox(height: 16),

          // SECCIÓN: TRANSFORMADORES
          // SECCIÓN: TRANSFORMADORES - Versión simplificada
          Row(
            children: [
              Icon(
                FontAwesomeIcons.bolt,
                color: AppTheme.primaryBlue,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Transformadores',
                style: TextStyle(
                  color: AppTheme.primaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () =>
                    _mostrarDetallesTransformadores(context, grupoNumero),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: Icon(
                  FontAwesomeIcons.eye,
                  size: 12,
                ),
                label: Text('Detalles'),
              ),
            ],
          ),
// Eliminar completamente el anterior Padding con indicadores de temperatura y nivel de aceite
// const SizedBox(height: 12), - Eliminar este espaciado adicional ya que no hay indicadores
          // const SizedBox(height: 12),

          const SizedBox(height: 16),
          Divider(color: AppTheme.mediumGray.withOpacity(0.5)),
          const SizedBox(height: 16),

          // SECCIÓN: BOMBAS EN ESTE GRUPO
          _buildBombasListCompacto(grupoNumero),
        ],
      ),
    );
  }
}

// Widget _buildSection({
//   required String title,
//   String? timestamp,
//   required Widget child,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: AppTheme.textDark,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           if (timestamp != null)
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 12,
//                 vertical: 6,
//               ),
//               decoration: BoxDecoration(
//                 color: AppTheme.lightGray,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.access_time,
//                     size: 14,
//                     color: AppTheme.textDark.withOpacity(0.7),
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     timestamp,
//                     style: TextStyle(
//                       color: AppTheme.textDark.withOpacity(0.7),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//       const SizedBox(height: 16),
//       child,
//     ],
//   );
// }

Widget _buildMiniIndicador(
    String label, String value, Color color, IconData icon) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Icon(
          icon,
          color: color,
          size: 16,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppTheme.textDark.withOpacity(0.7),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}

// Mejora del widget de estado indicador para mantener consistencia
Widget _buildEstadoIndicador(
    String label, bool isOk, IconData icon, Color color, String value) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isOk ? Colors.green : Colors.red).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: (isOk ? Colors.green : Colors.red).withOpacity(0.2)),
        ),
        child: Icon(
          icon,
          color: isOk ? Colors.green : Colors.red,
          size: 16,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppTheme.textDark.withOpacity(0.7),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              value,
              style: TextStyle(
                color: isOk ? Colors.green : Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildBombasListCompacto(int grupoNumero) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            FontAwesomeIcons.objectGroup,
            color: AppTheme.textDark.withOpacity(0.7),
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            'Bombas en este grupo',
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (int i = 1; i <= (grupoNumero == 1 ? 3 : 2); i++)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.accentBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accentBlue.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.water,
                    color: Colors.white,
                    size: 12,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Bomba #${grupoNumero == 1 ? i : i + 3}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

void _mostrarDetallesCapacitores(
    BuildContext context, int grupoNumero, Map<dynamic, dynamic> tcpData) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado del diálogo
              // Encabezado del diálogo mejorado para prevenir desbordamiento
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            FontAwesomeIcons.batteryHalf,
                            color: AppTheme.primaryBlue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Banco de Capacitores',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Grupo $grupoNumero',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.primaryBlue,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(), // Reduce el espacio que ocupa el botón
                    visualDensity: VisualDensity.compact,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Divider(),
              const SizedBox(height: 20),

              // Indicadores principales (sin círculos)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSimpleIndicator(
                    label: 'Factor de Potencia',
                    value: tcpData['FP'] ?? '0.00',
                    icon: FontAwesomeIcons.gaugeHigh,
                  ),
                  _buildSimpleIndicator(
                    label: 'THDI',
                    value:
                        '${tcpData['THDI']?.replaceAll('%', '')?.trim() ?? '0'} %',
                    icon: FontAwesomeIcons.chartLine,
                  ),
                  _buildSimpleIndicator(
                    label: 'THDV',
                    value:
                        '${tcpData['THDV']?.replaceAll('%', '')?.trim() ?? '0'} %',
                    icon: FontAwesomeIcons.chartArea,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Corrientes
              _buildParameterSection(
                title: 'Corrientes',
                icon: FontAwesomeIcons.gaugeSimpleHigh,
                items: [
                  {'label': 'L1', 'value': tcpData['I1'] ?? '0 A'},
                  {'label': 'L2', 'value': tcpData['I2'] ?? '0 A'},
                  {'label': 'L3', 'value': tcpData['I3'] ?? '0 A'},
                ],
              ),

              const SizedBox(height: 16),

              // Voltajes
              _buildParameterSection(
                title: 'Voltajes',
                icon: FontAwesomeIcons.bolt,
                items: [
                  {'label': 'L1-L2', 'value': tcpData['V1'] ?? '0 V'},
                  {'label': 'L2-L3', 'value': tcpData['V2'] ?? '0 V'},
                  {'label': 'L3-L1', 'value': tcpData['V3'] ?? '0 V'},
                ],
              ),

              const SizedBox(height: 16),

              // Energía
              _buildParameterSection(
                title: 'Energía',
                icon: FontAwesomeIcons.lightbulb,
                items: [
                  {'label': 'Potencia', 'value': tcpData['Pot Inst'] ?? '0 Kw'},
                  {
                    'label': 'Energía Activa',
                    'value': tcpData['Energ_Act'] ?? '0 MWh'
                  },
                ],
              ),

              const SizedBox(height: 24),
              Divider(),
              const SizedBox(height: 16),

              // Botón para cerrar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cerrar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Nuevo widget para indicadores simples sin círculos
Widget _buildSimpleIndicator({
  required String label,
  required String value,
  required IconData icon,
}) {
  return Column(
    children: [
      Icon(
        icon,
        color: AppTheme.primaryBlue,
        size: 22,
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.textDark,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.textDark.withOpacity(0.7),
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

// Nuevo widget para secciones de parámetros, estilo limpio sin fondos de color
Widget _buildParameterSection({
  required String title,
  required IconData icon,
  required List<Map<String, String>> items,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryBlue,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      ...items.map((item) => Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['label']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textDark.withOpacity(0.8),
                  ),
                ),
                Text(
                  item['value']!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          )),
      const SizedBox(height: 4),
      Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
    ],
  );
}

void _mostrarDetallesTransformadores(BuildContext context, int grupoNumero) {
  // Aquí podrías obtener los datos reales de tu provider
  Map<String, bool> datosTransformador = {
    'Nivel de Aceite mínimo': true,
    'Nivel de aceite máximo': true,
    'Temperatura aceite 55 °C': false,
    'Disparo Relé BUCHOOLZ': true,
    'Válvula sobrepresión': true,
    'Presión súbita': true,
  };

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado del diálogo (mantener igual)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            FontAwesomeIcons.bolt,
                            color: AppTheme.primaryBlue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transformadores',
                              style: TextStyle(
                                fontSize: 18, // Reducido de 20
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                            Text(
                              'Grupo $grupoNumero',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Divider(),
                const SizedBox(height: 16),

                // Lista de indicadores en lugar de GridView
                ...datosTransformador.entries.map((entry) {
                  String key = entry.key;
                  bool value = entry.value;

                  IconData icon;
                  if (key.contains('Temperatura')) {
                    icon = FontAwesomeIcons.temperatureHalf;
                  } else if (key.contains('Nivel')) {
                    icon = FontAwesomeIcons.oilWell;
                  } else if (key.contains('Relé')) {
                    icon = FontAwesomeIcons.bell;
                  } else if (key.contains('Válvula')) {
                    icon = FontAwesomeIcons.gauge;
                  } else {
                    icon = FontAwesomeIcons.circleExclamation;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildTransformadorItem(key, value, icon),
                  );
                }).toList(),

                const SizedBox(height: 16),
                Divider(),
                const SizedBox(height: 16),

                // Botón para cerrar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cerrar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// Widget optimizado para elementos del transformador
Widget _buildTransformadorItem(String label, bool isOk, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    decoration: BoxDecoration(
      color: (isOk ? Colors.green : Colors.red).withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: (isOk ? Colors.green : Colors.red).withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isOk ? Colors.green : Colors.red).withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isOk ? Colors.green : Colors.red,
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isOk ? 'OK' : 'Alerta',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isOk ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: (isOk ? Colors.green : Colors.red).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            isOk ? Icons.check_circle : Icons.warning,
            color: isOk ? Colors.green : Colors.red,
            size: 16,
          ),
        ),
      ],
    ),
  );
}
