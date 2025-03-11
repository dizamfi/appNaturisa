import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/screens/josefina/ps/help_piscina_josefina_screen.dart';
import 'package:appnaturisa/widgets/card_tablero_aire.dart';
import 'package:appnaturisa/widgets/control_remoto.dart';
import 'package:appnaturisa/widgets/headers.dart';
import 'package:appnaturisa/widgets/info_general_ps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/slideshow.dart';

class PC101JosefinaScreen extends StatefulWidget {
  const PC101JosefinaScreen({super.key});

  @override
  State<PC101JosefinaScreen> createState() => _PC101JosefinaScreenState();
}

class _PC101JosefinaScreenState extends State<PC101JosefinaScreen>
    with WidgetsBindingObserver {
  // List<dynamic> apiDataList = [];
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
          Provider.of<PiscinasJosefinaProvider>(context, listen: false)
              .subscribePC101();
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
      PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPC101');
    } else if (state == AppLifecycleState.resumed) {
      // La app volvió al primer plano
      if (PiscinasJosefinaProvider.channel != null) {
        Provider.of<PiscinasJosefinaProvider>(context, listen: false)
            .subscribePC101();
      }
    }
  }

  @override
  void dispose() {
    firstLoad = true;
    WidgetsBinding.instance.removeObserver(this);
    PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSPC101');
    PiscinasJosefinaProvider.subscriptionPC101?.cancel();
    PiscinasJosefinaProvider.subscriptionPC101 = null;
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
            if (PiscinasJosefinaProvider.channel != null) {
              // provider.subscribePiscinasInfoGeneralGraca();
            }
            Navigator.canPop(context);
          });
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
                  'Precria 101',
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
        body: Consumer<PiscinasJosefinaProvider>(
            builder: (context, ebProvider, child) {
          final apiDataList = ebProvider.apiDataListPC101;

          if (PiscinasJosefinaProvider.isLoading2 && firstLoad) {
            // return const Center(
            //   child: CircularProgressIndicator(
            //     color: Color.fromARGB(255, 4, 63, 122),
            //   ),
            // );
          } else if (ebProvider.hasError) {
            return Center(child: Text('Error: ${ebProvider.errorMessage}'));
          } else if (ebProvider.apiDataListPC101.isEmpty) {
            // return const CircularProgressIndicator(
            //   color: Color.fromARGB(255, 4, 63, 122),
            // );
          }

          return Stack(
            children: [
              const Positioned(top: -100, left: -30, child: PinkBox()),
              PiscinasJosefinaProvider.isLoading2
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 4, 63, 122),
                      ),
                    )
                  : SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 0, bottom: 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Tableros',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.99,
                                    minHeight: 100),
                                height: 274,
                                child: SlideShow(
                                    bulletPrimario: 10,
                                    bulletSecundario: 8,
                                    colorPrimario:
                                        const Color.fromARGB(255, 4, 63, 122),
                                    slides: [
                                      CardTableroAire(
                                        tablero: 'TA101-1',
                                        numCircuito: 2,
                                        sizeCirc: 22,
                                        numAirOn: apiDataList.isNotEmpty &&
                                                apiDataList[0].isNotEmpty
                                            ? apiDataList[0][0]["Num_Air_On"]
                                            : 0,
                                        statComm: apiDataList.isNotEmpty &&
                                                apiDataList[1].isNotEmpty
                                            ? apiDataList[1][0]
                                                ["TA_101_01.Stat_Comm"]
                                            : false,
                                        imputsLN: apiDataList.isNotEmpty &&
                                                apiDataList[1].isNotEmpty
                                            ? apiDataList[1][0]
                                                ["TA_101_01.Inputs"]
                                            : 0,
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'General Piscina',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.98,
                                    minHeight: 100),
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
                                    ]),
                              ),
                              const Text(
                                'Comunicaciones',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    minHeight: 100),
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(9, 31, 72, 1),
                                        blurRadius: 3,
                                      )
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'TA101-1',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(9, 31, 72, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        apiDataList.isNotEmpty &&
                                                apiDataList[2].isNotEmpty
                                            ? apiDataList[2][0]['Stat_TA101-1']
                                                ? const Icon(Icons.check_circle,
                                                    color: Colors.green)
                                                : const Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.red)
                                            : const Text(''),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        apiDataList.isNotEmpty &&
                                                apiDataList[2].isNotEmpty
                                            ? apiDataList[2][0]
                                                        ['Pot_TA101-1'] >=
                                                    -67
                                                ? const Icon(Icons.network_wifi,
                                                    color: Colors.green)
                                                : (apiDataList[2][0][
                                                                'Pot_TA101-1'] <=
                                                            -68 &&
                                                        apiDataList[2][0][
                                                                'Pot_TA101-1'] >=
                                                            -79)
                                                    ? const Icon(
                                                        Icons.network_wifi,
                                                        color:
                                                            Colors.orangeAccent)
                                                    : apiDataList[2][0][
                                                                'Pot_TA101-1'] <=
                                                            -80
                                                        ? const Icon(
                                                            Icons.network_wifi,
                                                            color: Colors.red)
                                                        : const Text('')
                                            : const Text(''),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        apiDataList.isNotEmpty &&
                                                apiDataList[2].isNotEmpty
                                            ? Text(apiDataList[2][0]
                                                    ['Pot_TA101-1']
                                                .toString())
                                            : const Text(''),
                                      ],
                                    ),
                                    Image.asset('assets/antenaIcono.png',
                                        width: 70, height: 70)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
