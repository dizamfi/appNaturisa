import 'dart:io';

import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/screens/josefina/antenas_info_state.dart';
import 'package:appnaturisa/screens/josefina/info_ps_on_off_screen.dart';
import 'package:appnaturisa/screens/josefina/selec_horario_screen.dart';
import 'package:appnaturisa/services/storage_service.dart';
// import 'package:appnaturisa/widgets/curved_gif_carousel.dart';
import 'package:appnaturisa/widgets/headers.dart';
import 'package:appnaturisa/widgets/internet_check.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<dynamic> apiDataList = [];
  bool firstLoad = true;
  int _currentIndex = 0;

  final List<String> imgList = [
    'assets/imageAntena.png',
    'assets/iii.png',
    'assets/image3.jpg',
  ];

  Future<void> _refreshData() async {
    // Simula la recarga de datos
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .reconnectIfNeeded();

      if (!Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .hasError) {
        if (firstLoad) {
          if (PiscinasJosefinaProvider.channel != null) {
            Provider.of<PiscinasJosefinaProvider>(context, listen: false)
                .subscribePiscinasAntenasAndInfoGeneral();
          }
          setState(() {
            firstLoad = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    firstLoad = true;

    WidgetsBinding.instance.removeObserver(this);
    PiscinasJosefinaProvider.channel!.sink.add('unsubscribeAntenas');
    PiscinasJosefinaProvider.subscriptionAntenas?.cancel();
    PiscinasJosefinaProvider.subscriptionAntenas = null;
    PiscinasJosefinaProvider.channel!.sink.add('unsubscribeInfoGeneralPS');
    PiscinasJosefinaProvider.subscriptionInfoGeneralPis?.cancel();
    PiscinasJosefinaProvider.subscriptionInfoGeneralPis = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
          ),
          const HeaderWave(),
          Positioned(
            top: size.height * 0.08,
            left: size.width * 0.5,
            child: Transform.rotate(
              angle: -20 * 3.14159265359 / 90,
              child: Image.asset(
                'assets/plano_josefina.png',
                width: size.width * 0.58,
                height: size.height * 0.30,
                color: const Color.fromRGBO(255, 255, 255, 0.1),
              ),
            ),
          ),
          // Positioned(
          //   top: 180,
          //   left: size.width * 0.5 - 140, // Centra el widget horizontalmente
          //   child: _buildStorageCard2(),
          // ),
          Positioned(
            top: size.height * 0.591,
            left: size.width * 0.07,
            right: 0,
            child: Text(
              'Acceso rápido',
              style: GoogleFonts.anton(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          InternetChecker(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: Positioned(
                top: size.height * 0.658,
                left: 0,
                right: 0,
                child: Consumer<PiscinasJosefinaProvider>(
                  builder: (context, antenaProvider, child) {
                    apiDataList = antenaProvider.apiDataListInfoGeneralPis;
                    // print(apiDataList[3][0]);

                    if (PiscinasJosefinaProvider.isLoading2) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: size.width * 0.07,
                            ),
                            ShimmerContainer(title: 'Piscinas'),
                            SizedBox(
                              width: size.width * 0.045,
                            ),
                            ShimmerContainer(title: 'Antenas'),
                            SizedBox(
                              width: size.width * 0.045,
                            ),
                            ShimmerContainer(title: 'Antenas'),
                            SizedBox(
                              width: size.width * 0.07,
                            ),
                          ],
                        ),
                      );
                    } else if (antenaProvider.hasError) {
                      return Center(
                        child: Icon(
                          Icons.wifi_off_outlined,
                          size: 80,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const InfoPSOnOffScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.waves,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Piscinas',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      apiDataList.isNotEmpty
                                          ? '${apiDataList[1][0]["PiscinasOn"]} encendidas'
                                          : '----',
                                      style: TextStyle(
                                        color: Color.fromRGBO(23, 223, 106, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.045,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const AntenasInfoStateScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.rss_feed,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Antenas',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      apiDataList.isNotEmpty
                                          ? '${apiDataList[3][0]["AntenasOff"]} sin señal'
                                          : '----',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.045,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const SelecHorarioScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_alarm,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Horario',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'Global',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.066,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Josefina",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showAvatarDialog(context),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              const Color.fromRGBO(201, 202, 203, 0.9),
                          backgroundImage:
                              StorageService.prefs.getString('profileImage') !=
                                      null
                                  ? FileImage(File(StorageService.prefs
                                      .getString('profileImage')!))
                                  : null,
                          child:
                              StorageService.prefs.getString('profileImage') ==
                                      null
                                  ? Text(
                                      "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                                      style: GoogleFonts.roboto(fontSize: 12),
                                    )
                                  : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAvatarDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: const Color.fromRGBO(201, 202, 203, 0.9),
                backgroundImage: StorageService.prefs
                            .getString('profileImage') !=
                        null
                    ? FileImage(
                        File(StorageService.prefs.getString('profileImage')!))
                    : null,
                child: StorageService.prefs.getString('profileImage') == null
                    ? Text(
                        "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                        style: const TextStyle(fontSize: 40),
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStorageCard2() {
    return Container(
      height: 240,
      width: 280,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: PageView.builder(
                itemCount: imgList.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.asset(
                        imgList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Center(
                        child: Text(
                          'Información sobre la imagen',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: (_currentIndex + 1) / imgList.length,
            backgroundColor: Colors.black,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final String title;

  const ShimmerContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
