import 'package:appnaturisa/helpers/theme.dart';
import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/widgets/bomba_card.dart';
import 'package:appnaturisa/widgets/build_header_bombeo.dart';
import 'package:appnaturisa/widgets/parametros_generales_bombeo.dart';
import 'package:appnaturisa/widgets/parametros_globales_bombeo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BombeoJosefinaScreen extends StatefulWidget {
  const BombeoJosefinaScreen({super.key});

  @override
  State<BombeoJosefinaScreen> createState() => _BombeoJosefinaScreenState();
}

class _BombeoJosefinaScreenState extends State<BombeoJosefinaScreen>
    with WidgetsBindingObserver {
  List<dynamic> apiDataList = [];
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .reconnectIfNeeded();
      if (firstLoad) {
        // Espera a que el canal WebSocket esté inicializado
        if (PiscinasJosefinaProvider.channel != null) {
          // EbProvider.channel!.sink.add('subscribe1B');
          Provider.of<PiscinasJosefinaProvider>(context, listen: false)
              .subscribeEBFJOS();
          // print('Suscripción a SD realizada.');
        }

        setState(() {
          firstLoad = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Intentar reconectar si es necesario cuando los dependientes cambian
    Provider.of<PiscinasJosefinaProvider>(context, listen: false)
        .reconnectIfNeeded();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // La app está en segundo plano
      PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSEB');
    } else if (state == AppLifecycleState.resumed) {
      // La app volvió al primer plano
      if (PiscinasJosefinaProvider.channel != null) {
        // EbProvider.channel!.sink.add('subscribe1B');
        Provider.of<PiscinasJosefinaProvider>(context, listen: false)
            .subscribeEBFJOS();
        // print('Suscripción a SD realizada.');
      }
    }
  }

  @override
  void dispose() {
    firstLoad = true;
    WidgetsBinding.instance.removeObserver(this);
    PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSEB');
    PiscinasJosefinaProvider.subscriptionEBFJOS?.cancel();
    PiscinasJosefinaProvider.subscriptionEBFJOS = null;
    super.dispose();
  }

  // Implementar esta función de ayuda en el inicio de tu clase _BombeoJosefinaScreenState
  T? getNestedValue<T>(List<dynamic> data, List<dynamic> path, T defaultValue) {
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
      print('Error accediendo a datos: $e');
      return defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bombeo Josefina',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppTheme.primaryBlue,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: Consumer<PiscinasJosefinaProvider>(
            builder: (context, ebProvider, child) {
          apiDataList = ebProvider.apiDataListEBFJOS;

          if (ebProvider.hasError) {
            // Mostrar mensaje de error
            return Center(child: Text('Error: ${ebProvider.errorMessage}'));
          }

          // Verificar si está cargando
          if (PiscinasJosefinaProvider.isLoading2) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 4, 63, 122),
              ),
            );
          }

          // if (!PiscinasJosefinaProvider.isLoading2 || apiDataList.isEmpty) {
          //   // Mostrar indicador de carga
          //   return const Center(
          //     child: CircularProgressIndicator(
          //       valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
          //     ),
          //   );
          // }

          // Verificar que todos los datos necesarios estén disponibles
          bool datosCompletos = apiDataList.length >= 3 &&
              (apiDataList[0]?.isNotEmpty ?? false) &&
              (apiDataList[1]?.isNotEmpty ?? false) &&
              (apiDataList[2]?.isNotEmpty ?? false);

          if (!datosCompletos) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 50, color: Colors.amber),
                  SizedBox(height: 16),
                  Text(
                    'Datos incompletos o en sincronización',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textDark,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<PiscinasJosefinaProvider>(context,
                              listen: false)
                          .subscribeEBFJOS();
                    },
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildHeaderBombeo(
                  numBombas: '5',
                  numGrupos: '2',
                  estacion: 'Josefina',
                  estado:
                      getNestedValue(apiDataList, [0, 7, 'estado'], false) ??
                          false,
                  bombasEncendidas:
                      getNestedValue(apiDataList, [0, 6, 'on'], 0) ?? 0,
                ),
                const SizedBox(height: 20),
                ParametrosGlobalesBombeo(
                  title: 'Parámetros Globales',
                  descarga: getNestedValue<String>(
                          apiDataList, [1, 0, 'descarga'], '') ??
                      '',
                  succion: getNestedValue<String>(
                          apiDataList, [1, 0, 'succion'], '') ??
                      '',
                  setDescarga:
                      getNestedValue(apiDataList, [1, 0, 'set_descarga'], '') ??
                          '',
                ),
                const SizedBox(height: 24),
                _buildBombasSection(size),
                const SizedBox(height: 24),
                _buildParametrosPorGrupoSection(size),
              ],
            ),
          );
        }));
  }

  Widget _buildSection({
    required String title,
    String? timestamp,
    required Widget child,
  }) {
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
                      timestamp,
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
        child,
      ],
    );
  }

  Widget _buildParametrosPorGrupoSection(Size size) {
    return _buildSection(
      title: 'Parámetros por Grupo',
      child: Column(
        children: [
          ParametrosGeneralesBombeo(
            grupoNumero: 1,
            isActive:
                getNestedValue(apiDataList, [0, 10, 'grupo1_estado'], false) ??
                    false,
            numeroBombas: 2,
            numeroBombasActivas:
                getNestedValue(apiDataList, [0, 8, 'grupo1_activas'], 0) ?? 0,
            tcpData: getNestedValue<Map<dynamic, dynamic>>(
                    apiDataList, [2, 0], {}) ??
                {},
          ),
          const SizedBox(height: 16),
          ParametrosGeneralesBombeo(
            grupoNumero: 2,
            isActive:
                getNestedValue(apiDataList, [0, 11, 'grupo2_estado'], false) ??
                    false,
            numeroBombas: 3,
            numeroBombasActivas:
                getNestedValue<int>(apiDataList, [0, 9, 'grupo2_activas'], 0) ??
                    0,
            tcpData: getNestedValue<Map<dynamic, dynamic>>(
                    apiDataList, [2, 1], {}) ??
                {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBombasSection(Size size) {
    return _buildSection(
      title: 'Información de Bombas',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BombaCard(
              bombaNumero: 1,
              isActive:
                  getNestedValue(apiDataList, [0, 5, 'st1'], false) ?? false,
              datosBomba: getNestedValue<Map<dynamic, dynamic>>(apiDataList, [
                    0,
                    0
                  ], {
                    'I L1': '-- A',
                    'Volt L1-L2': '-- V',
                    'I L2': '-- A',
                    'Volt L2-L3': '-- V',
                    'I L3': '-- A',
                    'Volt L3-L1': '-- V',
                    'Pot Inst': '-- Kw',
                    'FP': '-- ',
                    'Energ_Act': '-- MWh',
                    'Horómetro': '-- H',
                    'Hrs_Dia': '-- H/D',
                    'Hrs_Dia_Ant': '-- H/D',
                  }) ??
                  {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BombaCard(
              bombaNumero: 2,
              isActive:
                  getNestedValue(apiDataList, [0, 5, 'st2'], false) ?? false,
              datosBomba: getNestedValue<Map<dynamic, dynamic>>(apiDataList, [
                    0,
                    1
                  ], {
                    'I L1': '-- A',
                    'Volt L1-L2': '-- V',
                    'I L2': '-- A',
                    'Volt L2-L3': '-- V',
                    'I L3': '-- A',
                    'Volt L3-L1': '-- V',
                    'Pot Inst': '-- Kw',
                    'FP': '-- ',
                    'Energ_Act': '-- MWh',
                    'Horómetro': '-- H',
                    'Hrs_Dia': '-- H/D',
                    'Hrs_Dia_Ant': '-- H/D',
                  }) ??
                  {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BombaCard(
              bombaNumero: 3,
              isActive:
                  apiDataList.isNotEmpty ? apiDataList[0][5]['st3'] : false,
              datosBomba: apiDataList.isNotEmpty
                  ? apiDataList[0][2]
                  : {
                      'I L1': '40 A',
                      'Volt L1-L2': '220 V',
                      'I L2': '38 A',
                      'Volt L2-L3': '223 V',
                      'I L3': '41 A',
                      'Volt L3-L1': '221 V',
                      'Pot Inst': '20 Kw',
                      'FP': '0.85 ',
                      'Energ_Act': '75.4 MWh',
                      'Horómetro': '1250 H',
                      'Hrs_Dia': '7.5 H/D',
                      'Hrs_Dia_Ant': '7.2 H/D',
                    },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BombaCard(
              bombaNumero: 4,
              isActive:
                  apiDataList.isNotEmpty ? apiDataList[0][5]['st4'] : false,
              datosBomba: apiDataList.isNotEmpty
                  ? apiDataList[0][3]
                  : {
                      'I L1': '40 A',
                      'Volt L1-L2': '220 V',
                      'I L2': '38 A',
                      'Volt L2-L3': '223 V',
                      'I L3': '41 A',
                      'Volt L3-L1': '221 V',
                      'Pot Inst': '20 Kw',
                      'FP': '0.85 ',
                      'Energ_Act': '75.4 MWh',
                      'Horómetro': '1250 H',
                      'Hrs_Dia': '7.5 H/D',
                      'Hrs_Dia_Ant': '7.2 H/D',
                    },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BombaCard(
              bombaNumero: 5,
              isActive:
                  apiDataList.isNotEmpty ? apiDataList[0][5]['st5'] : false,
              datosBomba: apiDataList.isNotEmpty
                  ? apiDataList[0][4]
                  : {
                      'I L1': '40 A',
                      'Volt L1-L2': '220 V',
                      'I L2': '38 A',
                      'Volt L2-L3': '223 V',
                      'I L3': '41 A',
                      'Volt L3-L1': '221 V',
                      'Pot Inst': '20 Kw',
                      'FP': '0.85 ',
                      'Energ_Act': '75.4 MWh',
                      'Horómetro': '1250 H',
                      'Hrs_Dia': '7.5 H/D',
                      'Hrs_Dia_Ant': '7.2 H/D',
                    },
            ),
          ),
        ],
      ),
    );
  }
}

// Clases auxiliares para una mejor organización
class ParamItem {
  final String label;
  final String value;

  ParamItem(this.label, this.value);
}

class ParameterRow {
  final String label;
  final String value;

  ParameterRow(this.label, this.value);
}
