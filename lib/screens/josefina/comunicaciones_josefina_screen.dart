import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/screens/josefina/help_comunicaciones_josefina_screen.dart';
import 'package:appnaturisa/widgets/antena_info_aireacion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ItemAntenas {
  final bool status;
  final String nombre;
  final int potencia;

  ItemAntenas(
    this.status,
    this.nombre,
    this.potencia,
  );
}

class ComunicacionesJosefinaScreen extends StatefulWidget {
  const ComunicacionesJosefinaScreen({super.key});

  @override
  State<ComunicacionesJosefinaScreen> createState() =>
      _ComunicacionesJosefinaScreenState();
}

class _ComunicacionesJosefinaScreenState
    extends State<ComunicacionesJosefinaScreen> with WidgetsBindingObserver {
  List<dynamic> apiDataList = [];
  bool firstLoad = true;

  String searchQuery = '';

  String selectedFilter = 'Todos';

  void cancel() {
    if (PiscinasJosefinaProvider.channel != null) {
      PiscinasJosefinaProvider.channel!.sink.add('unsubscribeFJOSAntenas');
    }
    PiscinasJosefinaProvider.subscriptionAntenas?.cancel();
    PiscinasJosefinaProvider.subscriptionAntenas = null;
  }

  @override
  void initState() {
    // super.initState();
    // WidgetsBinding.instance.addObserver(this);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<PiscinasGracaProvider>(context, listen: false)
    //       .reconnectIfNeeded();
    //   if (firstLoad) {
    //     // Espera a que el canal WebSocket esté inicializado
    //     if (PiscinasGracaProvider.channel != null) {
    //       // EbProvider.channel!.sink.add('subscribe1B');
    //       Provider.of<PiscinasGracaProvider>(context, listen: false)
    //           .subscribePiscinasAntenas();
    //       // print('Suscripción a SD realizada.');
    //     }
    //     setState(() {
    //       firstLoad = false;
    //     });
    //   }
    // });

    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<PiscinasJosefinaProvider>(context, listen: false);

      if (!Provider.of<PiscinasJosefinaProvider>(context, listen: false)
          .hasError) {
        if (firstLoad) {
          if (PiscinasJosefinaProvider.channel != null) {
            Provider.of<PiscinasJosefinaProvider>(context, listen: false)
                .subscribePiscinasAntenas();
          }
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Intentar reconectar si es necesario cuando los dependientes cambian
    Provider.of<PiscinasJosefinaProvider>(context, listen: false)
        .reconnectIfNeeded();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.paused ||
    //     state == AppLifecycleState.inactive) {
    //   // La app está en segundo plano
    //   PiscinasGracaProvider.channel!.sink.add('unsubscribeAntenas');
    // } else if (state == AppLifecycleState.resumed) {
    //   // La app volvió al primer plano
    //   if (PiscinasGracaProvider.channel != null) {
    //     // EbProvider.channel!.sink.add('subscribe1B');
    //     Provider.of<PiscinasGracaProvider>(context, listen: false)
    //         .subscribePiscinasAntenas();
    //     // print('Suscripción a SD realizada.');
    //   }
    // }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
    } else if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addObserver(this);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Espera a que el canal WebSocket esté inicializado
        if (PiscinasJosefinaProvider.channel != null) {
          // EbProvider.channel!.sink.add('subscribe1B');
          Provider.of<PiscinasJosefinaProvider>(context, listen: false)
              .subscribePiscinasAntenas();
          // print('Suscripción a SD realizada.');
        }
      });
    }
  }

  @override
  void dispose() {
    firstLoad = true;
    WidgetsBinding.instance.removeObserver(this);
    // PiscinasGracaProvider.channel!.sink.add('unsubscribeAntenas');
    // PiscinasGracaProvider.subscriptionAntenas?.cancel();
    // PiscinasGracaProvider.subscriptionAntenas = null;
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<ItemAntenas> items = [
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA13-1"] : false,
          'TA13-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA13-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA39-2"] : false,
          'TA39-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA39-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA114-1"] : false,
          'TA114-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA114-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA37-1"] : false,
          'TA37-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA37-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA01-1"] : false,
          'TA01-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA01-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA49-1"] : false,
          'TA49-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA49-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA01-2"] : false,
          'TA01-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA01-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA15-1"] : false,
          'TA15-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA15-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA115-1"] : false,
          'TA115-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA115-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA02-1"] : false,
          'TA02-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA02-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA02-2"] : false,
          'TA02-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA02-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA03-1"] : false,
          'TA03-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA03-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA101-1"] : false,
          'TA101-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA101-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA29-1"] : false,
          'TA29-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA29-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA04-1"] : false,
          'TA04-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA04-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA42-2"] : false,
          'TA42-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA42-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA05-1"] : false,
          'TA05-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA05-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA05-2"] : false,
          'TA05-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA05-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA17-1"] : false,
          'TA17-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA17-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA06-1"] : false,
          'TA06-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA06-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA07-1"] : false,
          'TA07-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA07-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA08-1"] : false,
          'TA08-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA08-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA18-1"] : false,
          'TA18-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA18-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA09-1"] : false,
          'TA09-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA09-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA10-1"] : false,
          'TA10-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA10-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA102-1"] : false,
          'TA102-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA102-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA103-1"] : false,
          'TA103-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA103-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA104-1"] : false,
          'TA104-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA104-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA106-1"] : false,
          'TA106-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA106-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA107-1"] : false,
          'TA107-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA107-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA108-1"] : false,
          'TA108-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA108-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA11-1"] : false,
          'TA11-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA11-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA111-1"] : false,
          'TA111-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA111-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA113-1"] : false,
          'TA113-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA113-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA116-1"] : false,
          'TA116-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA116-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA117-1"] : false,
          'TA117-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA117-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA16-1"] : false,
          'TA16-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA16-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA19-1"] : false,
          'TA19-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA19-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA20-1"] : false,
          'TA20-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA20-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA21-1"] : false,
          'TA21-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA21-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA22-1"] : false,
          'TA22-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA22-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA23-1"] : false,
          'TA23-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA23-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA23-2"] : false,
          'TA23-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA23-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA24-1"] : false,
          'TA24-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA24-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA24-2"] : false,
          'TA24-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA24-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA25-1"] : false,
          'TA25-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA25-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA26-1"] : false,
          'TA26-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA26-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA27-1"] : false,
          'TA27-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA27-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA27-2"] : false,
          'TA27-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA27-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA28-1"] : false,
          'TA28-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA28-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA30-1"] : false,
          'TA30-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA30-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA30-2"] : false,
          'TA30-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA30-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA31-1"] : false,
          'TA31-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA31-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA33-1"] : false,
          'TA33-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA33-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA14-1"] : false,
          'TA14-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA14-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA32-1"] : false,
          'TA32-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA32-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA45-1"] : false,
          'TA45-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA45-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA34-1"] : false,
          'TA34-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA34-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA35-1"] : false,
          'TA35-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA35-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA36-1"] : false,
          'TA36-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA36-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA38-1"] : false,
          'TA38-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA38-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA38-2"] : false,
          'TA38-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA38-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA39-1"] : false,
          'TA39-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA39-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA40-1"] : false,
          'TA40-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA40-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA40-2"] : false,
          'TA40-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA40-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA41-1"] : false,
          'TA41-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA41-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA41-2"] : false,
          'TA41-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA41-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA42-1"] : false,
          'TA42-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA42-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA43-1"] : false,
          'TA43-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA43-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA43-2"] : false,
          'TA43-2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA43-2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA44-1"] : false,
          'TA44-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA44-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA46-1"] : false,
          'TA46-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA46-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA47-1"] : false,
          'TA47-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA47-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA47B-1"] : false,
          'TA47B-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA47B-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA48-1"] : false,
          'TA48-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA48-1"] : 0),

      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA50-1"] : false,
          'TA50-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA50-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA51-1"] : false,
          'TA51-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA51-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA52-1"] : false,
          'TA52-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA52-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA53-1"] : false,
          'TA53-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA53-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA54-1"] : false,
          'TA54-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA54-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA55-1"] : false,
          'TA55-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA55-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA56-1"] : false,
          'TA56-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA56-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA57-1"] : false,
          'TA57-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA57-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_TA58-1"] : false,
          'TA58-1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_TA58-1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_AP1"] : false,
          'JOSE-AP1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_AP1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_AP2"] : false,
          'JOSE-AP2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_AP2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_AP3"] : false,
          'JOSE-AP3',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_AP3"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["Stat_Camp-PTP-Mari"]
              : false,
          'JOSE-C-PTP-Mari',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_Camp-PTP-Mari"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_EB_G1"] : false,
          'ANT_EB_G1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_EB_G1"] : 0),
      // ItemAntenas(
      //     apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_EB_G2"] : false,
      //     'EB_G2',
      //     apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_EB_G2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["Stat_PTP-Camp-T1"]
              : false,
          'JOSE-PTP-C-T1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_PTP-Camp-T1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["Stat_PTP-Camp-T2"]
              : false,
          'JOSE-PTP-C-T2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_PTP-Camp-T2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty
              ? apiDataList[0][0]["Stat_PTP-Camp-T3"]
              : false,
          'JOSE-PTP-C-T3',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_PTP-Camp-T3"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_PTP-Mari"] : false,
          'JOSE-PTP-Mari',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_PTP-Mari"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_PTP-T1"] : false,
          'JOSE-PTP-T1',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_PTP-T1"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_PTP-T2"] : false,
          'JOSE-PTP-T2',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_PTP-T2"] : 0),
      ItemAntenas(
          apiDataList.isNotEmpty ? apiDataList[0][0]["Stat_PTP-T3"] : false,
          'JOSE-PTP-T3',
          apiDataList.isNotEmpty ? apiDataList[0][0]["Pot_PTP-T3"] : 0),
    ];

    final filteredItems = items.where((item) {
      if (selectedFilter == 'Activas' && !item.status) {
        return false;
      }
      if (selectedFilter == 'Inactivas' && item.status) {
        return false;
      }
      return item.nombre.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    List<Widget> itemMap = filteredItems.map(
      (item) {
        return AntenaInfoAireacion(
            estado: item.status, tablero: item.nombre, potencia: item.potencia);
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
                  'Comunicaciones',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const HelpComunicacionesJosefinaScreen(),
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
            Container(
              height: 250,
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
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 235, 234, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.search),
                                    const SizedBox(width: 10),
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
                                          hintText: 'Busca una Antena',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.filter_alt_sharp,
                              color: Colors.white,
                            ),
                            color: Colors.white,
                            onSelected: (String result) {
                              // Actualizar el filtro seleccionado
                              setState(() {
                                selectedFilter = result;
                              });
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'Todos',
                                child: Text('Todos'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Activas',
                                child: Text('Activas'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Inactivas',
                                child: Text('Inactivas'),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

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
                                '${filteredItems.length} antenas',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (selectedFilter != 'Todos')
                              GestureDetector(
                                onTap: () {
                                  // Actualizar el filtro seleccionado
                                },
                                child: GestureDetector(
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
                                          width: 7,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              if (mounted) {
                                                setState(() {
                                                  selectedFilter = 'Todos';
                                                });
                                              }
                                            },
                                            child: Container(
                                              // color: Colors.red,
                                              width: 20,
                                              height: 25,
                                              child: Center(
                                                child: Text(
                                                  'X',
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
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
                              ),
                          ],
                        )),

                    // Contenido principal

                    const SizedBox(
                      height: 35,
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

                          const SizedBox(
                            height: 35,
                          ),

                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Consumer<PiscinasJosefinaProvider>(
                                  builder: (context, psProvider, child) {
                                apiDataList = psProvider.apiDataListAntenas;
                                print(apiDataList);
                                // print(apiDataList);
                                if (PiscinasJosefinaProvider.isLoading2) {
                                  // Mostrar indicador de carga
                                  // return ShimmerLoading();
                                  // flag = false;

                                  return ListView(
                                    children: [
                                      ShimmerContainerAntenas(),
                                      ShimmerContainerAntenas(),
                                      ShimmerContainerAntenas(),
                                      ShimmerContainerAntenas(),
                                      ShimmerContainerAntenas(),
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
                              })),
                        ],
                      ),
                    ),

                    // Agrega más instancias si lo deseas
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class ShimmerContainerAntenas extends StatelessWidget {
  const ShimmerContainerAntenas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // width: double.infinity,
      // height: size.height * 0.15,
      // margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      height: 95,
      width: 400,
      // height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.grey[100]!,
          // border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 50,
                    // height: 60,
                    height: 15,

                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  )),
              SizedBox(
                height: 5,
              ),
              Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 250,
                    // height: 60,
                    height: 15,

                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
