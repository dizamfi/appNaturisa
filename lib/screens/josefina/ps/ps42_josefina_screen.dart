import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/screens/josefina/ps/help_piscina_josefina_screen.dart';
import 'package:appnaturisa/utils/data_access_utils.dart'; // Importación añadida
import 'package:appnaturisa/widgets/card_tablero_aire.dart';
import 'package:appnaturisa/widgets/control_remoto.dart';
import 'package:appnaturisa/widgets/headers.dart';
import 'package:appnaturisa/widgets/info_general_ps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/slideshow.dart';

class PS42JosefinaScreen extends StatefulWidget {
  const PS42JosefinaScreen({super.key});

  @override
  State<PS42JosefinaScreen> createState() => _PS42JosefinaScreenState();
}

class _PS42JosefinaScreenState extends State<PS42JosefinaScreen>
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
        if (PiscinasJosefinaProvider.channel != null) {
          Provider.of<PiscinasJosefinaProvider>(context, listen: false)
              .subscribePS42();
          debugPrint('[PS42] Suscripción inicial realizada');
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
    Provider.of<PiscinasJosefinaProvider>(context, listen: false)
        .reconnectIfNeeded();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      if (PiscinasJosefinaProvider.channel != null) {
        PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPS42');
        debugPrint('[PS42] Cancelando suscripción (app en segundo plano)');
      }
    } else if (state == AppLifecycleState.resumed) {
      if (PiscinasJosefinaProvider.channel != null) {
        Provider.of<PiscinasJosefinaProvider>(context, listen: false)
            .subscribePS42();
        debugPrint('[PS42] Resuscripción al volver a primer plano');
      }
    }
  }

  @override
  void dispose() {
    firstLoad = true;
    WidgetsBinding.instance.removeObserver(this);
    if (PiscinasJosefinaProvider.channel != null) {
      PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPS42');
      debugPrint('[PS42] Cancelando suscripción (dispose)');
    }
    PiscinasJosefinaProvider.subscriptionPS42?.cancel();
    PiscinasJosefinaProvider.subscriptionPS42 = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final provider =
                Provider.of<PiscinasJosefinaProvider>(context, listen: false);
            provider.reconnectIfNeeded();
          });
          Navigator.canPop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 80,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  height: size.height * 0.1,
                  width: size.width * 0.083,
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Piscina 42',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const HelpPiscinaJosefinaScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 1.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  height: size.height * 0.1,
                  width: size.width * 0.083,
                  child: const Icon(
                    Icons.help_outline_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            // PinkBox siempre visible
            const Positioned(top: -110, left: 0, child: PinkBox()),

            // Contenido que depende de los datos
            SafeArea(
              child: Consumer<PiscinasJosefinaProvider>(
                builder: (context, ebProvider, child) {
                  apiDataList = ebProvider.apiDataListPS42;

                  // Verificar si el proveedor tiene error
                  if (ebProvider.hasError) {
                    return Center(
                      child: ErrorScreen(
                        message:
                            'Error de conexión: ${ebProvider.errorMessage}',
                        onRetry: () => ebProvider.subscribePS42(),
                      ),
                    );
                  }

                  // Verificar si está cargando
                  if (PiscinasJosefinaProvider.isLoading2) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 4, 63, 122),
                      ),
                    );
                  }

                  // Verificar que los datos estén completos
                  bool datosCompletos = apiDataList.length >= 3 &&
                      (apiDataList[0]?.isNotEmpty ?? false) &&
                      (apiDataList[1]?.isNotEmpty ?? false) &&
                      (apiDataList[2]?.isNotEmpty ?? false);

                  if (!datosCompletos) {
                    return Center(
                      child: ErrorScreen(
                        message: 'Datos incompletos o en sincronización',
                        onRetry: () {
                          debugPrint('[PS42] Reintentando suscripción...');
                          ebProvider.subscribePS42();
                        },
                      ),
                    );
                  }

                  // Si los datos están completos, mostramos todo el contenido
                  return Column(
                    children: [
                      // Texto "Tableros" (solo visible cuando los datos están cargados)
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Tableros',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Contenido principal
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 2, top: 0, bottom: 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.99,
                                    minHeight: 100,
                                  ),
                                  height: 274,
                                  child: SlideShow(
                                    bulletPrimario: 10,
                                    bulletSecundario: 8,
                                    colorPrimario:
                                        const Color.fromARGB(255, 4, 63, 122),
                                    slides: [
                                      CardTableroAire(
                                        tablero: 'TA42-1',
                                        numCircuito: 4,
                                        sizeCirc: 18,
                                        numAirOn:
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [0, 0, "Num_Air_On"],
                                                0),
                                        statComm:
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [1, 0, "TA_42_01.Stat_Comm"],
                                                false),
                                        imputsLN:
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [1, 0, "TA_42_01.Inputs"],
                                                0),
                                      ),
                                      CardTableroAire(
                                        tablero: 'TA42-2',
                                        numCircuito: 5,
                                        sizeCirc: 18,
                                        numAirOn:
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [0, 0, "Num_Air_On"],
                                                0),
                                        statComm:
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [1, 1, "TA_42_02.Stat_Comm"],
                                                false),
                                        imputsLN:
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [1, 1, "TA_42_02.Inputs"],
                                                0),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'General Piscina',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.98,
                                    minHeight: 100,
                                  ),
                                  height: 240,
                                  child: SlideShow(
                                    bulletPrimario: 10,
                                    bulletSecundario: 8,
                                    colorPrimario:
                                        const Color.fromARGB(255, 4, 63, 122),
                                    slides: [
                                      ControlRemoto(
                                        apiDataList: apiDataList,
                                      ),
                                      InfoGeneralPS(
                                        apiDataList: apiDataList,
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  'Comunicaciones',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    minHeight: 100,
                                  ),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(1),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(9, 31, 72, 1),
                                        blurRadius: 3,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'TA42-1',
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(9, 31, 72, 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'TA42-2',
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(9, 31, 72, 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _buildStatusIcon(
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [2, 0, 'Stat_TA42-1'],
                                                false),
                                          ),
                                          _buildStatusIcon(
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [2, 0, 'Stat_TA42-2'],
                                                false),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _buildSignalIcon(
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [2, 0, 'Pot_TA42-1'],
                                                -100),
                                          ),
                                          _buildSignalIcon(
                                            DataAccessUtils.getNestedValue(
                                                apiDataList,
                                                [2, 0, 'Pot_TA42-2'],
                                                -100),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            DataAccessUtils.getNestedValue(
                                                    apiDataList,
                                                    [2, 0, 'Pot_TA42-1'],
                                                    0)
                                                .toString(),
                                          ),
                                          Text(
                                            DataAccessUtils.getNestedValue(
                                                    apiDataList,
                                                    [2, 0, 'Pot_TA42-2'],
                                                    0)
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      Image.asset('assets/antenaIcono.png',
                                          width: 70, height: 70),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para el icono de estado
  Widget _buildStatusIcon(bool isActive) {
    return isActive
        ? const Icon(Icons.check_circle, color: Colors.green)
        : const Icon(Icons.close_rounded, color: Colors.red);
  }

  // Método auxiliar para el icono de señal
  Widget _buildSignalIcon(int potencia) {
    if (potencia >= -67) {
      return const Icon(Icons.network_wifi, color: Colors.green);
    } else if (potencia <= -68 && potencia >= -79) {
      return const Icon(Icons.network_wifi, color: Colors.orangeAccent);
    } else if (potencia <= -80) {
      return const Icon(Icons.network_wifi, color: Colors.red);
    } else {
      return const Text('');
    }
  }
}

// Clase ErrorScreen para mostrar mensajes de error
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning_amber_rounded, size: 50, color: Colors.amber),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 4, 63, 122),
              foregroundColor: Colors.white,
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ],
    );
  }
}
