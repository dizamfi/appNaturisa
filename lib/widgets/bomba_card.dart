import 'package:appnaturisa/helpers/theme.dart';
import 'package:appnaturisa/screens/josefina/bombeo/bombeo_josefina_screen.dart';
import 'package:appnaturisa/widgets/build_card_decoration.dart';
import 'package:flutter/material.dart';

class BombaCard extends StatelessWidget {
  final Map<dynamic, dynamic> datosBomba;
  final int bombaNumero;
  final bool isActive;
  const BombaCard(
      {super.key,
      required this.datosBomba,
      required this.bombaNumero,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBombaTitleRow(context, bombaNumero, isActive, datosBomba),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // Primera fila - Corrientes (3 columnas)
          _buildParamRow3(
            isActive: isActive,
            params: [
              ParamItem('Corriente L1', datosBomba['I L1']!),
              ParamItem('Corriente L2', datosBomba['I L2']!),
              ParamItem('Corriente L3', datosBomba['I L3']!),
            ],
          ),
          const SizedBox(height: 12),

          // Segunda fila - Voltajes (3 columnas)
          _buildParamRow3(
            isActive: isActive,
            params: [
              ParamItem('Voltaje L1-L2', datosBomba['Volt L1-L2']!),
              ParamItem('Voltaje L2-L3', datosBomba['Volt L2-L3']!),
              ParamItem('Voltaje L3-L1', datosBomba['Volt L3-L1']!),
            ],
          ),
          const SizedBox(height: 12),

          // Tercera fila - Potencia, FP, Energía (3 columnas)
          _buildParamRow3(
            isActive: isActive,
            params: [
              ParamItem('Potencia', datosBomba['Pot Inst']!),
              ParamItem('Factor Pot.', datosBomba['FP']!),
              ParamItem('Energía', datosBomba['Energ_Act']!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParamRow3({
    required bool isActive,
    required List<ParamItem> params,
  }) {
    return Row(
      children: params.map((param) {
        return Expanded(
          child: _buildParametroBomba(
            param.label,
            param.value,
            isActive,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBombaTitleRow(BuildContext context, int bombaNumero,
      bool isActive, Map<dynamic, dynamic> datosBomba) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.blue.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.water_drop,
            color: isActive ? Colors.blue : Colors.grey,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bomba #$bombaNumero',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  isActive ? 'Activa' : 'Inactiva',
                  style: TextStyle(
                    color: isActive ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () =>
              _mostrarDetallesBomba(context, bombaNumero, datosBomba),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('Detalles'),
        ),
      ],
    );
  }

  Widget _buildParametroBomba(String label, String value, bool isActive) {
    return Column(
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
            color: isActive ? AppTheme.textDark : Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildParameterSection({
    required String title,
    required List<ParameterRow> parameters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryBlue,
          ),
        ),
        const SizedBox(height: 10),
        ...parameters
            .map((param) => _buildParameterRow(param.label, param.value)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildParameterRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textDark.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDetallesBomba(
      BuildContext context, int bombaNumero, Map<dynamic, dynamic> datosBomba) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogHeader(context, 'Bomba $bombaNumero'),
                const Divider(height: 30),
                _buildParameterSection(
                  title: 'Parámetros de Corriente',
                  parameters: [
                    ParameterRow('Corriente L1:', datosBomba['I L1']!),
                    ParameterRow('Corriente L2:', datosBomba['I L2']!),
                    ParameterRow('Corriente L3:', datosBomba['I L3']!),
                  ],
                ),
                _buildParameterSection(
                  title: 'Parámetros de Voltaje',
                  parameters: [
                    ParameterRow('Voltaje L1-L2:', datosBomba['Volt L1-L2']!),
                    ParameterRow('Voltaje L2-L3:', datosBomba['Volt L2-L3']!),
                    ParameterRow('Voltaje L3-L1:', datosBomba['Volt L3-L1']!),
                  ],
                ),
                _buildParameterSection(
                  title: 'Parámetros de Potencia',
                  parameters: [
                    ParameterRow(
                        'Potencia Instantánea:', datosBomba['Pot Inst']!),
                    ParameterRow('Factor de Potencia:', datosBomba['FP']!),
                    ParameterRow('Energía Activa:', datosBomba['Energ_Act']!),
                  ],
                ),
                _buildParameterSection(
                  title: 'Parámetros de Operación',
                  parameters: [
                    ParameterRow('Horómetro:', datosBomba['Horómetro']!),
                    ParameterRow('Horas por Día:', datosBomba['Hrs_Dia']!),
                    ParameterRow('Horas por Día (anterior):',
                        datosBomba['Hrs_Dia_Ant']!),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cerrar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogHeader(BuildContext context, String title) {
    return Row(
      children: [
        Icon(
          Icons.water_drop,
          color: AppTheme.primaryBlue,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          'Detalles $title',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
