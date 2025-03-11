// import 'dart:convert';
// import 'package:animate_do/animate_do.dart';
// import 'package:appsantapriscila/providers/ps_california_provider.dart';
// import 'package:appsantapriscila/screens/california/aireacion/help_aireacion_california_screen.dart';
// import 'package:appsantapriscila/screens/construction_screen.dart';
// import 'package:appsantapriscila/services/storage_service.dart';
// import 'package:appgraca/providers/ps_graca_provider.dart';
// import 'package:appgraca/screens/help_aireacion_graca_screen.dart';
// import 'package:appgraca/screens/mapa_aireacion_graca_screen.dart';
// import 'package:appgraca/widgets/boton_gordo_aireacion.dart';
// import 'package:flutter/cupertino.dart';
import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/screens/josefina/help_aireacion_josefina_screen.dart';
import 'package:appnaturisa/screens/josefina/mapa_aireacion_josefina_screen.dart';
import 'package:appnaturisa/widgets/boton_gordo_aireacion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:provider/provider.dart';
// import '../widgets/boton_gordo_aireacion.dart';

class ItemBotonAireacion {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final bool estado;
  final int alarma;
  final String id;
  final int numCirc;
  final int numCircOn;
  final int ta;
  final int tcp;

  ItemBotonAireacion(
    this.icon,
    this.texto,
    this.color1,
    this.color2,
    this.estado,
    this.alarma,
    this.numCirc,
    this.numCircOn,
    this.ta,
    this.tcp,
    this.id,
  );
}

class AireacionJosefinaScreen extends StatefulWidget {
  const AireacionJosefinaScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AireacionJosefinaScreenState createState() =>
      _AireacionJosefinaScreenState();
}

class _AireacionJosefinaScreenState extends State<AireacionJosefinaScreen>
    with WidgetsBindingObserver {
  static List<dynamic> apiDataList = [];
  void cancel() {
    if (PiscinasJosefinaProvider.channel != null) {
      PiscinasJosefinaProvider.channel!.sink.add('unsubscribeInfoGeneralPS');
    }
    PiscinasJosefinaProvider.subscriptionInfoGeneralPis?.cancel();
    PiscinasJosefinaProvider.subscriptionInfoGeneralPis = null;
  }

  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    // loadApiDataList();
    // StorageService.saveFlag(false, 'FlagAireCali');
    // saveFlag(false);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<PiscinasJosefinaProvider>(context, listen: false);

      if (!Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .hasError) {
        if (firstLoad) {
          // Espera a que el canal WebSocket esté inicializado
          if (PiscinasJosefinaProvider.channel != null) {
            // EbProvider.channel!.sink.add('subscribe1B');
            Provider.of<PiscinasJosefinaProvider>(context, listen: false)
                .subscribePiscinasInfoGeneralJosefina();
            // print('Suscripción a SD realizada.');
          }
          // provider.addListener(() {
          //   if (mounted) {
          //     setState(() {
          //       firstLoad = false;
          //     });
          //   }
          // });

          provider.addListener(() {
            if (mounted) {
              setState(() {
                firstLoad = false;
              });
            }
          });
        }
      }
    });
  }

  //  // Nueva función para guardar apiDataList
  // Future<void> saveApiDataList(List<dynamic> apiDataList) async {
  //   String dataEB = jsonEncode(apiDataList);
  //   await StorageService.prefs.setString('StatusBombas', dataEB);
  // }

  // // Nueva función para cargar apiDataList
  // void loadApiDataList() {
  //   String? dataEB = StorageService.prefs.getString('StatusBombas');
  //   if (dataEB != null) {
  //     apiDataList = jsonDecode(dataEB);
  //     // setState(() {});
  //     print('Aquii222222');
  //     // print(apiDataList);
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //  routeObserver.subscribe(this, ModalRoute.of(context)!);
    // Intentar reconectar si es necesario cuando los dependientes cambian

    Provider.of<PiscinasJosefinaProvider>(context, listen: false)
        .reconnectIfNeeded();

    // setState(() {
    //   // Aquí puedes reiniciar el filtro o actualizar los datos
    // });
  }

  @override
  void dispose() {
    firstLoad = true;
    // saveApiDataList(apiDataList);
    WidgetsBinding.instance.removeObserver(this);
    cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // La app está en segundo plano
      // PiscinasCaliforniaProvider.channel!.sink
      //     .add('unsubscribeInfoGeneralPisCali');
    } else if (state == AppLifecycleState.resumed) {
      // La app volvió al primer plano
      // if (PiscinasGracaProvider.channel != null) {
      //   // EbProvider.channel!.sink.add('subscribe1B');
      //    WidgetsBinding.instance.addObserver(this);
      //   Provider.of<PiscinasGracaProvider>(context, listen: false)
      //       .subscribePiscinasInfoGeneralGraca();
      //   // print('Suscripción a SD realizada.');
      // }

      WidgetsBinding.instance.addObserver(this);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Espera a que el canal WebSocket esté inicializado
        if (PiscinasJosefinaProvider.channel != null) {
          // EbProvider.channel!.sink.add('subscribe1B');
          Provider.of<PiscinasJosefinaProvider>(context, listen: false)
              .subscribePiscinasInfoGeneralJosefina();
          // print('Suscripción a SD realizada.');
        }
        // provider.addListener(() {
        //   if (mounted) {
        //     setState(() {
        //       firstLoad = false;
        //     });
        //   }
        // });
      });
    }
  }

  String searchQuery = '';
  String selectedFilter = 'Todos';

  @override
  Widget build(BuildContext context) {
    // if (StorageService.prefs.getBool('FlagAireCali')!) {
    //   loadApiDataList();
    //   // WidgetsBinding.instance.addObserver(this);
    // }

    final size = MediaQuery.of(context).size;

    final List<ItemBotonAireacion> items = [
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC20',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC20.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC20.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC20.Num_Air_On"] : 0,
          0,
          1,
          'pc20_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC101',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC101.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC101.Alarm_Adver"] : 0,
          2,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC101.Num_Air_On"] : 0,
          0,
          1,
          'pc101_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC102',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC102.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC102.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC102.Num_Air_On"] : 0,
          0,
          1,
          'pc102_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC103',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC103.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC103.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC103.Num_Air_On"] : 0,
          0,
          1,
          'pc103_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC104',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC104.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC104.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC104.Num_Air_On"] : 0,
          0,
          1,
          'pc104_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC106',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC106.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC106.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC106.Num_Air_On"] : 0,
          0,
          1,
          'pc106_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC107',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC107.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC107.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC107.Num_Air_On"] : 0,
          0,
          1,
          'pc107_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC108',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC108.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC108.Alarm_Adver"] : 0,
          2,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC108.Num_Air_On"] : 0,
          0,
          1,
          'pc108_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC111',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC111.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC111.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC111.Num_Air_On"] : 0,
          0,
          1,
          'pc111_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC113',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC113.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC113.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC113.Num_Air_On"] : 0,
          0,
          1,
          'pc113_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC114',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC114.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC114.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC114.Num_Air_On"] : 0,
          0,
          1,
          'pc114_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC115',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC115.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC115.Alarm_Adver"] : 0,
          2,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC115.Num_Air_On"] : 0,
          0,
          1,
          'pc115_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC116',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC116.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC116.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC116.Num_Air_On"] : 0,
          0,
          1,
          'pc116_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PC117',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PC117.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC117.Alarm_Adver"] : 0,
          2,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PC117.Num_Air_On"] : 0,
          0,
          1,
          'pc117_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS01',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS01.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS01.Alarm_Adver"] : 0,
          7,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS01.Num_Air_On"] : 0,
          0,
          2,
          'ps01_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS02',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS02.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS02.Alarm_Adver"] : 0,
          8,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS02.Num_Air_On"] : 0,
          0,
          2,
          'ps02_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS03',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS03.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS03.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS03.Num_Air_On"] : 0,
          0,
          1,
          'ps03_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS04',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS04.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS04.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS04.Num_Air_On"] : 0,
          0,
          1,
          'ps04_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS05',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS05.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS05.Alarm_Adver"] : 0,
          8,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS05.Num_Air_On"] : 0,
          0,
          2,
          'ps05_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS06',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS06.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS06.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS06.Num_Air_On"] : 0,
          0,
          1,
          'ps06_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS07',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS07.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS07.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS07.Num_Air_On"] : 0,
          0,
          1,
          'ps07_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS08',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS08.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS08.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS08.Num_Air_On"] : 0,
          0,
          1,
          'ps08_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS09',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS09.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS09.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS09.Num_Air_On"] : 0,
          0,
          1,
          'ps09_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS10',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS10.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS10.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS10.Num_Air_On"] : 0,
          0,
          1,
          'ps10_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS11',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS11.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS11.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS11.Num_Air_On"] : 0,
          0,
          1,
          'ps11_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS13',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS13.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS13.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS13.Num_Air_On"] : 0,
          0,
          1,
          'ps13_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS14',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS14.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS14.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS14.Num_Air_On"] : 0,
          0,
          1,
          'ps14_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS15',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS15.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS15.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS15.Num_Air_On"] : 0,
          0,
          1,
          'ps15_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS16',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS16.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS16.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS16.Num_Air_On"] : 0,
          0,
          1,
          'ps16_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS17',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS17.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS17.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS17.Num_Air_On"] : 0,
          0,
          1,
          'ps17_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS18',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS18.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS18.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS18.Num_Air_On"] : 0,
          0,
          1,
          'ps18_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS19',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS19.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS19.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS19.Num_Air_On"] : 0,
          0,
          1,
          'ps19_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS21',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS21.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS21.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS21.Num_Air_On"] : 0,
          0,
          1,
          'ps21_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS22',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS22.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS22.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS22.Num_Air_On"] : 0,
          0,
          1,
          'ps22_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS23',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS23.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS23.Alarm_Adver"] : 0,
          9,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS23.Num_Air_On"] : 0,
          0,
          2,
          'ps23_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS24',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS24.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS24.Alarm_Adver"] : 0,
          10,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS24.Num_Air_On"] : 0,
          0,
          2,
          'ps24_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS25',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS25.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS25.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS25.Num_Air_On"] : 0,
          0,
          1,
          'ps25_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS26',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS26.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS26.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS26.Num_Air_On"] : 0,
          0,
          1,
          'ps26_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS27',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS27.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS27.Alarm_Adver"] : 0,
          9,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS27.Num_Air_On"] : 0,
          0,
          2,
          'ps27_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS28',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS28.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS28.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS28.Num_Air_On"] : 0,
          0,
          1,
          'ps28_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS29',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS29.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS29.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS29.Num_Air_On"] : 0,
          0,
          1,
          'ps29_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS30',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS30.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS30.Alarm_Adver"] : 0,
          7,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS30.Num_Air_On"] : 0,
          0,
          2,
          'ps30_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS31',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS31.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS31.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS31.Num_Air_On"] : 0,
          0,
          1,
          'ps31_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS32',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS32.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS32.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS32.Num_Air_On"] : 0,
          0,
          1,
          'ps32_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS33',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS33.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS33.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS33.Num_Air_On"] : 0,
          0,
          1,
          'ps33_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS34',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS34.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS34.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS34.Num_Air_On"] : 0,
          0,
          1,
          'ps34_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS35',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS35.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS35.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS35.Num_Air_On"] : 0,
          0,
          1,
          'ps35_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS36',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS36.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS36.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS36.Num_Air_On"] : 0,
          0,
          1,
          'ps36_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS37',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS37.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS37.Alarm_Adver"] : 0,
          6,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS37.Num_Air_On"] : 0,
          0,
          1,
          'ps37_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS38',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS38.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS38.Alarm_Adver"] : 0,
          11,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS38.Num_Air_On"] : 0,
          0,
          2,
          'ps38_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS39',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS39.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS39.Alarm_Adver"] : 0,
          12,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS39.Num_Air_On"] : 0,
          0,
          2,
          'ps39_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS40',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS40.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS40.Alarm_Adver"] : 0,
          11,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS40.Num_Air_On"] : 0,
          0,
          2,
          'ps40_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS41',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS41.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS41.Alarm_Adver"] : 0,
          11,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS41.Num_Air_On"] : 0,
          0,
          2,
          'ps41_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS42',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS42.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS42.Alarm_Adver"] : 0,
          9,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS42.Num_Air_On"] : 0,
          0,
          2,
          'ps42_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS43',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS43.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS43.Alarm_Adver"] : 0,
          8,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS43.Num_Air_On"] : 0,
          0,
          2,
          'ps43_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS44',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS44.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS44.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS44.Num_Air_On"] : 0,
          0,
          1,
          'ps44_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS45',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS45.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS45.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS45.Num_Air_On"] : 0,
          0,
          1,
          'ps45_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS46',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS46.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS46.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS46.Num_Air_On"] : 0,
          0,
          1,
          'ps46_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS47',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS47.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS47.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS47.Num_Air_On"] : 0,
          0,
          1,
          'ps47_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS47B',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS47B.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS47B.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS47B.Num_Air_On"] : 0,
          0,
          1,
          'ps47B_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS48',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS48.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS48.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS48.Num_Air_On"] : 0,
          0,
          1,
          'ps48_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS49',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS49.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS49.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS49.Num_Air_On"] : 0,
          0,
          1,
          'ps49_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS50',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS50.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS50.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS50.Num_Air_On"] : 0,
          0,
          1,
          'ps50_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS51',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS51.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS51.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS51.Num_Air_On"] : 0,
          0,
          1,
          'ps51_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS52',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS52.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS52.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS52.Num_Air_On"] : 0,
          0,
          1,
          'ps52_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS53',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS53.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS53.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS53.Num_Air_On"] : 0,
          0,
          1,
          'ps53_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS54',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS54.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS54.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS54.Num_Air_On"] : 0,
          0,
          1,
          'ps54_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS55',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS55.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS55.Alarm_Adver"] : 0,
          5,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS55.Num_Air_On"] : 0,
          0,
          1,
          'ps55_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS56',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS56.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS56.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS56.Num_Air_On"] : 0,
          0,
          1,
          'ps56_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS57',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS57.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS57.Alarm_Adver"] : 0,
          3,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS57.Num_Air_On"] : 0,
          0,
          1,
          'ps57_josefina_screen'),
      ItemBotonAireacion(
          FontAwesomeIcons.solidCircle,
          'PS58',
          const Color.fromRGBO(240, 240, 229, 1),
          const Color.fromRGBO(240, 240, 229, 1),
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["PS58.Algun_Air_On"]
              : false,

          // Colors.red,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS58.Alarm_Adver"] : 0,
          4,
          apiDataList.isNotEmpty ? apiDataList[0][0]["PS58.Num_Air_On"] : 0,
          0,
          1,
          'ps58_josefina_screen'),
    ];

    final filteredItems = items.where((item) {
      if (selectedFilter == 'Con Alarma' &&
          item.alarma != 2 &&
          item.alarma != 3) {
        return false;
      }
      if (selectedFilter == 'Con Advertencia' && item.alarma != 1) {
        return false;
      }
      if (selectedFilter == 'Encendidas' && !item.estado) {
        return false;
      }
      if (selectedFilter == 'Apagadas' && item.estado) {
        return false;
      }
      return item.texto.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    List<Widget> itemMap = filteredItems.map(
      (item) {
        return BotonGordoAireacion(
          icon: item.icon,
          color1: item.color1,
          color2: item.color2,
          texto: item.texto,
          onPress: () {
            Navigator.pushNamed(context, item.id);
            cancel();
            // saveApiDataList(apiDataList);
            WidgetsBinding.instance.removeObserver(this);
            // flag = true;
          },
          estado: item.estado,
          alarma: item.alarma,
          numCirc: item.numCirc,
          numCircOn: item.numCircOn,
          ta: item.ta,
          tcp: item.tcp,
        );
      },
    ).toList();

    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Fondo transparente
          elevation: 0, // Sin sombra
          scrolledUnderElevation: 0,
          // toolbarHeight: 80, // Ajusta la altura según sea necesario
          toolbarHeight: size.height * 0.1,
          centerTitle: true,
          automaticallyImplyLeading:
              false, // Evita el botón de regreso predeterminado
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Función para regresar
                },
                child: Container(
                  color: Colors.transparent,
                  // height: 200,
                  height: size.height * 0.1,
                  // width: 30,
                  width: size.width * 0.083,
                  // color: Colors.amber,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Aireación',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const MapaAireacionJosefinaScreen(),
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
                      // height: 200,
                      height: size.height * 0.1,
                      // width: 30,
                      width: size.width * 0.083,
                      child: Icon(
                        Icons.gps_fixed_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const HelpAireacionGracaScreen(),
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
                      // height: 200,
                      height: size.height * 0.1,
                      // width: 30,
                      width: size.width * 0.083,
                      child: Icon(
                        Icons.help_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                // height: 250,
                height: size.height * 0.33,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    // color: Color(0xFF212121), // Negro
                    // color: Color.fromRGBO(18, 34, 23, 0.859),
                    // color: Color.fromRGBO(1, 39, 8, 0.9),
                    // color: Color.fromRGBO(18, 34, 23, 0.859),
                    gradient: LinearGradient(
                      colors: [
                        // Color(0xFF003366), // Azul oscuro
                        // Color(0xFF0073CC), // Azul medio
                        // Color(0xFF00A3FF), // Azul claro

                        Color.fromARGB(255, 4, 63, 122), // Azul oscuro
                        // Color(0xFF003366), // Azul oscuro

                        Color(0xFF0073CC), // Azul medio
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
              // Positioned(
              //   bottom: 0,
              //   child: Container(
              //     height: 100,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: const BoxDecoration(
              //         // color: Color(0xFF212121), // Negro
              //         // color: Color.fromRGBO(18, 34, 23, 0.859),
              //         // color: Color.fromRGBO(1, 39, 8, 0.9),
              //         color: Color.fromRGBO(18, 34, 23, 0.859),
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(50),
              //             topRight: Radius.circular(250))),
              //   ),
              // ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      // Barra superior
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Icon(Icons.arrow_back_ios_new_rounded,
                      //         size: 18, color: Colors.white),
                      //     SizedBox(
                      //       width: 0,
                      //     ),
                      //     Text(
                      //       'Aireación',
                      //       style: TextStyle(fontSize: 17, color: Colors.white),
                      //     ),
                      //     Row(
                      //       children: [
                      //         Icon(Icons.gps_fixed_outlined,
                      //             color: Colors.white),
                      //         // const SizedBox(width: 10),
                      //         // Icon(
                      //         //   Icons.notifications_none_outlined,
                      //         // ),
                      //         SizedBox(width: 10),
                      //         GestureDetector(
                      //           onTap: () {},
                      //           child: Icon(Icons.help_outline_rounded,
                      //               color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              // width: 10,
                              width: size.width * 0.028,
                            ),
                            Expanded(
                              child: Container(
                                // height: 50,
                                height: size.height * 0.066,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 235, 234, 234),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.search),
                                      SizedBox(
                                        // width: 10
                                        width: size.width * 0.028,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          onChanged: (value) {
                                            // Actualiza el estado de búsqueda
                                            if (mounted) {
                                              setState(() {
                                                searchQuery = value;
                                              });
                                            }
                                          },
                                          cursorColor: Colors.black,
                                          decoration: const InputDecoration(
                                            hintText: 'Busca una Piscina',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              // width: 20
                              width: size.width * 0.05,
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.filter_alt_sharp,
                                color: Colors.white,
                              ),
                              color: Colors.white,
                              onSelected: (String result) {
                                setState(() {
                                  selectedFilter = result;
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Todos',
                                  child: Text('Todos'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Con Alarma',
                                  child: Text('Con Alarma'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Con Advertencia',
                                  child: Text('Con Advertencia'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Encendidas',
                                  child: Text('Encendidas'),
                                ),
                                const PopupMenuItem<String>(
                                  // textStyle: TextStyle(
                                  //     backgroundColor: Colors.white,
                                  //     ),
                                  value: 'Apagadas',
                                  child: Text('Apagadas'),
                                ),
                              ],
                            ),
                            SizedBox(
                              // width: 10
                              width: size.width * 0.028,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          // height: 20
                          height: size.height * 0.025),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  '${filteredItems.length} piscinas',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                // width: 10
                                width: size.width * 0.028,
                              ),
                              if (selectedFilter != 'Todos')
                                GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        selectedFilter = 'Todos';
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Row(
                                      children: [
                                        Text('$selectedFilter'),
                                        SizedBox(
                                          // width: 8,
                                          width: size.width * 0.028,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              if (mounted) {
                                                setState(() {
                                                  selectedFilter = 'Todos';
                                                });
                                              }
                                            },
                                            child: Text(
                                              'X',
                                              style: TextStyle(fontSize: 17),
                                            ))
                                      ],
                                    ),
                                    // deleteIcon: const Icon(Icons.clear),
                                    // backgroundColor: Colors.white,
                                    // onDeleted: () {
                                    //   // Actualizar el filtro seleccionado a 'Todos'
                                    // },
                                  ),
                                ),
                            ],
                          )),

                      // Contenido principal

                      SizedBox(
                        // height: 35,
                        height: size.height * 0.046,
                      ),

                      Expanded(
                        child: Stack(
                          children: [
                            // Positioned(
                            //   top: 50,
                            //   left: 0,
                            //   right: 0,
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       const Padding(
                            //         padding: EdgeInsets.symmetric(horizontal: 20),
                            //         child: Row(
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             CircleAvatar(
                            //               radius: 30, // Tamaño del avatar
                            //               child: Text('DZ'), // Imagen de ejemplo
                            //               backgroundColor:
                            //                   Color.fromRGBO(201, 202, 203, 0.9),
                            //             ),
                            //             Text(
                            //               'Monitoreo',
                            //               style: TextStyle(
                            //                   color: Colors.white, fontSize: 17),
                            //             ),
                            //             Row(
                            //               children: [
                            //                 Icon(
                            //                   Icons.menu,
                            //                   color: Colors.white,
                            //                   size: 30,
                            //                 ),
                            //               ],
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Consumer<PiscinasJosefinaProvider>(
                                    builder: (context, psProvider, child) {
                                  apiDataList =
                                      psProvider.apiDataListInfoGeneralPis;
                                  // print(apiDataList);
                                  if (PiscinasJosefinaProvider.isLoading2) {
                                    // Mostrar indicador de carga
                                    // return ShimmerLoading();
                                    // flag = false;

                                    return ListView(
                                      children: [
                                        ShimmerContainer(),
                                        ShimmerContainer(),
                                        ShimmerContainer(),
                                        ShimmerContainer(),
                                        ShimmerContainer(),
                                        ShimmerContainer(),
                                      ],
                                    );

                                    // StorageService.saveFlag(false, 'FlagAireCali');

                                    // loadApiDataList();
                                  } else if (psProvider.hasError) {
                                    // Mostrar mensaje de error
                                    return Center(
                                        child: Icon(
                                      Icons.wifi_off_outlined,
                                      size: 80,
                                    ));
                                  }

                                  return ListView(
                                    children: [
                                      ...itemMap, // Contenido dinámico
                                    ],
                                  );
                                }))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

// import 'package:flutter/material.dart';

// class AireacionCaliforniaScreen extends StatelessWidget {
//   const AireacionCaliforniaScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Fondo oscuro profesional
//       appBar: AppBar(
//         backgroundColor: Color(0xFF212121),
//         elevation: 0,
//         title: const Text(
//           'Aireación',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//             letterSpacing: 1.2,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings, color: Colors.white, size: 28),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.help_outline, color: Colors.white, size: 28),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Barra de búsqueda con borde sutil
//             TextField(
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor:
//                     Color(0xFF333333), // Fondo oscuro para la barra de búsqueda
//                 hintText: 'Busca una Piscina',
//                 hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
//                 prefixIcon: Icon(Icons.search, color: Colors.white),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: EdgeInsets.all(15),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Título de piscinas
//             Text(
//               '17 Piscinas Disponibles',
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//             const SizedBox(height: 16),
//             // Lista de Piscinas
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 17,
//                 itemBuilder: (context, index) {
//                   return PiscinaCard(
//                     title: 'PS22A',
//                     totalItems: '0/15',
//                     ta: 'TA: 1',
//                     tcp: 'TCP: 1',
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PiscinaCard extends StatelessWidget {
//   final String title;
//   final String totalItems;
//   final String ta;
//   final String tcp;

//   const PiscinaCard({
//     required this.title,
//     required this.totalItems,
//     required this.ta,
//     required this.tcp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Acciones al presionar una piscina
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(240, 240, 229, 1),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromRGBO(240, 240, 229, 1),
//               offset: Offset(0, 4),
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.green,
//               radius: 24,
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '$totalItems   $ta   $tcp',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(Icons.chevron_right, color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.092,
      // height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100]!,
          // border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 60,
                    // height: 60,
                    height: 20,

                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      width: 120,
                      // height: 60,
                      height: 20,

                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerBackground extends StatelessWidget {
  final Widget child;

  const ContainerBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 60,
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color.fromRGBO(240, 240, 229, 1),
        //     blurRadius: 3,
        //   )
        // ],
      ),
      child: child,
    );
  }
}
