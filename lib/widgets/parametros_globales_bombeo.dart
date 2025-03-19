// Modificación del archivo parametros_globales_bombeo.dart

import 'package:appnaturisa/helpers/theme.dart';
import 'package:appnaturisa/widgets/build_card_decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:appnaturisa/providers/ps_josefina_provider.dart';

class ParametrosGlobalesBombeo extends StatelessWidget {
  final String title;
  final String? timestamp;
  final String succion;
  final String descarga;
  final String setDescarga;

  const ParametrosGlobalesBombeo({
    super.key,
    required this.title,
    this.timestamp,
    required this.succion,
    required this.descarga,
    required this.setDescarga,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (timestamp != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.lightGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppTheme.textDark.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timestamp ?? '',
                      style: TextStyle(
                        color: AppTheme.textDark.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: buildCardDecoration(),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildParametroGlobal(
                      'Sensor Succión',
                      succion,
                      FontAwesomeIcons.arrowDown,
                      Colors.blue.shade700,
                    ),
                  ),
                  Expanded(
                    child: _buildParametroGlobal(
                      'Sensor Descarga',
                      descarga,
                      FontAwesomeIcons.arrowUp,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildParametroGlobal(
                      'Seteo Descarga',
                      setDescarga,
                      FontAwesomeIcons.sliders,
                      Colors.purple,
                    ),
                  ),
                  Expanded(
                    child: _buildBotonComunicaciones(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBotonComunicaciones(BuildContext context) {
    return InkWell(
      onTap: () => _mostrarDialogoComunicaciones(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 11),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                FontAwesomeIcons.satelliteDish,
                color: AppTheme.primaryBlue,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comunicaciones',
                    style: TextStyle(
                      color: AppTheme.textDark.withOpacity(0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'Ver detalles',
                        style: TextStyle(
                          color: AppTheme.primaryBlue,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppTheme.primaryBlue,
                        size: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoComunicaciones(BuildContext context) {
    final antenasData =
        Provider.of<PiscinasJosefinaProvider>(context, listen: false)
            .apiDataListInfoGeneralPis[2][0];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: double.maxFinite,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogHeader(context),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildAllAntenasSection(antenasData),
                ),
              ),
              _buildDialogFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllAntenasSection(Map<dynamic, dynamic> data) {
    // Crear lista con todas las antenas disponibles
    List<Map<String, dynamic>> allAntenas = [
      {
        'name': 'PTP-T1',
        'pot': data['Pot_PTP-T1'],
        'stat': data['Stat_PTP-T1']
      },
      {
        'name': 'PTP-T3',
        'pot': data['Pot_PTP-T3'],
        'stat': data['Stat_PTP-T3']
      },
      {
        'name': 'PTP-Camp-T1',
        'pot': data['Pot_PTP-Camp-T1'],
        'stat': data['Stat_PTP-Camp-T1']
      },
      {
        'name': 'PTP-Camp-T3',
        'pot': data['Pot_PTP-Camp-T3'],
        'stat': data['Stat_PTP-Camp-T3']
      },
      {'name': 'EB_G1', 'pot': data['Pot_EB_G1'], 'stat': data['Stat_EB_G1']},
      {'name': 'AP1', 'pot': data['Pot-AP1'], 'stat': data['Stat_AP1']},
      {'name': 'AP3', 'pot': data['Pot-AP3'], 'stat': data['Stat_AP3']},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allAntenas.length,
      itemBuilder: (context, index) {
        final antena = allAntenas[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _buildAntenaCard(
            nombre: antena['name'],
            potencia: antena['pot'] is int ? antena['pot'] : 0,
            activa: antena['stat'] is bool ? antena['stat'] : false,
          ),
        );
      },
    );
  }

  Widget _buildDialogFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cerrar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              FontAwesomeIcons.satelliteDish,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Comunicaciones',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Estado de antenas y enlaces',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildAntenaCard(
      {required String nombre, required int potencia, required bool activa}) {
    final Color statusColor = activa ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: activa
                ? Colors.green.withOpacity(0.15)
                : Colors.red.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nombre e icono en la parte superior
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  activa ? FontAwesomeIcons.wifi : FontAwesomeIcons.ban,
                  color: statusColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  nombre,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                  // Se eliminó maxLines y overflow para mostrar el nombre completo
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Potencia y estado en la parte inferior
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Potencia
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.signalPerfect,
                      color: AppTheme.textDark.withOpacity(0.6),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$potencia',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textDark.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Estado
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: activa
                      ? Colors.green.withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      activa ? 'Online' : 'Offline',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParametroGlobal(
      String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 12),
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
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: AppTheme.textDark,
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
}
