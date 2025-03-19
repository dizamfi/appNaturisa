import 'dart:async';
import 'dart:convert';
import 'package:appnaturisa/helpers/piscina.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

class PiscinasJosefinaProvider extends ChangeNotifier {
  static Stream<dynamic>? _broadcastStream;
  static bool isLoading2 = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool isReconnecting = false;
  static bool isConnected = false;
  static int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 2);
  static String? currentSubscription;
  static IOWebSocketChannel? channel;

  final List<dynamic> _apiDataListPC20 = [];
  final List<dynamic> _apiDataListPC101 = [];
  final List<dynamic> _apiDataListPC102 = [];
  final List<dynamic> _apiDataListPC103 = [];
  final List<dynamic> _apiDataListPC104 = [];
  final List<dynamic> _apiDataListPC106 = [];
  final List<dynamic> _apiDataListPC107 = [];
  final List<dynamic> _apiDataListPC108 = [];
  final List<dynamic> _apiDataListPC111 = [];
  final List<dynamic> _apiDataListPC113 = [];
  final List<dynamic> _apiDataListPC114 = [];
  final List<dynamic> _apiDataListPC115 = [];
  final List<dynamic> _apiDataListPC116 = [];
  final List<dynamic> _apiDataListPC117 = [];
  final List<dynamic> _apiDataListPS01 = [];
  final List<dynamic> _apiDataListPS02 = [];
  final List<dynamic> _apiDataListPS03 = [];
  final List<dynamic> _apiDataListPS04 = [];
  final List<dynamic> _apiDataListPS05 = [];
  final List<dynamic> _apiDataListPS06 = [];
  final List<dynamic> _apiDataListPS07 = [];
  final List<dynamic> _apiDataListPS08 = [];
  final List<dynamic> _apiDataListPS09 = [];
  final List<dynamic> _apiDataListPS10 = [];
  final List<dynamic> _apiDataListPS11 = [];
  final List<dynamic> _apiDataListPS13 = [];
  final List<dynamic> _apiDataListPS14 = [];
  final List<dynamic> _apiDataListPS15 = [];
  final List<dynamic> _apiDataListPS16 = [];
  final List<dynamic> _apiDataListPS17 = [];
  final List<dynamic> _apiDataListPS18 = [];
  final List<dynamic> _apiDataListPS19 = [];
  final List<dynamic> _apiDataListPS21 = [];
  final List<dynamic> _apiDataListPS22 = [];
  final List<dynamic> _apiDataListPS23 = [];
  final List<dynamic> _apiDataListPS24 = [];
  final List<dynamic> _apiDataListPS25 = [];
  final List<dynamic> _apiDataListPS26 = [];
  final List<dynamic> _apiDataListPS27 = [];
  final List<dynamic> _apiDataListPS28 = [];
  final List<dynamic> _apiDataListPS29 = [];
  final List<dynamic> _apiDataListPS30 = [];
  final List<dynamic> _apiDataListPS31 = [];
  final List<dynamic> _apiDataListPS32 = [];
  final List<dynamic> _apiDataListPS33 = [];
  final List<dynamic> _apiDataListPS34 = [];
  final List<dynamic> _apiDataListPS35 = [];
  final List<dynamic> _apiDataListPS36 = [];
  final List<dynamic> _apiDataListPS37 = [];
  final List<dynamic> _apiDataListPS38 = [];
  final List<dynamic> _apiDataListPS39 = [];
  final List<dynamic> _apiDataListPS40 = [];
  final List<dynamic> _apiDataListPS41 = [];
  final List<dynamic> _apiDataListPS42 = [];
  final List<dynamic> _apiDataListPS43 = [];
  final List<dynamic> _apiDataListPS44 = [];
  final List<dynamic> _apiDataListPS45 = [];
  final List<dynamic> _apiDataListPS46 = [];
  final List<dynamic> _apiDataListPS47 = [];
  final List<dynamic> _apiDataListPS47B = [];
  final List<dynamic> _apiDataListPS48 = [];
  final List<dynamic> _apiDataListPS49 = [];
  final List<dynamic> _apiDataListPS50 = [];
  final List<dynamic> _apiDataListPS51 = [];
  final List<dynamic> _apiDataListPS52 = [];
  final List<dynamic> _apiDataListPS53 = [];
  final List<dynamic> _apiDataListPS54 = [];
  final List<dynamic> _apiDataListPS55 = [];
  final List<dynamic> _apiDataListPS56 = [];
  final List<dynamic> _apiDataListPS57 = [];
  final List<dynamic> _apiDataListPS58 = [];

  final List<dynamic> _apiDataListInfoGeneralPis = [];
  final List<dynamic> _apiDataListAntenas = [];
  final List<dynamic> _apiDataListEBFJOS = [];

  static StreamSubscription? subscriptionPC20;
  static StreamSubscription? subscriptionPC101;
  static StreamSubscription? subscriptionPC102;
  static StreamSubscription? subscriptionPC103;
  static StreamSubscription? subscriptionPC104;
  static StreamSubscription? subscriptionPC106;
  static StreamSubscription? subscriptionPC107;
  static StreamSubscription? subscriptionPC108;
  static StreamSubscription? subscriptionPC109;
  static StreamSubscription? subscriptionPC111;
  static StreamSubscription? subscriptionPC113;
  static StreamSubscription? subscriptionPC114;
  static StreamSubscription? subscriptionPC115;
  static StreamSubscription? subscriptionPC116;
  static StreamSubscription? subscriptionPC117;
  static StreamSubscription? subscriptionPS01;
  static StreamSubscription? subscriptionPS02;
  static StreamSubscription? subscriptionPS03;
  static StreamSubscription? subscriptionPS04;
  static StreamSubscription? subscriptionPS05;
  static StreamSubscription? subscriptionPS06;
  static StreamSubscription? subscriptionPS07;
  static StreamSubscription? subscriptionPS08;
  static StreamSubscription? subscriptionPS09;
  static StreamSubscription? subscriptionPS10;
  static StreamSubscription? subscriptionPS11;
  static StreamSubscription? subscriptionPS13;
  static StreamSubscription? subscriptionPS14;
  static StreamSubscription? subscriptionPS15;
  static StreamSubscription? subscriptionPS16;
  static StreamSubscription? subscriptionPS17;
  static StreamSubscription? subscriptionPS18;
  static StreamSubscription? subscriptionPS19;
  static StreamSubscription? subscriptionPS21;
  static StreamSubscription? subscriptionPS22;
  static StreamSubscription? subscriptionPS23;
  static StreamSubscription? subscriptionPS24;
  static StreamSubscription? subscriptionPS25;
  static StreamSubscription? subscriptionPS26;
  static StreamSubscription? subscriptionPS27;
  static StreamSubscription? subscriptionPS28;
  static StreamSubscription? subscriptionPS29;
  static StreamSubscription? subscriptionPS30;
  static StreamSubscription? subscriptionPS31;
  static StreamSubscription? subscriptionPS32;
  static StreamSubscription? subscriptionPS33;
  static StreamSubscription? subscriptionPS34;
  static StreamSubscription? subscriptionPS35;
  static StreamSubscription? subscriptionPS36;
  static StreamSubscription? subscriptionPS37;
  static StreamSubscription? subscriptionPS38;
  static StreamSubscription? subscriptionPS39;
  static StreamSubscription? subscriptionPS40;
  static StreamSubscription? subscriptionPS41;
  static StreamSubscription? subscriptionPS42;
  static StreamSubscription? subscriptionPS43;
  static StreamSubscription? subscriptionPS44;
  static StreamSubscription? subscriptionPS45;
  static StreamSubscription? subscriptionPS46;
  static StreamSubscription? subscriptionPS47;
  static StreamSubscription? subscriptionPS47B;
  static StreamSubscription? subscriptionPS48;
  static StreamSubscription? subscriptionPS49;
  static StreamSubscription? subscriptionPS50;
  static StreamSubscription? subscriptionPS51;
  static StreamSubscription? subscriptionPS52;
  static StreamSubscription? subscriptionPS53;
  static StreamSubscription? subscriptionPS54;
  static StreamSubscription? subscriptionPS55;
  static StreamSubscription? subscriptionPS56;
  static StreamSubscription? subscriptionPS57;
  static StreamSubscription? subscriptionPS58;

  static StreamSubscription? subscriptionInfoGeneralPis;
  static StreamSubscription? subscriptionAntenas;
  static StreamSubscription? subscriptionEBFJOS;

  List<dynamic> get apiDataListPC20 => _apiDataListPC20;
  List<dynamic> get apiDataListPC101 => _apiDataListPC101;
  List<dynamic> get apiDataListPC102 => _apiDataListPC102;
  List<dynamic> get apiDataListPC103 => _apiDataListPC103;
  List<dynamic> get apiDataListPC104 => _apiDataListPC104;
  List<dynamic> get apiDataListPC106 => _apiDataListPC106;
  List<dynamic> get apiDataListPC107 => _apiDataListPC107;
  List<dynamic> get apiDataListPC108 => _apiDataListPC108;
  List<dynamic> get apiDataListPC111 => _apiDataListPC111;
  List<dynamic> get apiDataListPC113 => _apiDataListPC113;
  List<dynamic> get apiDataListPC114 => _apiDataListPC114;
  List<dynamic> get apiDataListPC115 => _apiDataListPC115;
  List<dynamic> get apiDataListPC116 => _apiDataListPC116;
  List<dynamic> get apiDataListPC117 => _apiDataListPC117;
  List<dynamic> get apiDataListPS01 => _apiDataListPS01;
  List<dynamic> get apiDataListPS02 => _apiDataListPS02;
  List<dynamic> get apiDataListPS03 => _apiDataListPS03;
  List<dynamic> get apiDataListPS04 => _apiDataListPS04;
  List<dynamic> get apiDataListPS05 => _apiDataListPS05;
  List<dynamic> get apiDataListPS06 => _apiDataListPS06;
  List<dynamic> get apiDataListPS07 => _apiDataListPS07;
  List<dynamic> get apiDataListPS08 => _apiDataListPS08;
  List<dynamic> get apiDataListPS09 => _apiDataListPS09;
  List<dynamic> get apiDataListPS10 => _apiDataListPS10;
  List<dynamic> get apiDataListPS11 => _apiDataListPS11;
  List<dynamic> get apiDataListPS13 => _apiDataListPS13;
  List<dynamic> get apiDataListPS14 => _apiDataListPS14;
  List<dynamic> get apiDataListPS15 => _apiDataListPS15;
  List<dynamic> get apiDataListPS16 => _apiDataListPS16;
  List<dynamic> get apiDataListPS17 => _apiDataListPS17;
  List<dynamic> get apiDataListPS18 => _apiDataListPS18;
  List<dynamic> get apiDataListPS19 => _apiDataListPS19;
  List<dynamic> get apiDataListPS21 => _apiDataListPS21;
  List<dynamic> get apiDataListPS22 => _apiDataListPS22;
  List<dynamic> get apiDataListPS23 => _apiDataListPS23;
  List<dynamic> get apiDataListPS24 => _apiDataListPS24;
  List<dynamic> get apiDataListPS25 => _apiDataListPS25;
  List<dynamic> get apiDataListPS26 => _apiDataListPS26;
  List<dynamic> get apiDataListPS27 => _apiDataListPS27;
  List<dynamic> get apiDataListPS28 => _apiDataListPS28;
  List<dynamic> get apiDataListPS29 => _apiDataListPS29;
  List<dynamic> get apiDataListPS30 => _apiDataListPS30;
  List<dynamic> get apiDataListPS31 => _apiDataListPS31;
  List<dynamic> get apiDataListPS32 => _apiDataListPS32;
  List<dynamic> get apiDataListPS33 => _apiDataListPS33;
  List<dynamic> get apiDataListPS34 => _apiDataListPS34;
  List<dynamic> get apiDataListPS35 => _apiDataListPS35;
  List<dynamic> get apiDataListPS36 => _apiDataListPS36;
  List<dynamic> get apiDataListPS37 => _apiDataListPS37;
  List<dynamic> get apiDataListPS38 => _apiDataListPS38;
  List<dynamic> get apiDataListPS39 => _apiDataListPS39;
  List<dynamic> get apiDataListPS40 => _apiDataListPS40;
  List<dynamic> get apiDataListPS41 => _apiDataListPS41;
  List<dynamic> get apiDataListPS42 => _apiDataListPS42;
  List<dynamic> get apiDataListPS43 => _apiDataListPS43;
  List<dynamic> get apiDataListPS44 => _apiDataListPS44;
  List<dynamic> get apiDataListPS45 => _apiDataListPS45;
  List<dynamic> get apiDataListPS46 => _apiDataListPS46;
  List<dynamic> get apiDataListPS47 => _apiDataListPS47;
  List<dynamic> get apiDataListPS47B => _apiDataListPS47B;
  List<dynamic> get apiDataListPS48 => _apiDataListPS48;
  List<dynamic> get apiDataListPS49 => _apiDataListPS49;
  List<dynamic> get apiDataListPS50 => _apiDataListPS50;
  List<dynamic> get apiDataListPS51 => _apiDataListPS51;
  List<dynamic> get apiDataListPS52 => _apiDataListPS52;
  List<dynamic> get apiDataListPS53 => _apiDataListPS53;
  List<dynamic> get apiDataListPS54 => _apiDataListPS54;
  List<dynamic> get apiDataListPS55 => _apiDataListPS55;
  List<dynamic> get apiDataListPS56 => _apiDataListPS56;
  List<dynamic> get apiDataListPS57 => _apiDataListPS57;
  List<dynamic> get apiDataListPS58 => _apiDataListPS58;

  List<dynamic> get apiDataListInfoGeneralPis => _apiDataListInfoGeneralPis;
  List<dynamic> get apiDataListAntenas => _apiDataListAntenas;
  List<dynamic> get apiDataListEBFJOS => _apiDataListEBFJOS;

  bool get isLoading => isLoading2;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  PiscinasJosefinaProvider() {
    connectWebSocket();
    // print('a22222222');
  }

  void connectWebSocket() {
    if (channel == null || channel!.closeCode != null) {
      try {
        channel = IOWebSocketChannel.connect(
            Uri.parse('ws://201.217.78.155:6060')); // Cambiar
        // print('Socket iniciado');
        _broadcastStream = channel!.stream.asBroadcastStream();
        _broadcastStream!.listen((data) {}, onError: (error) {
          _handleDisconnect();
        }, onDone: () {
          // print('Conexión cerrada. Intentando reconectar...');
          _handleDisconnect();
        });

        isConnected = true;

        resetReconnectAttempts();

        // Después de conectar, resuscribirse automáticamente
        if (currentSubscription != null) {
          _subscribeTo(currentSubscription!);
        }
      } catch (e) {
        _hasError = true;
        print('Error al conectar WebSocket: $e');
        _handleDisconnect();
      }
    }
  }

  void _handleDisconnect() {
    channel = null;
    isConnected = false;
    // isLoading2 = true;
    // print(_isLoading);
    if (_reconnectAttempts < _maxReconnectAttempts) {
      _reconnectAttempts++;
      Future.delayed(_reconnectDelay, () {
        // print('Reconectando... Intento $_reconnectAttempts');
        connectWebSocket(); // Intenta reconectar después del retraso
      });
    } else {
      // print(
      //     'Máximo de intentos de reconexión alcanzado. Deteniendo reconexión.');
    }
  }

  static void resetReconnectAttempts() {
    _reconnectAttempts =
        0; // Resetea los intentos de reconexión cuando sea necesario
  }

  void _subscribeTo(String subscription) {
    if (isConnected) {
      channel!.sink.add('subscribeFJOS$subscription');
      // print(channel);
      currentSubscription = subscription;
      // print(currentSubscription);
      // print('sssssssss');

      notifyListeners();
    }
  }

  void reconnectIfNeeded() async {
    if (channel == null) {
      channel = IOWebSocketChannel.connect('ws://201.217.78.155:6060');
      channel!.stream.listen((message) {}, onDone: () {
        // print('Conexión de WebSocket cerrada.');
      }, onError: (error) {
        // print('Error en la conexión de WebSocket: $error');
      });
    } else {
      // print('WebSocket ya está conectado.');
    }
  }

  void subscribeEBFJOS() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('EB');
    notifyListeners();

    if (subscriptionEBFJOS == null) {
      _apiDataListEBFJOS.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListGral = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionEBFJOS = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListGral.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('EBJosefina')) {
            dynamic firstItem = decodedEvent['EBJosefina'][0];
            dynamic itemGral = decodedEvent['EBJosefinaGral'][0];
            dynamic itemTCP = decodedEvent['EBJosefinaTCP'][0];
            dynamic itemAntenas = decodedEvent['EBJosefinaAntenas'][0];

            apiDataList.add({
              'I L1': '${firstItem['ST1_Corrien_L1']} A',
              'Volt L1-L2': '${firstItem['ST1_Tens_red_L1-L2']} V',
              'I L2': '${firstItem['ST1_Corrien_L2']} A',
              'Volt L2-L3': '${firstItem['ST1_Tens_red_L2-L3']} V',
              'I L3': '${firstItem['ST1_Corrien_L3']} A',
              'Volt L3-L1': '${firstItem['ST1_Tens_red_L3-L1']} V',
              'Pot Inst': '${firstItem['ST1_Potencia_Activa']} Kw',
              'FP': double.parse(firstItem['ST1_Factor_Potencia'])
                  .toStringAsFixed(2),
              'Energ_Act':
                  '${double.parse(firstItem['ST1_Energ_Activa']).toStringAsFixed(2)} MWh',
              'Horómetro': '${firstItem['ST1_Horometro']} H',
              'Hrs_Dia':
                  '${double.parse(firstItem['ST1_Hrs_Dia']).toStringAsFixed(2)} H/D',
              'Hrs_Dia_Ant':
                  '${double.parse(firstItem['ST1_Hrs_Dia_Ant']).toStringAsFixed(2)} H/D',
            });

            apiDataList.add({
              'I L1': '${firstItem['ST2_Corrien_L1']} A',
              'Volt L1-L2': '${firstItem['ST2_Tens_red_L1-L2']} V',
              'I L2': '${firstItem['ST2_Corrien_L2']} A',
              'Volt L2-L3': '${firstItem['ST2_Tens_red_L2-L3']} V',
              'I L3': '${firstItem['ST2_Corrien_L3']} A',
              'Volt L3-L1': '${firstItem['ST2_Tens_red_L3-L1']} V',
              'Pot Inst': '${firstItem['ST2_Potencia_Activa']} Kw',
              'FP': double.parse(firstItem['ST2_Factor_Potencia'])
                  .toStringAsFixed(2),
              'Energ_Act':
                  '${double.parse(firstItem['ST2_Energ_Activa']).toStringAsFixed(2)} MWh',
              'Horómetro': '${firstItem['ST2_Horometro']} H',
              'Hrs_Dia':
                  '${double.parse(firstItem['ST2_Hrs_Dia']).toStringAsFixed(2)} H/D',
              'Hrs_Dia_Ant':
                  '${double.parse(firstItem['ST2_Hrs_Dia_Ant']).toStringAsFixed(2)} H/D',
            });

            apiDataList.add({
              'I L1': '${firstItem['ST3_Corrien_L1']} A',
              'Volt L1-L2': '${firstItem['ST3_Tens_red_L1-L2']} V',
              'I L2': '${firstItem['ST3_Corrien_L2']} A',
              'Volt L2-L3': '${firstItem['ST3_Tens_red_L2-L3']} V',
              'I L3': '${firstItem['ST3_Corrien_L3']} A',
              'Volt L3-L1': '${firstItem['ST3_Tens_red_L3-L1']} V',
              'Pot Inst': '${firstItem['ST3_Potencia_Activa']} Kw',
              'FP': double.parse(firstItem['ST3_Factor_Potencia'])
                  .toStringAsFixed(2),
              'Energ_Act':
                  '${double.parse(firstItem['ST3_Energ_Activa']).toStringAsFixed(2)} MWh',
              'Horómetro': '${firstItem['ST3_Horometro']} H',
              'Hrs_Dia':
                  '${double.parse(firstItem['ST3_Hrs_Dia']).toStringAsFixed(2)} H/D',
              'Hrs_Dia_Ant':
                  '${double.parse(firstItem['ST3_Hrs_Dia_Ant']).toStringAsFixed(2)} H/D',
            });

            apiDataList.add({
              'I L1': '${firstItem['ST4_Corrien_L1']} A',
              'Volt L1-L2': '${firstItem['ST4_Tens_red_L1-L2']} V',
              'I L2': '${firstItem['ST4_Corrien_L2']} A',
              'Volt L2-L3': '${firstItem['ST4_Tens_red_L2-L3']} V',
              'I L3': '${firstItem['ST4_Corrien_L3']} A',
              'Volt L3-L1': '${firstItem['ST4_Tens_red_L3-L1']} V',
              'Pot Inst': '${firstItem['ST4_Potencia_Activa']} Kw',
              'FP': double.parse(firstItem['ST4_Factor_Potencia'])
                  .toStringAsFixed(2),
              'Energ_Act':
                  '${double.parse(firstItem['ST4_Energ_Activa']).toStringAsFixed(2)} MWh',
              'Horómetro': '${firstItem['ST4_Horometro']} H',
              'Hrs_Dia':
                  '${double.parse(firstItem['ST4_Hrs_Dia']).toStringAsFixed(2)} H/D',
              'Hrs_Dia_Ant':
                  '${double.parse(firstItem['ST4_Hrs_Dia_Ant']).toStringAsFixed(2)} H/D',
            });

            apiDataList.add({
              'I L1': '${firstItem['ST5_Corrien_L1']} A',
              'Volt L1-L2': '${firstItem['ST5_Tens_red_L1-L2']} V',
              'I L2': '${firstItem['ST5_Corrien_L2']} A',
              'Volt L2-L3': '${firstItem['ST5_Tens_red_L2-L3']} V',
              'I L3': '${firstItem['ST5_Corrien_L3']} A',
              'Volt L3-L1': '${firstItem['ST5_Tens_red_L3-L1']} V',
              'Pot Inst': '${firstItem['ST5_Potencia_Activa']} Kw',
              'FP': double.parse(firstItem['ST5_Factor_Potencia'])
                  .toStringAsFixed(2),
              'Energ_Act':
                  '${double.parse(firstItem['ST5_Energ_Activa']).toStringAsFixed(2)} MWh',
              'Horómetro': '${firstItem['ST5_Horometro']} H',
              'Hrs_Dia':
                  '${double.parse(firstItem['ST5_Hrs_Dia']).toStringAsFixed(2)} H/D',
              'Hrs_Dia_Ant':
                  '${double.parse(firstItem['ST5_Hrs_Dia_Ant']).toStringAsFixed(2)} H/D',
            });

            Map<String, bool> stationStatus = {
              'st1': firstItem['ST1_Status'].toLowerCase() == 'true',
              'st2': firstItem['ST2_Status'].toLowerCase() == 'true',
              'st3': firstItem['ST3_Status'].toLowerCase() == 'true',
              'st4': firstItem['ST4_Status'].toLowerCase() == 'true',
              'st5': firstItem['ST5_Status'].toLowerCase() == 'true',
            };

            ;

// Contar estaciones activas por grupo
            int activeStationsGrupo1 = 0;
            int activeStationsGrupo2 = 0;

// Contar grupo 1 (estaciones 1 y 2)
            if (stationStatus['st1'] == true) activeStationsGrupo1++;
            if (stationStatus['st2'] == true) activeStationsGrupo1++;

// Contar grupo 2 (estaciones 3, 4 y 5)
            if (stationStatus['st3'] == true) activeStationsGrupo2++;
            if (stationStatus['st4'] == true) activeStationsGrupo2++;
            if (stationStatus['st5'] == true) activeStationsGrupo2++;

// Total de estaciones activas (mantenemos esto por compatibilidad)
            int activeStations =
                stationStatus.values.where((value) => value == true).length;

// Agregar todos los datos a apiDataList
            apiDataList.add(stationStatus);
            apiDataList.add({'on': activeStations});
            apiDataList.add({'estado': activeStations > 0});
            apiDataList.add({'grupo1_activas': activeStationsGrupo1});
            apiDataList.add({'grupo2_activas': activeStationsGrupo2});
            apiDataList.add({'grupo1_estado': activeStationsGrupo1 > 0});
            apiDataList.add({'grupo2_estado': activeStationsGrupo2 > 0});

            apiDataListGral.add({
              'succion':
                  '${double.parse(itemGral['EBG1_Gral_Niv_Succ']).toStringAsFixed(2)} m',
              'descarga':
                  '${double.parse(itemGral['EBG1_Gral_Niv_Desc']).toStringAsFixed(2)} m',
              'inputsPlc': int.parse(itemGral['EBG1_Gral_Inputs_PLC']),
              'set_descarga':
                  '${double.parse(itemGral['EBG1_Gral_Stp_Niv_Desc']).toStringAsFixed(2)} m',
              // 'niv_succ_1':
              //     '${double.parse(firstItem['G1_Stp_Niv_Succ_1']).toStringAsFixed(2)} m',
              // 'niv_succ_2':
              //     '${double.parse(firstItem['G1_Stp_Niv_Succ_2']).toStringAsFixed(2)} m',
            });

            apiDataListGral.add({
              'succion':
                  '${double.parse(itemGral['EBG2_Gral_Niv_Succ']).toStringAsFixed(2)} m',
              'descarga':
                  '${double.parse(itemGral['EBG2_Gral_Niv_Desc']).toStringAsFixed(2)} m',
              'inputsPlc': int.parse(itemGral['EBG2_Gral_Inputs_PLC']),
              // 'niv_succ_1':
              //     '${double.parse(firstItem['G1_Stp_Niv_Succ_1']).toStringAsFixed(2)} m',
              // 'niv_succ_2':
              //     '${double.parse(firstItem['G1_Stp_Niv_Succ_2']).toStringAsFixed(2)} m',
            });

            apiDataListTCP.add({
              'FP': double.parse(itemTCP['EBG1_RelayVar_PF_Avg'])
                  .toStringAsFixed(2),
              // 'Temp': '${double.parse(firstItem['G1_Temp_Rap']).round()} °C',
              'THDI':
                  '${double.parse(itemTCP['EBG1_RelayVar_THDI_tot']).round()} %',
              'THDV':
                  '${double.parse(itemTCP['EBG1_RelayVar_THDV_tot']).round()} %',
              'I1': '${double.parse(itemTCP['EBG1_RelayVar_I_1']).round()} A',
              'I2': '${double.parse(itemTCP['EBG1_RelayVar_I_2']).round()} A',
              'I3': '${double.parse(itemTCP['EBG1_RelayVar_I_3']).round()} A',
              'V1': '${double.parse(itemTCP['EBG1_RelayVar_V_12']).round()} V',
              'V2': '${double.parse(itemTCP['EBG1_RelayVar_V_23']).round()} V',
              'V3': '${double.parse(itemTCP['EBG1_RelayVar_V_31']).round()} V',
              'Pot Inst':
                  '${double.parse(itemTCP['EBG1_RelayVar_P_Total']).round()} Kw',
              'Energ_Act':
                  '${double.parse(itemTCP['EBG1_RelayVar_T1_Imp_Act_Index']).round()} MWh',
              // 'Alarm2': itemTCP['G1_Alarm2'],
            });

            apiDataListTCP.add({
              'FP': double.parse(itemTCP['EBG2_RelayVar_PF_Avg'])
                  .toStringAsFixed(2),
              // 'Temp': '${double.parse(firstItem['G1_Temp_Rap']).round()} °C',
              'THDI':
                  '${double.parse(itemTCP['EBG2_RelayVar_THDI_tot']).round()} %',
              'THDV':
                  '${double.parse(itemTCP['EBG2_RelayVar_THDV_tot']).round()} %',
              'I1': '${double.parse(itemTCP['EBG2_RelayVar_I_1']).round()} A',
              'I2': '${double.parse(itemTCP['EBG2_RelayVar_I_2']).round()} A',
              'I3': '${double.parse(itemTCP['EBG2_RelayVar_I_3']).round()} A',
              'V1': '${double.parse(itemTCP['EBG2_RelayVar_V_12']).round()} V',
              'V2': '${double.parse(itemTCP['EBG2_RelayVar_V_23']).round()} V',
              'V3': '${double.parse(itemTCP['EBG2_RelayVar_V_31']).round()} V',
              // 'Pot Inst': '${itemTCP['EBG2_RelayVar_P_Total']} Kw',
              'Pot_Inst':
                  '${double.parse(itemTCP['EBG2_RelayVar_P_Total']).round()} KW',

              'Energ_Act':
                  '${double.parse(itemTCP['EBG2_RelayVar_T1_Imp_Act_Index']).round()} MWh',
              // 'Alarm2': itemTCP['G1_Alarm2'],
            });

            apiDataListAntenas.add({
              'Pot_PTP-T1': int.parse(itemAntenas['Pot_PTP-T1']),
              // 'Pot_AP1-B': int.parse(itemAntenas['Pot_AP1-B']),
              // 'Pot_Camp-PTP-Mari': int.parse(itemAntenas['Pot_Camp-PTP-Mari']),
              'Pot_EB_G1': int.parse(itemAntenas['Pot_EB_G1']),
              'Pot_PTP-Camp-T1': int.parse(itemAntenas['Pot_PTP-Camp-T1']),
              // 'Pot_PTP-Camp-T2': int.parse(itemAntenas['Pot_PTP-Camp-T2']),
              'Pot_PTP-Camp-T3': int.parse(itemAntenas['Pot_PTP-Camp-T3']),
              // 'Pot_PTP-Mari': int.parse(itemAntenas['Pot_PTP-Mari']),
              // 'Pot_PTP-T2': int.parse(itemAntenas['Pot_PTP-T2']),
              'Pot_PTP-T3': int.parse(itemAntenas['Pot_PTP-T3']),
              'Pot-AP1': int.parse(itemAntenas['Pot-AP1']),
              // 'Pot-AP2': int.parse(itemAntenas['Pot-AP2']),
              'Pot-AP3': int.parse(itemAntenas['Pot-AP3']),
              'Stat_PTP-Camp-T3':
                  itemAntenas['Stat_PTP-Camp-T3'].toLowerCase() == 'true',
              // 'Stat_PTP-Mari':
              // itemAntenas['Stat_PTP-Mari'].toLowerCase() == 'true',
              'Stat_AP1': itemAntenas['Stat_AP1'].toLowerCase() == 'true',
              // 'Stat_AP1-B': itemAntenas['Stat_AP1-B'].toLowerCase() == 'true',
              // 'Stat_AP2': itemAntenas['Stat_AP2'].toLowerCase() == 'true',
              'Stat_AP3': itemAntenas['Stat_AP3'].toLowerCase() == 'true',
              'Stat_Camp-PTP-Mari':
                  itemAntenas['Stat_Camp-PTP-Mari'].toLowerCase() == 'true',
              'Stat_PTP-T1': itemAntenas['Stat_PTP-T1'].toLowerCase() == 'true',
              // 'Stat_PTP-T2': itemAntenas['Stat_PTP-T2'].toLowerCase() == 'true',
              'Stat_PTP-T3': itemAntenas['Stat_PTP-T3'].toLowerCase() == 'true',
              'Stat_EB_G1': itemAntenas['Stat_EB_G1'].toLowerCase() == 'true',
              'Stat_PTP-Camp-T1':
                  itemAntenas['Stat_PTP-Camp-T1'].toLowerCase() == 'true',
              // 'Stat_PTP-Camp-T2':
              //     itemAntenas['Stat_PTP-Camp-T2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListEBFJOS.addAll([
                apiDataList,
                apiDataListGral,
                apiDataListTCP,
                apiDataListAntenas
              ]);
            }

            print(_apiDataListEBFJOS[1][1]);

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListEBFJOS)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC20() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC20');
    notifyListeners();

    if (subscriptionPC20 == null) {
      _apiDataListPC20.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC20 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC20')) {
            dynamic firstItem = decodedEvent['PC20'][0];
            dynamic itemTCP = decodedEvent['PC20TCP'][0];
            dynamic itemAntenas = decodedEvent['PC20Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_20_01.Inputs': int.parse(itemTCP['TA_20_01.Inputs']),
              'TA_20_01.Outputs': int.parse(itemTCP['TA_20_01.Outputs']),
              'TA_20_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_20_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_20_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_20_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_20_01.Stat_Comm_MB':
                  itemTCP['TA_20_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_20_01.Stat_Comm':
                  itemTCP['TA_20_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_20_01.V_Avg':
                  double.parse(itemTCP['TA_20_01.V_Avg']).toStringAsFixed(2),
              'TA_20_01.I_Tot':
                  double.parse(itemTCP['TA_20_01.I_Tot']).toStringAsFixed(2),
              'TA_20_01.P_Tot':
                  double.parse(itemTCP['TA_20_01.P_Tot']).toStringAsFixed(2),
              'TA_20_01.PF_Avg':
                  double.parse(itemTCP['TA_20_01.PF_Avg']).toStringAsFixed(2),
              'TA_20_01.V_12':
                  double.parse(itemTCP['TA_20_01.V_12']).toStringAsFixed(2),
              'TA_20_01.V_23':
                  double.parse(itemTCP['TA_20_01.V_23']).toStringAsFixed(2),
              'TA_20_01.V_31':
                  double.parse(itemTCP['TA_20_01.V_31']).toStringAsFixed(2),
              'TA_20_01.VLL_Avg':
                  double.parse(itemTCP['TA_20_01.VLL_Avg']).toStringAsFixed(2),
              'TA_20_01.THDV_tot':
                  double.parse(itemTCP['TA_20_01.THDV_tot']).toStringAsFixed(2),
              'TA_20_01.THDI_tot':
                  double.parse(itemTCP['TA_20_01.THDI_tot']).toStringAsFixed(2),
              'TA_20_01.V_1':
                  double.parse(itemTCP['TA_20_01.V_1']).toStringAsFixed(2),
              'TA_20_01.I_1':
                  double.parse(itemTCP['TA_20_01.I_1']).toStringAsFixed(2),
              'TA_20_01.V_2':
                  double.parse(itemTCP['TA_20_01.V_2']).toStringAsFixed(2),
              'TA_20_01.I_2':
                  double.parse(itemTCP['TA_20_01.I_2']).toStringAsFixed(2),
              'TA_20_01.V_3':
                  double.parse(itemTCP['TA_20_01.V_3']).toStringAsFixed(2),
              'TA_20_01.I_3':
                  double.parse(itemTCP['TA_20_01.I_3']).toStringAsFixed(2),
              'TA_20_01.Alarm1': int.parse(itemTCP['TA_20_01.Alarm1']),
              'TA_20_01.Alarm2': int.parse(itemTCP['TA_20_01.Alarm2']),
              'TA_20_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_20_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA20-1': int.parse(itemAntenas['Pot_TA20-1']),
              'Stat_TA20-1': itemAntenas['Stat_TA20-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC20
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC20)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC101() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC101');
    notifyListeners();

    if (subscriptionPC101 == null) {
      _apiDataListPC101.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC101 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC101')) {
            dynamic firstItem = decodedEvent['PC101'][0];
            dynamic itemTCP = decodedEvent['PC101TCP'][0];
            dynamic itemAntenas = decodedEvent['PC101Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto'] ?? '0'),
              'Num_Air_On': int.parse(firstItem['Num_Air_On'] ?? '0'),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem'] ?? '0').round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act'] ?? '0').round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act'] ?? '0').round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas'] ?? '0').round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index'] ?? '0').round(),
              'Pot_Inst':
                  '${double.parse(firstItem['Pot_Inst'] ?? '0').round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver'] ?? '0'),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On':
                  firstItem['Algun_Air_On']?.toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem']?.toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora']?.toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              'TA_101_01.Inputs': int.parse(itemTCP['TA_101_01.Inputs'] ?? '0'),
              'TA_101_01.Outputs':
                  int.parse(itemTCP['TA_101_01.Outputs'] ?? '0'),
              'TA_101_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_101_01.Horas_Trab_Act'] ?? '0')
                      .toStringAsFixed(2),
              'TA_101_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_101_01.Horas_Trab_Guar'] ?? '0')
                      .toStringAsFixed(2),
              'TA_101_01.Stat_Comm_MB':
                  itemTCP['TA_101_01.Stat_Comm_MB']?.toLowerCase() == 'true',
              'TA_101_01.Stat_Comm':
                  itemTCP['TA_101_01.Stat_Comm']?.toLowerCase() == 'true',
              'TA_101_01.V_Avg': double.parse(itemTCP['TA_101_01.V_Avg'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.I_Tot': double.parse(itemTCP['TA_101_01.I_Tot'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.P_Tot': double.parse(itemTCP['TA_101_01.P_Tot'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.PF_Avg':
                  double.parse(itemTCP['TA_101_01.PF_Avg'] ?? '0')
                      .toStringAsFixed(2),
              'TA_101_01.V_12': double.parse(itemTCP['TA_101_01.V_12'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.V_23': double.parse(itemTCP['TA_101_01.V_23'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.V_31': double.parse(itemTCP['TA_101_01.V_31'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.VLL_Avg':
                  double.parse(itemTCP['TA_101_01.VLL_Avg'] ?? '0')
                      .toStringAsFixed(2),
              'TA_101_01.THDV_tot':
                  double.parse(itemTCP['TA_101_01.THDV_tot'] ?? '0')
                      .toStringAsFixed(2),
              'TA_101_01.THDI_tot':
                  double.parse(itemTCP['TA_101_01.THDI_tot'] ?? '0')
                      .toStringAsFixed(2),
              'TA_101_01.V_1': double.parse(itemTCP['TA_101_01.V_1'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.I_1': double.parse(itemTCP['TA_101_01.I_1'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.V_2': double.parse(itemTCP['TA_101_01.V_2'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.I_2': double.parse(itemTCP['TA_101_01.I_2'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.V_3': double.parse(itemTCP['TA_101_01.V_3'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.I_3': double.parse(itemTCP['TA_101_01.I_3'] ?? '0')
                  .toStringAsFixed(2),
              'TA_101_01.Alarm1': int.parse(itemTCP['TA_101_01.Alarm1'] ?? '0'),
              'TA_101_01.Alarm2': int.parse(itemTCP['TA_101_01.Alarm2'] ?? '0'),
              'TA_101_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_101_01.T1_Imp_Act_Index'] ?? '0')
                      .toStringAsFixed(2),
            });

            apiDataListAntenas.add({
              'Pot_TA101-1': int.parse(itemAntenas['Pot_TA101-1'] ?? '0'),
              'Stat_TA101-1':
                  itemAntenas['Stat_TA101-1']?.toLowerCase() == 'true',
            });

            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC101
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC101)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      }
    }
  }

  void subscribePC102() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC102');
    notifyListeners();

    if (subscriptionPC102 == null) {
      _apiDataListPC102.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC102 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC102')) {
            dynamic firstItem = decodedEvent['PC102'][0];
            dynamic itemTCP = decodedEvent['PC102TCP'][0];
            dynamic itemAntenas = decodedEvent['PC102Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_102_01.Inputs': int.parse(itemTCP['TA_102_01.Inputs']),
              'TA_102_01.Outputs': int.parse(itemTCP['TA_102_01.Outputs']),
              'TA_102_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_102_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_102_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_102_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_102_01.Stat_Comm_MB':
                  itemTCP['TA_102_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_102_01.Stat_Comm':
                  itemTCP['TA_102_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_102_01.V_Avg':
                  double.parse(itemTCP['TA_102_01.V_Avg']).toStringAsFixed(2),
              'TA_102_01.I_Tot':
                  double.parse(itemTCP['TA_102_01.I_Tot']).toStringAsFixed(2),
              'TA_102_01.P_Tot':
                  double.parse(itemTCP['TA_102_01.P_Tot']).toStringAsFixed(2),
              'TA_102_01.PF_Avg':
                  double.parse(itemTCP['TA_102_01.PF_Avg']).toStringAsFixed(2),
              'TA_102_01.V_12':
                  double.parse(itemTCP['TA_102_01.V_12']).toStringAsFixed(2),
              'TA_102_01.V_23':
                  double.parse(itemTCP['TA_102_01.V_23']).toStringAsFixed(2),
              'TA_102_01.V_31':
                  double.parse(itemTCP['TA_102_01.V_31']).toStringAsFixed(2),
              'TA_102_01.VLL_Avg':
                  double.parse(itemTCP['TA_102_01.VLL_Avg']).toStringAsFixed(2),
              'TA_102_01.THDV_tot': double.parse(itemTCP['TA_102_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_102_01.THDI_tot': double.parse(itemTCP['TA_102_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_102_01.V_1':
                  double.parse(itemTCP['TA_102_01.V_1']).toStringAsFixed(2),
              'TA_102_01.I_1':
                  double.parse(itemTCP['TA_102_01.I_1']).toStringAsFixed(2),
              'TA_102_01.V_2':
                  double.parse(itemTCP['TA_102_01.V_2']).toStringAsFixed(2),
              'TA_102_01.I_2':
                  double.parse(itemTCP['TA_102_01.I_2']).toStringAsFixed(2),
              'TA_102_01.V_3':
                  double.parse(itemTCP['TA_102_01.V_3']).toStringAsFixed(2),
              'TA_102_01.I_3':
                  double.parse(itemTCP['TA_102_01.I_3']).toStringAsFixed(2),
              'TA_102_01.Alarm1': int.parse(itemTCP['TA_102_01.Alarm1']),
              'TA_102_01.Alarm2': int.parse(itemTCP['TA_102_01.Alarm2']),
              'TA_102_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_102_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA102-1': int.parse(itemAntenas['Pot_TA102-1']),
              'Stat_TA102-1':
                  itemAntenas['Stat_TA102-1'].toLowerCase() == 'true',
            });
            _apiDataListPC102
                .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);

            isLoading2 = false; // Finalizar el estado de cargando

            // print(isLoading2);
            // print(_apiDataListPS01);
            notifyListeners();
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC103() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC103');
    notifyListeners();

    if (subscriptionPC103 == null) {
      _apiDataListPC103.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC103 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC103')) {
            dynamic firstItem = decodedEvent['PC103'][0];
            dynamic itemTCP = decodedEvent['PC103TCP'][0];
            dynamic itemAntenas = decodedEvent['PC103Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_103_01.Inputs': int.parse(itemTCP['TA_103_01.Inputs']),
              'TA_103_01.Outputs': int.parse(itemTCP['TA_103_01.Outputs']),
              'TA_103_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_103_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_103_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_103_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_103_01.Stat_Comm_MB':
                  itemTCP['TA_103_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_103_01.Stat_Comm':
                  itemTCP['TA_103_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_103_01.V_Avg':
                  double.parse(itemTCP['TA_103_01.V_Avg']).toStringAsFixed(2),
              'TA_103_01.I_Tot':
                  double.parse(itemTCP['TA_103_01.I_Tot']).toStringAsFixed(2),
              'TA_103_01.P_Tot':
                  double.parse(itemTCP['TA_103_01.P_Tot']).toStringAsFixed(2),
              'TA_103_01.PF_Avg':
                  double.parse(itemTCP['TA_103_01.PF_Avg']).toStringAsFixed(2),
              'TA_103_01.V_12':
                  double.parse(itemTCP['TA_103_01.V_12']).toStringAsFixed(2),
              'TA_103_01.V_23':
                  double.parse(itemTCP['TA_103_01.V_23']).toStringAsFixed(2),
              'TA_103_01.V_31':
                  double.parse(itemTCP['TA_103_01.V_31']).toStringAsFixed(2),
              'TA_103_01.VLL_Avg':
                  double.parse(itemTCP['TA_103_01.VLL_Avg']).toStringAsFixed(2),
              'TA_103_01.THDV_tot': double.parse(itemTCP['TA_103_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_103_01.THDI_tot': double.parse(itemTCP['TA_103_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_103_01.V_1':
                  double.parse(itemTCP['TA_103_01.V_1']).toStringAsFixed(2),
              'TA_103_01.I_1':
                  double.parse(itemTCP['TA_103_01.I_1']).toStringAsFixed(2),
              'TA_103_01.V_2':
                  double.parse(itemTCP['TA_103_01.V_2']).toStringAsFixed(2),
              'TA_103_01.I_2':
                  double.parse(itemTCP['TA_103_01.I_2']).toStringAsFixed(2),
              'TA_103_01.V_3':
                  double.parse(itemTCP['TA_103_01.V_3']).toStringAsFixed(2),
              'TA_103_01.I_3':
                  double.parse(itemTCP['TA_103_01.I_3']).toStringAsFixed(2),
              'TA_103_01.Alarm1': int.parse(itemTCP['TA_103_01.Alarm1']),
              'TA_103_01.Alarm2': int.parse(itemTCP['TA_103_01.Alarm2']),
              'TA_103_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_103_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA103-1': int.parse(itemAntenas['Pot_TA103-1']),
              'Stat_TA103-1':
                  itemAntenas['Stat_TA103-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC103
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC103)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC104() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC104');
    notifyListeners();

    if (subscriptionPC104 == null) {
      _apiDataListPC104.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC104 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC104')) {
            dynamic firstItem = decodedEvent['PC104'][0];
            dynamic itemTCP = decodedEvent['PC104TCP'][0];
            dynamic itemAntenas = decodedEvent['PC104Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_104_01.Inputs': int.parse(itemTCP['TA_104_01.Inputs']),
              'TA_104_01.Outputs': int.parse(itemTCP['TA_104_01.Outputs']),
              'TA_104_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_104_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_104_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_104_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_104_01.Stat_Comm_MB':
                  itemTCP['TA_104_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_104_01.Stat_Comm':
                  itemTCP['TA_104_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_104_01.V_Avg':
                  double.parse(itemTCP['TA_104_01.V_Avg']).toStringAsFixed(2),
              'TA_104_01.I_Tot':
                  double.parse(itemTCP['TA_104_01.I_Tot']).toStringAsFixed(2),
              'TA_104_01.P_Tot':
                  double.parse(itemTCP['TA_104_01.P_Tot']).toStringAsFixed(2),
              'TA_104_01.PF_Avg':
                  double.parse(itemTCP['TA_104_01.PF_Avg']).toStringAsFixed(2),
              'TA_104_01.V_12':
                  double.parse(itemTCP['TA_104_01.V_12']).toStringAsFixed(2),
              'TA_104_01.V_23':
                  double.parse(itemTCP['TA_104_01.V_23']).toStringAsFixed(2),
              'TA_104_01.V_31':
                  double.parse(itemTCP['TA_104_01.V_31']).toStringAsFixed(2),
              'TA_104_01.VLL_Avg':
                  double.parse(itemTCP['TA_104_01.VLL_Avg']).toStringAsFixed(2),
              'TA_104_01.THDV_tot': double.parse(itemTCP['TA_104_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_104_01.THDI_tot': double.parse(itemTCP['TA_104_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_104_01.V_1':
                  double.parse(itemTCP['TA_104_01.V_1']).toStringAsFixed(2),
              'TA_104_01.I_1':
                  double.parse(itemTCP['TA_104_01.I_1']).toStringAsFixed(2),
              'TA_104_01.V_2':
                  double.parse(itemTCP['TA_104_01.V_2']).toStringAsFixed(2),
              'TA_104_01.I_2':
                  double.parse(itemTCP['TA_104_01.I_2']).toStringAsFixed(2),
              'TA_104_01.V_3':
                  double.parse(itemTCP['TA_104_01.V_3']).toStringAsFixed(2),
              'TA_104_01.I_3':
                  double.parse(itemTCP['TA_104_01.I_3']).toStringAsFixed(2),
              'TA_104_01.Alarm1': int.parse(itemTCP['TA_104_01.Alarm1']),
              'TA_104_01.Alarm2': int.parse(itemTCP['TA_104_01.Alarm2']),
              'TA_104_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_104_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA104-1': int.parse(itemAntenas['Pot_TA104-1']),
              'Stat_TA104-1':
                  itemAntenas['Stat_TA104-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC104
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC104)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC106() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC106');
    notifyListeners();

    if (subscriptionPC106 == null) {
      _apiDataListPC106.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC106 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC106')) {
            dynamic firstItem = decodedEvent['PC106'][0];
            dynamic itemTCP = decodedEvent['PC106TCP'][0];
            dynamic itemAntenas = decodedEvent['PC106Antenas'][0];

            // Validar que los items no sean nulos
            if (firstItem != null && itemTCP != null && itemAntenas != null) {
              // Validar la existencia de las claves antes de acceder a los valores
              apiDataList.add({
                'Num_Auto': firstItem.containsKey('Num_Auto')
                    ? int.tryParse(firstItem['Num_Auto'] ?? '') ?? 0
                    : 0,
                'Num_Air_On': firstItem.containsKey('Num_Air_On')
                    ? int.tryParse(firstItem['Num_Air_On'] ?? '') ?? 0
                    : 0,
                'Hrs_Trab_Sem': firstItem.containsKey('Hrs_Trab_Sem')
                    ? '${double.tryParse(firstItem['Hrs_Trab_Sem'] ?? '')?.round() ?? 0} H/Sem'
                    : '0 H/Sem',
                'Hrs_Trab_Act': firstItem.containsKey('Hrs_Trab_Act')
                    ? '${double.tryParse(firstItem['Hrs_Trab_Act'] ?? '')?.round() ?? 0} H/Sem'
                    : '0 H/Sem',
                'Ener_Mes_Act': firstItem.containsKey('Ener_Mes_Act')
                    ? '${double.tryParse(firstItem['Ener_Mes_Act'] ?? '')?.round() ?? 0} KWh/M'
                    : '0 KWh/M',
                'Ener_Mes_Pas': firstItem.containsKey('Ener_Mes_Pas')
                    ? '${double.tryParse(firstItem['Ener_Mes_Pas'] ?? '')?.round() ?? 0} KWh/M'
                    : '0 KWh/M',
                'Ener_Total_Index': firstItem.containsKey('Ener_Total_Index')
                    ? double.tryParse(firstItem['Ener_Total_Index'] ?? '')
                            ?.round() ??
                        0
                    : 0,
                'Pot_Inst': firstItem.containsKey('Pot_Inst')
                    ? '${double.tryParse(firstItem['Pot_Inst'] ?? '')?.round() ?? 0} KW'
                    : '0 KW',
                'Alarm_Adver': firstItem.containsKey('Alarm_Adver')
                    ? int.tryParse(firstItem['Alarm_Adver'] ?? '') ?? 0
                    : 0,
                'Hora_Ini_1': firstItem.containsKey('Hora_Ini_1')
                    ? firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00'
                    : '00:00:00',
                'Hora_Ini_2': firstItem.containsKey('Hora_Ini_2')
                    ? firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00'
                    : '00:00:00',
                'Hora_Fin_1': firstItem.containsKey('Hora_Fin_1')
                    ? firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00'
                    : '00:00:00',
                'Hora_Fin_2': firstItem.containsKey('Hora_Fin_2')
                    ? firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00'
                    : '00:00:00',
                'Algun_Air_On': firstItem.containsKey('Algun_Air_On')
                    ? firstItem['Algun_Air_On']?.toLowerCase() == 'true'
                    : false,
                'Run_Rem': firstItem.containsKey('Run_Rem')
                    ? firstItem['Run_Rem']?.toLowerCase() == 'true'
                    : false,
                'Bloq_Auto_Hora': firstItem.containsKey('Bloq_Auto_Hora')
                    ? firstItem['Bloq_Auto_Hora']?.toLowerCase() == 'true'
                    : false,
              });

              apiDataListTCP.add({
                'TA_106_01.Inputs': itemTCP.containsKey('TA_106_01.Inputs')
                    ? int.tryParse(itemTCP['TA_106_01.Inputs'] ?? '') ?? 0
                    : 0,
                'TA_106_01.Outputs': itemTCP.containsKey('TA_106_01.Outputs')
                    ? int.tryParse(itemTCP['TA_106_01.Outputs'] ?? '') ?? 0
                    : 0,
                'TA_106_01.Horas_Trab_Act': itemTCP
                        .containsKey('TA_106_01.Horas_Trab_Act')
                    ? double.tryParse(itemTCP['TA_106_01.Horas_Trab_Act'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.Horas_Trab_Guar':
                    itemTCP.containsKey('TA_106_01.Horas_Trab_Guar')
                        ? double.tryParse(
                                    itemTCP['TA_106_01.Horas_Trab_Guar'] ?? '')
                                ?.toStringAsFixed(2) ??
                            '0.00'
                        : '0.00',
                'TA_106_01.Stat_Comm_MB':
                    itemTCP['TA_106_01.Stat_Comm_MB']?.toLowerCase() == 'true',
                'TA_106_01.Stat_Comm': itemTCP
                        .containsKey('TA_106_01.Stat_Comm')
                    ? itemTCP['TA_106_01.Stat_Comm']?.toLowerCase() == 'true'
                    : false,
                'TA_106_01.V_Avg': itemTCP.containsKey('TA_106_01.V_Avg')
                    ? double.tryParse(itemTCP['TA_106_01.V_Avg'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.I_Tot': itemTCP.containsKey('TA_106_01.I_Tot')
                    ? double.tryParse(itemTCP['TA_106_01.I_Tot'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.P_Tot': itemTCP.containsKey('TA_106_01.P_Tot')
                    ? double.tryParse(itemTCP['TA_106_01.P_Tot'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.PF_Avg': itemTCP.containsKey('TA_106_01.PF_Avg')
                    ? double.tryParse(itemTCP['TA_106_01.PF_Avg'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.V_12': itemTCP.containsKey('TA_106_01.V_12')
                    ? double.tryParse(itemTCP['TA_106_01.V_12'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.V_23': itemTCP.containsKey('TA_106_01.V_23')
                    ? double.tryParse(itemTCP['TA_106_01.V_23'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.V_31': itemTCP.containsKey('TA_106_01.V_31')
                    ? double.tryParse(itemTCP['TA_106_01.V_31'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.VLL_Avg': itemTCP.containsKey('TA_106_01.VLL_Avg')
                    ? double.tryParse(itemTCP['TA_106_01.VLL_Avg'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.THDV_tot': itemTCP.containsKey('TA_106_01.THDV_tot')
                    ? double.tryParse(itemTCP['TA_106_01.THDV_tot'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.THDI_tot': itemTCP.containsKey('TA_106_01.THDI_tot')
                    ? double.tryParse(itemTCP['TA_106_01.THDI_tot'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.V_1': itemTCP.containsKey('TA_106_01.V_1')
                    ? double.tryParse(itemTCP['TA_106_01.V_1'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.I_1': itemTCP.containsKey('TA_106_01.I_1')
                    ? double.tryParse(itemTCP['TA_106_01.I_1'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.V_2': itemTCP.containsKey('TA_106_01.V_2')
                    ? double.tryParse(itemTCP['TA_106_01.V_2'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.I_2': itemTCP.containsKey('TA_106_01.I_2')
                    ? double.tryParse(itemTCP['TA_106_01.I_2'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.V_3': itemTCP.containsKey('TA_106_01.V_3')
                    ? double.tryParse(itemTCP['TA_106_01.V_3'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.I_3': itemTCP.containsKey('TA_106_01.I_3')
                    ? double.tryParse(itemTCP['TA_106_01.I_3'] ?? '')
                            ?.toStringAsFixed(2) ??
                        '0.00'
                    : '0.00',
                'TA_106_01.Alarm1': itemTCP.containsKey('TA_106_01.Alarm1')
                    ? int.tryParse(itemTCP['TA_106_01.Alarm1'] ?? '') ?? 0
                    : 0,
                'TA_106_01.Alarm2': itemTCP.containsKey('TA_106_01.Alarm2')
                    ? int.tryParse(itemTCP['TA_106_01.Alarm2'] ?? '') ?? 0
                    : 0,
                'TA_106_01.T1_Imp_Act_Index':
                    itemTCP.containsKey('TA_106_01.T1_Imp_Act_Index')
                        ? double.tryParse(
                                    itemTCP['TA_106_01.T1_Imp_Act_Index'] ?? '')
                                ?.toStringAsFixed(2) ??
                            '0.00'
                        : '0.00',
              });

              apiDataListAntenas.add({
                'Pot_TA106-1': itemAntenas.containsKey('Pot_TA106-1')
                    ? int.tryParse(itemAntenas['Pot_TA106-1'] ?? '') ?? 0
                    : 0,
                'Stat_TA106-1': itemAntenas.containsKey('Stat_TA106-1')
                    ? itemAntenas['Stat_TA106-1']?.toLowerCase() == 'true'
                    : false,
              });

              // Solo agregar los datos a la lista si todas las validaciones son exitosas
              if (apiDataList.isNotEmpty &&
                  apiDataListTCP.isNotEmpty &&
                  apiDataListAntenas.isNotEmpty) {
                _apiDataListPC106
                    .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
              }

              // _apiDataListPC106
              //     .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);

              // print(_apiDataListPC106);

              isLoading2 = false; // Finalizar el estado de cargando
              if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC106)) {
                notifyListeners();
              }
            } else {
              print('Datos incompletos para PC106. Ignorando actualización.');
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC107() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC107');
    notifyListeners();

    if (subscriptionPC107 == null) {
      _apiDataListPC107.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC107 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC107')) {
            dynamic firstItem = decodedEvent['PC107'][0];
            dynamic itemTCP = decodedEvent['PC107TCP'][0];
            dynamic itemAntenas = decodedEvent['PC107Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_107_01.Inputs': int.parse(itemTCP['TA_107_01.Inputs']),
              'TA_107_01.Outputs': int.parse(itemTCP['TA_107_01.Outputs']),
              'TA_107_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_107_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_107_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_107_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_107_01.Stat_Comm_MB':
                  itemTCP['TA_107_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_107_01.Stat_Comm':
                  itemTCP['TA_107_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_107_01.V_Avg':
                  double.parse(itemTCP['TA_107_01.V_Avg']).toStringAsFixed(2),
              'TA_107_01.I_Tot':
                  double.parse(itemTCP['TA_107_01.I_Tot']).toStringAsFixed(2),
              'TA_107_01.P_Tot':
                  double.parse(itemTCP['TA_107_01.P_Tot']).toStringAsFixed(2),
              'TA_107_01.PF_Avg':
                  double.parse(itemTCP['TA_107_01.PF_Avg']).toStringAsFixed(2),
              'TA_107_01.V_12':
                  double.parse(itemTCP['TA_107_01.V_12']).toStringAsFixed(2),
              'TA_107_01.V_23':
                  double.parse(itemTCP['TA_107_01.V_23']).toStringAsFixed(2),
              'TA_107_01.V_31':
                  double.parse(itemTCP['TA_107_01.V_31']).toStringAsFixed(2),
              'TA_107_01.VLL_Avg':
                  double.parse(itemTCP['TA_107_01.VLL_Avg']).toStringAsFixed(2),
              'TA_107_01.THDV_tot': double.parse(itemTCP['TA_107_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_107_01.THDI_tot': double.parse(itemTCP['TA_107_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_107_01.V_1':
                  double.parse(itemTCP['TA_107_01.V_1']).toStringAsFixed(2),
              'TA_107_01.I_1':
                  double.parse(itemTCP['TA_107_01.I_1']).toStringAsFixed(2),
              'TA_107_01.V_2':
                  double.parse(itemTCP['TA_107_01.V_2']).toStringAsFixed(2),
              'TA_107_01.I_2':
                  double.parse(itemTCP['TA_107_01.I_2']).toStringAsFixed(2),
              'TA_107_01.V_3':
                  double.parse(itemTCP['TA_107_01.V_3']).toStringAsFixed(2),
              'TA_107_01.I_3':
                  double.parse(itemTCP['TA_107_01.I_3']).toStringAsFixed(2),
              'TA_107_01.Alarm1': int.parse(itemTCP['TA_107_01.Alarm1']),
              'TA_107_01.Alarm2': int.parse(itemTCP['TA_107_01.Alarm2']),
              'TA_107_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_107_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA107-1': int.parse(itemAntenas['Pot_TA107-1']),
              'Stat_TA107-1':
                  itemAntenas['Stat_TA107-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC107
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC107)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC108() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC108');
    notifyListeners();

    if (subscriptionPC108 == null) {
      _apiDataListPC108.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC108 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC108')) {
            dynamic firstItem = decodedEvent['PC108'][0];
            dynamic itemTCP = decodedEvent['PC108TCP'][0];
            dynamic itemAntenas = decodedEvent['PC108Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_108_01.Inputs': int.parse(itemTCP['TA_108_01.Inputs']),
              'TA_108_01.Outputs': int.parse(itemTCP['TA_108_01.Outputs']),
              'TA_108_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_108_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_108_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_108_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_108_01.Stat_Comm_MB':
                  itemTCP['TA_108_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_108_01.Stat_Comm':
                  itemTCP['TA_108_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_108_01.V_Avg':
                  double.parse(itemTCP['TA_108_01.V_Avg']).toStringAsFixed(2),
              'TA_108_01.I_Tot':
                  double.parse(itemTCP['TA_108_01.I_Tot']).toStringAsFixed(2),
              'TA_108_01.P_Tot':
                  double.parse(itemTCP['TA_108_01.P_Tot']).toStringAsFixed(2),
              'TA_108_01.PF_Avg':
                  double.parse(itemTCP['TA_108_01.PF_Avg']).toStringAsFixed(2),
              'TA_108_01.V_12':
                  double.parse(itemTCP['TA_108_01.V_12']).toStringAsFixed(2),
              'TA_108_01.V_23':
                  double.parse(itemTCP['TA_108_01.V_23']).toStringAsFixed(2),
              'TA_108_01.V_31':
                  double.parse(itemTCP['TA_108_01.V_31']).toStringAsFixed(2),
              'TA_108_01.VLL_Avg':
                  double.parse(itemTCP['TA_108_01.VLL_Avg']).toStringAsFixed(2),
              'TA_108_01.THDV_tot': double.parse(itemTCP['TA_108_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_108_01.THDI_tot': double.parse(itemTCP['TA_108_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_108_01.V_1':
                  double.parse(itemTCP['TA_108_01.V_1']).toStringAsFixed(2),
              'TA_108_01.I_1':
                  double.parse(itemTCP['TA_108_01.I_1']).toStringAsFixed(2),
              'TA_108_01.V_2':
                  double.parse(itemTCP['TA_108_01.V_2']).toStringAsFixed(2),
              'TA_108_01.I_2':
                  double.parse(itemTCP['TA_108_01.I_2']).toStringAsFixed(2),
              'TA_108_01.V_3':
                  double.parse(itemTCP['TA_108_01.V_3']).toStringAsFixed(2),
              'TA_108_01.I_3':
                  double.parse(itemTCP['TA_108_01.I_3']).toStringAsFixed(2),
              'TA_108_01.Alarm1': int.parse(itemTCP['TA_108_01.Alarm1']),
              'TA_108_01.Alarm2': int.parse(itemTCP['TA_108_01.Alarm2']),
              'TA_108_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_108_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA108-1': int.parse(itemAntenas['Pot_TA108-1']),
              'Stat_TA108-1':
                  itemAntenas['Stat_TA108-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC108
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC108)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC111() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC111');
    notifyListeners();

    if (subscriptionPC111 == null) {
      _apiDataListPC111.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC111 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC111')) {
            dynamic firstItem = decodedEvent['PC111'][0];
            dynamic itemTCP = decodedEvent['PC111TCP'][0];
            dynamic itemAntenas = decodedEvent['PC111Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_111_01.Inputs': int.parse(itemTCP['TA_111_01.Inputs']),
              'TA_111_01.Outputs': int.parse(itemTCP['TA_111_01.Outputs']),
              'TA_111_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_111_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_111_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_111_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_111_01.Stat_Comm_MB':
                  itemTCP['TA_111_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_111_01.Stat_Comm':
                  itemTCP['TA_111_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_111_01.V_Avg':
                  double.parse(itemTCP['TA_111_01.V_Avg']).toStringAsFixed(2),
              'TA_111_01.I_Tot':
                  double.parse(itemTCP['TA_111_01.I_Tot']).toStringAsFixed(2),
              'TA_111_01.P_Tot':
                  double.parse(itemTCP['TA_111_01.P_Tot']).toStringAsFixed(2),
              'TA_111_01.PF_Avg':
                  double.parse(itemTCP['TA_111_01.PF_Avg']).toStringAsFixed(2),
              'TA_111_01.V_12':
                  double.parse(itemTCP['TA_111_01.V_12']).toStringAsFixed(2),
              'TA_111_01.V_23':
                  double.parse(itemTCP['TA_111_01.V_23']).toStringAsFixed(2),
              'TA_111_01.V_31':
                  double.parse(itemTCP['TA_111_01.V_31']).toStringAsFixed(2),
              'TA_111_01.VLL_Avg':
                  double.parse(itemTCP['TA_111_01.VLL_Avg']).toStringAsFixed(2),
              'TA_111_01.THDV_tot': double.parse(itemTCP['TA_111_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_111_01.THDI_tot': double.parse(itemTCP['TA_111_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_111_01.V_1':
                  double.parse(itemTCP['TA_111_01.V_1']).toStringAsFixed(2),
              'TA_111_01.I_1':
                  double.parse(itemTCP['TA_111_01.I_1']).toStringAsFixed(2),
              'TA_111_01.V_2':
                  double.parse(itemTCP['TA_111_01.V_2']).toStringAsFixed(2),
              'TA_111_01.I_2':
                  double.parse(itemTCP['TA_111_01.I_2']).toStringAsFixed(2),
              'TA_111_01.V_3':
                  double.parse(itemTCP['TA_111_01.V_3']).toStringAsFixed(2),
              'TA_111_01.I_3':
                  double.parse(itemTCP['TA_111_01.I_3']).toStringAsFixed(2),
              'TA_111_01.Alarm1': int.parse(itemTCP['TA_111_01.Alarm1']),
              'TA_111_01.Alarm2': int.parse(itemTCP['TA_111_01.Alarm2']),
              'TA_111_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_111_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA111-1': int.parse(itemAntenas['Pot_TA111-1']),
              'Stat_TA111-1':
                  itemAntenas['Stat_TA111-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC111
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC111)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC113() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC113');
    notifyListeners();

    if (subscriptionPC113 == null) {
      _apiDataListPC113.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC113 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC113')) {
            dynamic firstItem = decodedEvent['PC113'][0];
            dynamic itemTCP = decodedEvent['PC113TCP'][0];
            dynamic itemAntenas = decodedEvent['PC113Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_113_01.Inputs': int.parse(itemTCP['TA_113_01.Inputs']),
              'TA_113_01.Outputs': int.parse(itemTCP['TA_113_01.Outputs']),
              'TA_113_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_113_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_113_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_113_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_113_01.Stat_Comm_MB':
                  itemTCP['TA_113_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_113_01.Stat_Comm':
                  itemTCP['TA_113_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_113_01.V_Avg':
                  double.parse(itemTCP['TA_113_01.V_Avg']).toStringAsFixed(2),
              'TA_113_01.I_Tot':
                  double.parse(itemTCP['TA_113_01.I_Tot']).toStringAsFixed(2),
              'TA_113_01.P_Tot':
                  double.parse(itemTCP['TA_113_01.P_Tot']).toStringAsFixed(2),
              'TA_113_01.PF_Avg':
                  double.parse(itemTCP['TA_113_01.PF_Avg']).toStringAsFixed(2),
              'TA_113_01.V_12':
                  double.parse(itemTCP['TA_113_01.V_12']).toStringAsFixed(2),
              'TA_113_01.V_23':
                  double.parse(itemTCP['TA_113_01.V_23']).toStringAsFixed(2),
              'TA_113_01.V_31':
                  double.parse(itemTCP['TA_113_01.V_31']).toStringAsFixed(2),
              'TA_113_01.VLL_Avg':
                  double.parse(itemTCP['TA_113_01.VLL_Avg']).toStringAsFixed(2),
              'TA_113_01.THDV_tot': double.parse(itemTCP['TA_113_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_113_01.THDI_tot': double.parse(itemTCP['TA_113_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_113_01.V_1':
                  double.parse(itemTCP['TA_113_01.V_1']).toStringAsFixed(2),
              'TA_113_01.I_1':
                  double.parse(itemTCP['TA_113_01.I_1']).toStringAsFixed(2),
              'TA_113_01.V_2':
                  double.parse(itemTCP['TA_113_01.V_2']).toStringAsFixed(2),
              'TA_113_01.I_2':
                  double.parse(itemTCP['TA_113_01.I_2']).toStringAsFixed(2),
              'TA_113_01.V_3':
                  double.parse(itemTCP['TA_113_01.V_3']).toStringAsFixed(2),
              'TA_113_01.I_3':
                  double.parse(itemTCP['TA_113_01.I_3']).toStringAsFixed(2),
              'TA_113_01.Alarm1': int.parse(itemTCP['TA_113_01.Alarm1']),
              'TA_113_01.Alarm2': int.parse(itemTCP['TA_113_01.Alarm2']),
              'TA_113_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_113_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA113-1': int.parse(itemAntenas['Pot_TA113-1']),
              'Stat_TA113-1':
                  itemAntenas['Stat_TA113-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC113
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC113)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC114() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC114');
    notifyListeners();

    if (subscriptionPC114 == null) {
      _apiDataListPC114.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC114 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC114')) {
            dynamic firstItem = decodedEvent['PC114'][0];
            dynamic itemTCP = decodedEvent['PC114TCP'][0];
            dynamic itemAntenas = decodedEvent['PC114Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_114_01.Inputs': int.parse(itemTCP['TA_114_01.Inputs']),
              'TA_114_01.Outputs': int.parse(itemTCP['TA_114_01.Outputs']),
              'TA_114_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_114_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_114_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_114_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_114_01.Stat_Comm_MB':
                  itemTCP['TA_114_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_114_01.Stat_Comm':
                  itemTCP['TA_114_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_114_01.V_Avg':
                  double.parse(itemTCP['TA_114_01.V_Avg']).toStringAsFixed(2),
              'TA_114_01.I_Tot':
                  double.parse(itemTCP['TA_114_01.I_Tot']).toStringAsFixed(2),
              'TA_114_01.P_Tot':
                  double.parse(itemTCP['TA_114_01.P_Tot']).toStringAsFixed(2),
              'TA_114_01.PF_Avg':
                  double.parse(itemTCP['TA_114_01.PF_Avg']).toStringAsFixed(2),
              'TA_114_01.V_12':
                  double.parse(itemTCP['TA_114_01.V_12']).toStringAsFixed(2),
              'TA_114_01.V_23':
                  double.parse(itemTCP['TA_114_01.V_23']).toStringAsFixed(2),
              'TA_114_01.V_31':
                  double.parse(itemTCP['TA_114_01.V_31']).toStringAsFixed(2),
              'TA_114_01.VLL_Avg':
                  double.parse(itemTCP['TA_114_01.VLL_Avg']).toStringAsFixed(2),
              'TA_114_01.THDV_tot': double.parse(itemTCP['TA_114_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_114_01.THDI_tot': double.parse(itemTCP['TA_114_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_114_01.V_1':
                  double.parse(itemTCP['TA_114_01.V_1']).toStringAsFixed(2),
              'TA_114_01.I_1':
                  double.parse(itemTCP['TA_114_01.I_1']).toStringAsFixed(2),
              'TA_114_01.V_2':
                  double.parse(itemTCP['TA_114_01.V_2']).toStringAsFixed(2),
              'TA_114_01.I_2':
                  double.parse(itemTCP['TA_114_01.I_2']).toStringAsFixed(2),
              'TA_114_01.V_3':
                  double.parse(itemTCP['TA_114_01.V_3']).toStringAsFixed(2),
              'TA_114_01.I_3':
                  double.parse(itemTCP['TA_114_01.I_3']).toStringAsFixed(2),
              'TA_114_01.Alarm1': int.parse(itemTCP['TA_114_01.Alarm1']),
              'TA_114_01.Alarm2': int.parse(itemTCP['TA_114_01.Alarm2']),
              'TA_114_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_114_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA114-1': int.parse(itemAntenas['Pot_TA114-1']),
              'Stat_TA114-1':
                  itemAntenas['Stat_TA114-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC114
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC114)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC115() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('PC115');
    notifyListeners();

    if (subscriptionPC115 == null) {
      _apiDataListPC115.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC115 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('PC115')) {
            dynamic firstItem = decodedEvent['PC115'][0];
            dynamic itemTCP = decodedEvent['PC115TCP'][0];
            dynamic itemAntenas = decodedEvent['PC115Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              'TA_115_01.Inputs': int.parse(itemTCP['TA_115_01.Inputs']),
              'TA_115_01.Outputs': int.parse(itemTCP['TA_115_01.Outputs']),
              'TA_115_01.Horas_Trab_Act':
                  double.parse(itemTCP['TA_115_01.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              'TA_115_01.Horas_Trab_Guar':
                  double.parse(itemTCP['TA_115_01.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              'TA_115_01.Stat_Comm_MB':
                  itemTCP['TA_115_01.Stat_Comm_MB'].toLowerCase() == 'true',
              'TA_115_01.Stat_Comm':
                  itemTCP['TA_115_01.Stat_Comm'].toLowerCase() == 'true',
              'TA_115_01.V_Avg':
                  double.parse(itemTCP['TA_115_01.V_Avg']).toStringAsFixed(2),
              'TA_115_01.I_Tot':
                  double.parse(itemTCP['TA_115_01.I_Tot']).toStringAsFixed(2),
              'TA_115_01.P_Tot':
                  double.parse(itemTCP['TA_115_01.P_Tot']).toStringAsFixed(2),
              'TA_115_01.PF_Avg':
                  double.parse(itemTCP['TA_115_01.PF_Avg']).toStringAsFixed(2),
              'TA_115_01.V_12':
                  double.parse(itemTCP['TA_115_01.V_12']).toStringAsFixed(2),
              'TA_115_01.V_23':
                  double.parse(itemTCP['TA_115_01.V_23']).toStringAsFixed(2),
              'TA_115_01.V_31':
                  double.parse(itemTCP['TA_115_01.V_31']).toStringAsFixed(2),
              'TA_115_01.VLL_Avg':
                  double.parse(itemTCP['TA_115_01.VLL_Avg']).toStringAsFixed(2),
              'TA_115_01.THDV_tot': double.parse(itemTCP['TA_115_01.THDV_tot'])
                  .toStringAsFixed(2),
              'TA_115_01.THDI_tot': double.parse(itemTCP['TA_115_01.THDI_tot'])
                  .toStringAsFixed(2),
              'TA_115_01.V_1':
                  double.parse(itemTCP['TA_115_01.V_1']).toStringAsFixed(2),
              'TA_115_01.I_1':
                  double.parse(itemTCP['TA_115_01.I_1']).toStringAsFixed(2),
              'TA_115_01.V_2':
                  double.parse(itemTCP['TA_115_01.V_2']).toStringAsFixed(2),
              'TA_115_01.I_2':
                  double.parse(itemTCP['TA_115_01.I_2']).toStringAsFixed(2),
              'TA_115_01.V_3':
                  double.parse(itemTCP['TA_115_01.V_3']).toStringAsFixed(2),
              'TA_115_01.I_3':
                  double.parse(itemTCP['TA_115_01.I_3']).toStringAsFixed(2),
              'TA_115_01.Alarm1': int.parse(itemTCP['TA_115_01.Alarm1']),
              'TA_115_01.Alarm2': int.parse(itemTCP['TA_115_01.Alarm2']),
              'TA_115_01.T1_Imp_Act_Index':
                  double.parse(itemTCP['TA_115_01.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_TA115-1': int.parse(itemAntenas['Pot_TA115-1']),
              'Stat_TA115-1':
                  itemAntenas['Stat_TA115-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC115
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC115)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC116(
      {String piscina = 'PC116',
      String taName = 'TA_116_01',
      String antena = 'TA116'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPC116 == null) {
      _apiDataListPC116.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC116 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC116
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC116)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePC117(
      {String piscina = 'PC117',
      String taName = 'TA_117_01',
      String antena = 'TA117'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPC117 == null) {
      _apiDataListPC117.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPC117 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPC117
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPC117)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS01(
      {String piscina = 'PS01',
      String ta01Name = 'TA_01_01',
      String ta02Name = 'TA_01_02',
      String antena = 'TA01'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS01 == null) {
      _apiDataListPS01.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS01 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS01
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS01)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS02(
      {String piscina = 'PS02',
      String ta01Name = 'TA_02_01',
      String ta02Name = 'TA_02_02',
      String antena = 'TA02'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS02 == null) {
      _apiDataListPS02.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS02 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS02
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS02)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS03(
      {String piscina = 'PS03',
      String taName = 'TA_03_01',
      String antena = 'TA03'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS03 == null) {
      _apiDataListPS03.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS03 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS03
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS03)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS04(
      {String piscina = 'PS04',
      String taName = 'TA_04_01',
      String antena = 'TA04'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS04 == null) {
      _apiDataListPS04.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS04 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS04
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS04)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS05(
      {String piscina = 'PS05',
      String ta01Name = 'TA_05_01',
      String ta02Name = 'TA_05_02',
      String antena = 'TA05'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS05 == null) {
      _apiDataListPS05.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS05 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS05
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS05)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS06(
      {String piscina = 'PS06',
      String taName = 'TA_06_01',
      String antena = 'TA06'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS06 == null) {
      _apiDataListPS06.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS06 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS06
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS06)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS07(
      {String piscina = 'PS07',
      String taName = 'TA_07_01',
      String antena = 'TA07'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS07 == null) {
      _apiDataListPS07.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS07 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS07
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS07)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS08(
      {String piscina = 'PS08',
      String taName = 'TA_08_01',
      String antena = 'TA08'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS08 == null) {
      _apiDataListPS08.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS08 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS08
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS08)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS09(
      {String piscina = 'PS09',
      String taName = 'TA_09_01',
      String antena = 'TA09'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS09 == null) {
      _apiDataListPS09.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS09 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS09
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS09)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS10(
      {String piscina = 'PS10',
      String taName = 'TA_10_01',
      String antena = 'TA10'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS10 == null) {
      _apiDataListPS10.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS10 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS10
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS10)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS11(
      {String piscina = 'PS11',
      String taName = 'TA_11_01',
      String antena = 'TA11'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS11 == null) {
      _apiDataListPS11.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS11 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS11
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS11)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS13(
      {String piscina = 'PS13',
      String taName = 'TA_13_01',
      String antena = 'TA13'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS13 == null) {
      _apiDataListPS13.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS13 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS13
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS13)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS14(
      {String piscina = 'PS14',
      String taName = 'TA_14_01',
      String antena = 'TA14'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS14 == null) {
      _apiDataListPS14.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS14 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS14
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS14)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS15(
      {String piscina = 'PS15',
      String taName = 'TA_15_01',
      String antena = 'TA15'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS15 == null) {
      _apiDataListPS15.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS15 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS15
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS15)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS16(
      {String piscina = 'PS16',
      String taName = 'TA_16_01',
      String antena = 'TA16'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS16 == null) {
      _apiDataListPS16.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS16 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS16
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS16)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS17(
      {String piscina = 'PS17',
      String taName = 'TA_17_01',
      String antena = 'TA17'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS17 == null) {
      _apiDataListPS17.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS17 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS17
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS17)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS18(
      {String piscina = 'PS18',
      String taName = 'TA_18_01',
      String antena = 'TA18'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS18 == null) {
      _apiDataListPS18.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS18 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS18
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS18)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS19(
      {String piscina = 'PS19',
      String taName = 'TA_19_01',
      String antena = 'TA19'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS19 == null) {
      _apiDataListPS19.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS19 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS19
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS19)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS21(
      {String piscina = 'PS21',
      String taName = 'TA_21_01',
      String antena = 'TA21'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS21 == null) {
      _apiDataListPS21.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS21 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS21
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS21)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS22(
      {String piscina = 'PS22',
      String taName = 'TA_22_01',
      String antena = 'TA22'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS22 == null) {
      _apiDataListPS22.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS22 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS22
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS22)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS23(
      {String piscina = 'PS23',
      String ta01Name = 'TA_23_01',
      String ta02Name = 'TA_23_02',
      String antena = 'TA23'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS23 == null) {
      _apiDataListPS23.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS23 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS23
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS23)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS24(
      {String piscina = 'PS24',
      String ta01Name = 'TA_24_01',
      String ta02Name = 'TA_24_02',
      String antena = 'TA24'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS24 == null) {
      _apiDataListPS24.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS24 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS24
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS24)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS25(
      {String piscina = 'PS25',
      String taName = 'TA_25_01',
      String antena = 'TA25'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS25 == null) {
      _apiDataListPS25.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS25 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS25
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS25)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS26(
      {String piscina = 'PS26',
      String taName = 'TA_26_01',
      String antena = 'TA26'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS26 == null) {
      _apiDataListPS26.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS26 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS26
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS26)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS27(
      {String piscina = 'PS27',
      String ta01Name = 'TA_27_01',
      String ta02Name = 'TA_27_02',
      String antena = 'TA27'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS27 == null) {
      _apiDataListPS27.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS27 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS27
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS27)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS28(
      {String piscina = 'PS28',
      String taName = 'TA_28_01',
      String antena = 'TA28'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS28 == null) {
      _apiDataListPS28.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS28 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS28
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS28)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS29(
      {String piscina = 'PS29',
      String taName = 'TA_29_01',
      String antena = 'TA29'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS29 == null) {
      _apiDataListPS29.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS29 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS29
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS29)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS30(
      {String piscina = 'PS30',
      String ta01Name = 'TA_30_01',
      String ta02Name = 'TA_30_02',
      String antena = 'TA30'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS30 == null) {
      _apiDataListPS30.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS30 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS30
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS30)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS31(
      {String piscina = 'PS31',
      String taName = 'TA_31_01',
      String antena = 'TA31'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS31 == null) {
      _apiDataListPS31.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS31 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS31
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS31)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS32(
      {String piscina = 'PS32',
      String taName = 'TA_32_01',
      String antena = 'TA32'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS32 == null) {
      _apiDataListPS32.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS32 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS32
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS32)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS33(
      {String piscina = 'PS33',
      String taName = 'TA_33_01',
      String antena = 'TA33'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS33 == null) {
      _apiDataListPS33.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS33 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS33
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS33)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS34(
      {String piscina = 'PS34',
      String taName = 'TA_34_01',
      String antena = 'TA34'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS34 == null) {
      _apiDataListPS34.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS34 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS34
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS34)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS35(
      {String piscina = 'PS35',
      String taName = 'TA_35_01',
      String antena = 'TA35'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS35 == null) {
      _apiDataListPS35.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS35 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS35
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS35)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS36(
      {String piscina = 'PS36',
      String taName = 'TA_36_01',
      String antena = 'TA36'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS36 == null) {
      _apiDataListPS36.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS36 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS36
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS36)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS37(
      {String piscina = 'PS37',
      String taName = 'TA_37_01',
      String antena = 'TA37'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS37 == null) {
      _apiDataListPS37.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS37 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS37
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS37)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS38(
      {String piscina = 'PS38',
      String ta01Name = 'TA_38_01',
      String ta02Name = 'TA_38_02',
      String antena = 'TA38'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS38 == null) {
      _apiDataListPS38.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS38 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS38
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS38)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS39(
      {String piscina = 'PS39',
      String ta01Name = 'TA_39_01',
      String ta02Name = 'TA_39_02',
      String antena = 'TA39'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS39 == null) {
      _apiDataListPS39.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS39 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS39
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS39)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS40(
      {String piscina = 'PS40',
      String ta01Name = 'TA_40_01',
      String ta02Name = 'TA_40_02',
      String antena = 'TA40'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS40 == null) {
      _apiDataListPS40.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS40 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS40
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS40)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS41(
      {String piscina = 'PS41',
      String ta01Name = 'TA_41_01',
      String ta02Name = 'TA_41_02',
      String antena = 'TA41'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS41 == null) {
      _apiDataListPS41.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS41 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS41
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS41)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS42(
      {String piscina = 'PS42',
      String ta01Name = 'TA_42_01',
      String ta02Name = 'TA_42_02',
      String antena = 'TA42'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS42 == null) {
      _apiDataListPS42.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS42 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS42
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS42)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS43(
      {String piscina = 'PS43',
      String ta01Name = 'TA_43_01',
      String ta02Name = 'TA_43_02',
      String antena = 'TA43'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS43 == null) {
      _apiDataListPS43.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS43 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$ta01Name.Inputs': int.parse(itemTCP['$ta01Name.Inputs']),
              '$ta01Name.Outputs': int.parse(itemTCP['$ta01Name.Outputs']),
              '$ta01Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta01Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta01Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta01Name.Stat_Comm_MB':
                  itemTCP['$ta01Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta01Name.Stat_Comm':
                  itemTCP['$ta01Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta01Name.V_Avg':
                  double.parse(itemTCP['$ta01Name.V_Avg']).toStringAsFixed(2),
              '$ta01Name.I_Tot':
                  double.parse(itemTCP['$ta01Name.I_Tot']).toStringAsFixed(2),
              '$ta01Name.P_Tot':
                  double.parse(itemTCP['$ta01Name.P_Tot']).toStringAsFixed(2),
              '$ta01Name.PF_Avg':
                  double.parse(itemTCP['$ta01Name.PF_Avg']).toStringAsFixed(2),
              '$ta01Name.V_12':
                  double.parse(itemTCP['$ta01Name.V_12']).toStringAsFixed(2),
              '$ta01Name.V_23':
                  double.parse(itemTCP['$ta01Name.V_23']).toStringAsFixed(2),
              '$ta01Name.V_31':
                  double.parse(itemTCP['$ta01Name.V_31']).toStringAsFixed(2),
              '$ta01Name.VLL_Avg':
                  double.parse(itemTCP['$ta01Name.VLL_Avg']).toStringAsFixed(2),
              '$ta01Name.THDV_tot': double.parse(itemTCP['$ta01Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.THDI_tot': double.parse(itemTCP['$ta01Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta01Name.V_1':
                  double.parse(itemTCP['$ta01Name.V_1']).toStringAsFixed(2),
              '$ta01Name.I_1':
                  double.parse(itemTCP['$ta01Name.I_1']).toStringAsFixed(2),
              '$ta01Name.V_2':
                  double.parse(itemTCP['$ta01Name.V_2']).toStringAsFixed(2),
              '$ta01Name.I_2':
                  double.parse(itemTCP['$ta01Name.I_2']).toStringAsFixed(2),
              '$ta01Name.V_3':
                  double.parse(itemTCP['$ta01Name.V_3']).toStringAsFixed(2),
              '$ta01Name.I_3':
                  double.parse(itemTCP['$ta01Name.I_3']).toStringAsFixed(2),
              '$ta01Name.Alarm1': int.parse(itemTCP['$ta01Name.Alarm1']),
              '$ta01Name.Alarm2': int.parse(itemTCP['$ta01Name.Alarm2']),
              '$ta01Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta01Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListTCP.add({
              '$ta02Name.Inputs': int.parse(itemTCP['$ta02Name.Inputs']),
              '$ta02Name.Outputs': int.parse(itemTCP['$ta02Name.Outputs']),
              '$ta02Name.Horas_Trab_Act':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$ta02Name.Horas_Trab_Guar':
                  double.parse(itemTCP['$ta02Name.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$ta02Name.Stat_Comm_MB':
                  itemTCP['$ta02Name.Stat_Comm_MB'].toLowerCase() == 'true',
              '$ta02Name.Stat_Comm':
                  itemTCP['$ta02Name.Stat_Comm'].toLowerCase() == 'true',
              '$ta02Name.V_Avg':
                  double.parse(itemTCP['$ta02Name.V_Avg']).toStringAsFixed(2),
              '$ta02Name.I_Tot':
                  double.parse(itemTCP['$ta02Name.I_Tot']).toStringAsFixed(2),
              '$ta02Name.P_Tot':
                  double.parse(itemTCP['$ta02Name.P_Tot']).toStringAsFixed(2),
              '$ta02Name.PF_Avg':
                  double.parse(itemTCP['$ta02Name.PF_Avg']).toStringAsFixed(2),
              '$ta02Name.V_12':
                  double.parse(itemTCP['$ta02Name.V_12']).toStringAsFixed(2),
              '$ta02Name.V_23':
                  double.parse(itemTCP['$ta02Name.V_23']).toStringAsFixed(2),
              '$ta02Name.V_31':
                  double.parse(itemTCP['$ta02Name.V_31']).toStringAsFixed(2),
              '$ta02Name.VLL_Avg':
                  double.parse(itemTCP['$ta02Name.VLL_Avg']).toStringAsFixed(2),
              '$ta02Name.THDV_tot': double.parse(itemTCP['$ta02Name.THDV_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.THDI_tot': double.parse(itemTCP['$ta02Name.THDI_tot'])
                  .toStringAsFixed(2),
              '$ta02Name.V_1':
                  double.parse(itemTCP['$ta02Name.V_1']).toStringAsFixed(2),
              '$ta02Name.I_1':
                  double.parse(itemTCP['$ta02Name.I_1']).toStringAsFixed(2),
              '$ta02Name.V_2':
                  double.parse(itemTCP['$ta02Name.V_2']).toStringAsFixed(2),
              '$ta02Name.I_2':
                  double.parse(itemTCP['$ta02Name.I_2']).toStringAsFixed(2),
              '$ta02Name.V_3':
                  double.parse(itemTCP['$ta02Name.V_3']).toStringAsFixed(2),
              '$ta02Name.I_3':
                  double.parse(itemTCP['$ta02Name.I_3']).toStringAsFixed(2),
              '$ta02Name.Alarm1': int.parse(itemTCP['$ta02Name.Alarm1']),
              '$ta02Name.Alarm2': int.parse(itemTCP['$ta02Name.Alarm2']),
              '$ta02Name.T1_Imp_Act_Index':
                  double.parse(itemTCP['$ta02Name.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Pot_$antena-2': int.parse(itemAntenas['Pot_$antena-2']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
              'Stat_$antena-2':
                  itemAntenas['Stat_$antena-2'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS43
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS43)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS44(
      {String piscina = 'PS44',
      String taName = 'TA_44_01',
      String antena = 'TA44'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS44 == null) {
      _apiDataListPS44.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS44 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS44
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS44)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS45(
      {String piscina = 'PS45',
      String taName = 'TA_45_01',
      String antena = 'TA45'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS45 == null) {
      _apiDataListPS45.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS45 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS45
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS45)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS46(
      {String piscina = 'PS46',
      String taName = 'TA_46_01',
      String antena = 'TA46'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS46 == null) {
      _apiDataListPS46.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS46 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS46
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS46)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS47(
      {String piscina = 'PS47',
      String taName = 'TA_47_01',
      String antena = 'TA47'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS47 == null) {
      _apiDataListPS47.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS47 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS47
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS47)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS47B(
      {String piscina = 'PS47B',
      String taName = 'TA_47B_01',
      String antena = 'TA47B'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo("$piscina-2");
    notifyListeners();

    if (subscriptionPS47B == null) {
      _apiDataListPS47B.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS47B = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS47B
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS47B)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS48(
      {String piscina = 'PS48',
      String taName = 'TA_48_01',
      String antena = 'TA48'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS48 == null) {
      _apiDataListPS48.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS48 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS48
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS48)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS49(
      {String piscina = 'PS49',
      String taName = 'TA_49_01',
      String antena = 'TA49'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS49 == null) {
      _apiDataListPS49.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS49 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS49
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS49)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS50(
      {String piscina = 'PS50',
      String taName = 'TA_50_01',
      String antena = 'TA50'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS50 == null) {
      _apiDataListPS50.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS50 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),

              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS50
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS50)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS51(
      {String piscina = 'PS51',
      String taName = 'TA_51_01',
      String antena = 'TA51'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS51 == null) {
      _apiDataListPS51.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS51 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS51
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS51)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS52(
      {String piscina = 'PS52',
      String taName = 'TA_52_01',
      String antena = 'TA52'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS52 == null) {
      _apiDataListPS52.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS52 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS52
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS52)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS53(
      {String piscina = 'PS53',
      String taName = 'TA_53_01',
      String antena = 'TA53'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS53 == null) {
      _apiDataListPS53.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS53 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS53
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS53)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS54(
      {String piscina = 'PS54',
      String taName = 'TA_54_01',
      String antena = 'TA54'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS54 == null) {
      _apiDataListPS54.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS54 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS54
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS54)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS55(
      {String piscina = 'PS55',
      String taName = 'TA_55_01',
      String antena = 'TA55'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS55 == null) {
      _apiDataListPS55.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS55 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS55
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS55)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS56(
      {String piscina = 'PS56',
      String taName = 'TA_56_01',
      String antena = 'TA56'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS56 == null) {
      _apiDataListPS56.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS56 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS56
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS56)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS57(
      {String piscina = 'PS57',
      String taName = 'TA_57_01',
      String antena = 'TA57'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS57 == null) {
      _apiDataListPS57.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS57 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS57
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS57)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  void subscribePS58(
      {String piscina = 'PS58',
      String taName = 'TA_58_01',
      String antena = 'TA58'}) {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo(piscina);
    notifyListeners();

    if (subscriptionPS58 == null) {
      _apiDataListPS58.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListTCP = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      if (_broadcastStream != null) {
        subscriptionPS58 = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListTCP.clear();
          apiDataListAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey(piscina)) {
            dynamic firstItem = decodedEvent[piscina][0];
            dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
            dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];

            apiDataList.add({
              'Num_Auto': int.parse(firstItem['Num_Auto']),
              'Num_Air_On': int.parse(firstItem['Num_Air_On']),
              'Hrs_Trab_Sem':
                  '${double.parse(firstItem['Hrs_Trab_Sem']).round()} H/Sem',
              'Hrs_Trab_Act':
                  '${double.parse(firstItem['Hrs_Trab_Act']).round()} H/Sem',
              'Ener_Mes_Act':
                  '${double.parse(firstItem['Ener_Mes_Act']).round()} KWh/M',
              'Ener_Mes_Pas':
                  '${double.parse(firstItem['Ener_Mes_Pas']).round()} KWh/M',
              'Ener_Total_Index':
                  double.parse(firstItem['Ener_Total_Index']).round(),
              'Pot_Inst': '${double.parse(firstItem['Pot_Inst']).round()} KW',
              'Alarm_Adver': int.parse(firstItem['Alarm_Adver']),
              'Hora_Ini_1':
                  firstItem['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Ini_2':
                  firstItem['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_1':
                  firstItem['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
              'Hora_Fin_2':
                  firstItem['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
              'Algun_Air_On': firstItem['Algun_Air_On'].toLowerCase() == 'true',
              'Run_Rem': firstItem['Run_Rem'].toLowerCase() == 'true',
              'Bloq_Auto_Hora':
                  firstItem['Bloq_Auto_Hora'].toLowerCase() == 'true',
              // 'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
              // 'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
              // 'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
              // 'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
            });

            apiDataListTCP.add({
              '$taName.Inputs': int.parse(itemTCP['$taName.Inputs']),
              '$taName.Outputs': int.parse(itemTCP['$taName.Outputs']),
              '$taName.Horas_Trab_Act':
                  double.parse(itemTCP['$taName.Horas_Trab_Act'])
                      .toStringAsFixed(2),
              '$taName.Horas_Trab_Guar':
                  double.parse(itemTCP['$taName.Horas_Trab_Guar'])
                      .toStringAsFixed(2),
              '$taName.Stat_Comm_MB':
                  itemTCP['$taName.Stat_Comm_MB'].toLowerCase() == 'true',
              '$taName.Stat_Comm':
                  itemTCP['$taName.Stat_Comm'].toLowerCase() == 'true',
              '$taName.V_Avg':
                  double.parse(itemTCP['$taName.V_Avg']).toStringAsFixed(2),
              '$taName.I_Tot':
                  double.parse(itemTCP['$taName.I_Tot']).toStringAsFixed(2),
              '$taName.P_Tot':
                  double.parse(itemTCP['$taName.P_Tot']).toStringAsFixed(2),
              '$taName.PF_Avg':
                  double.parse(itemTCP['$taName.PF_Avg']).toStringAsFixed(2),
              '$taName.V_12':
                  double.parse(itemTCP['$taName.V_12']).toStringAsFixed(2),
              '$taName.V_23':
                  double.parse(itemTCP['$taName.V_23']).toStringAsFixed(2),
              '$taName.V_31':
                  double.parse(itemTCP['$taName.V_31']).toStringAsFixed(2),
              '$taName.VLL_Avg':
                  double.parse(itemTCP['$taName.VLL_Avg']).toStringAsFixed(2),
              '$taName.THDV_tot':
                  double.parse(itemTCP['$taName.THDV_tot']).toStringAsFixed(2),
              '$taName.THDI_tot':
                  double.parse(itemTCP['$taName.THDI_tot']).toStringAsFixed(2),
              '$taName.V_1':
                  double.parse(itemTCP['$taName.V_1']).toStringAsFixed(2),
              '$taName.I_1':
                  double.parse(itemTCP['$taName.I_1']).toStringAsFixed(2),
              '$taName.V_2':
                  double.parse(itemTCP['$taName.V_2']).toStringAsFixed(2),
              '$taName.I_2':
                  double.parse(itemTCP['$taName.I_2']).toStringAsFixed(2),
              '$taName.V_3':
                  double.parse(itemTCP['$taName.V_3']).toStringAsFixed(2),
              '$taName.I_3':
                  double.parse(itemTCP['$taName.I_3']).toStringAsFixed(2),
              '$taName.Alarm1': int.parse(itemTCP['$taName.Alarm1']),
              '$taName.Alarm2': int.parse(itemTCP['$taName.Alarm2']),
              '$taName.T1_Imp_Act_Index':
                  double.parse(itemTCP['$taName.T1_Imp_Act_Index'])
                      .toStringAsFixed(2),
              // 'TCP039_1.Num_Air_On': int.parse(itemTCP['TCP039_1.Num_Air_On']),
              // 'TCP039_1.Desactiva':
              //     itemTCP['TCP039_1.Desactiva'].toLowerCase() == 'true',
            });

            apiDataListAntenas.add({
              'Pot_$antena-1': int.parse(itemAntenas['Pot_$antena-1']),
              'Stat_$antena-1':
                  itemAntenas['Stat_$antena-1'].toLowerCase() == 'true',
            });
            if (apiDataList.isNotEmpty &&
                apiDataListTCP.isNotEmpty &&
                apiDataListAntenas.isNotEmpty) {
              _apiDataListPS58
                  .addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
            }

            isLoading2 = false; // Finalizar el estado de cargando
            if (!Piscina.contieneSoloArreglosVacios(_apiDataListPS58)) {
              notifyListeners();
            }
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

// Cambiar a los tags de josefina
  void subscribePiscinasInfoGeneralJosefina() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('InfoGeneralPS');
    notifyListeners();

    // print('qqqqq');

    if (subscriptionInfoGeneralPis == null) {
      _apiDataListInfoGeneralPis.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListOnPs = [];
      if (_broadcastStream != null) {
        subscriptionInfoGeneralPis = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListOnPs.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('InfoGeneralPS')) {
            dynamic firstItem = decodedEvent['InfoGeneralPS'][0];

            apiDataList.add({
              'PS06.Algun_Air_On':
                  firstItem['PS06.Algun_Air_On'].toLowerCase() == 'true',
              'PS06.Num_Air_On': int.parse(firstItem['PS06.Num_Air_On']),
              'PS06.Alarm_Adver': int.parse(firstItem['PS06.Alarm_Adver']),
              'PC103.Algun_Air_On':
                  firstItem['PC103.Algun_Air_On'].toLowerCase() == 'true',
              'PC103.Num_Air_On': int.parse(firstItem['PC103.Num_Air_On']),
              'PC103.Alarm_Adver': int.parse(firstItem['PC103.Alarm_Adver']),
              'PC104.Algun_Air_On':
                  firstItem['PC104.Algun_Air_On'].toLowerCase() == 'true',
              'PC104.Num_Air_On': int.parse(firstItem['PC104.Num_Air_On']),
              'PC104.Alarm_Adver': int.parse(firstItem['PC104.Alarm_Adver']),

              'PC107.Algun_Air_On':
                  firstItem['PC107.Algun_Air_On'].toLowerCase() == 'true',
              'PC107.Num_Air_On': int.parse(firstItem['PC107.Num_Air_On']),
              'PC107.Alarm_Adver': int.parse(firstItem['PC107.Alarm_Adver']),

              'PS30.Algun_Air_On':
                  firstItem['PS30.Algun_Air_On'].toLowerCase() == 'true',
              'PS30.Num_Air_On': int.parse(firstItem['PS30.Num_Air_On']),
              'PS30.Alarm_Adver': int.parse(firstItem['PS30.Alarm_Adver']),
              'PS04.Algun_Air_On':
                  firstItem['PS04.Algun_Air_On'].toLowerCase() == 'true',
              'PS04.Num_Air_On': int.parse(firstItem['PS04.Num_Air_On']),
              'PS04.Alarm_Adver': int.parse(firstItem['PS04.Alarm_Adver']),
              'PC101.Algun_Air_On':
                  firstItem['PC101.Algun_Air_On'].toLowerCase() == 'true',
              'PC101.Num_Air_On': int.parse(firstItem['PC101.Num_Air_On']),
              'PC101.Alarm_Adver': int.parse(firstItem['PC101.Alarm_Adver']),
              'PS27.Algun_Air_On':
                  firstItem['PS27.Algun_Air_On'].toLowerCase() == 'true',
              'PS27.Num_Air_On': int.parse(firstItem['PS27.Num_Air_On']),
              'PS27.Alarm_Adver': int.parse(firstItem['PS27.Alarm_Adver']),
              'PS40.Algun_Air_On':
                  firstItem['PS40.Algun_Air_On'].toLowerCase() == 'true',
              'PS40.Num_Air_On': int.parse(firstItem['PS40.Num_Air_On']),
              'PS40.Alarm_Adver': int.parse(firstItem['PS40.Alarm_Adver']),
              'PS41.Algun_Air_On':
                  firstItem['PS41.Algun_Air_On'].toLowerCase() == 'true',
              'PS41.Num_Air_On': int.parse(firstItem['PS41.Num_Air_On']),
              'PS41.Alarm_Adver': int.parse(firstItem['PS41.Alarm_Adver']),
              'PS42.Algun_Air_On':
                  firstItem['PS42.Algun_Air_On'].toLowerCase() == 'true',
              'PS42.Num_Air_On': int.parse(firstItem['PS42.Num_Air_On']),
              'PS42.Alarm_Adver': int.parse(firstItem['PS42.Alarm_Adver']),
              'PS43.Algun_Air_On':
                  firstItem['PS43.Algun_Air_On'].toLowerCase() == 'true',
              'PS43.Num_Air_On': int.parse(firstItem['PS43.Num_Air_On']),
              'PS43.Alarm_Adver': int.parse(firstItem['PS43.Alarm_Adver']),
              'PS44.Algun_Air_On':
                  firstItem['PS44.Algun_Air_On'].toLowerCase() == 'true',
              'PS44.Num_Air_On': int.parse(firstItem['PS44.Num_Air_On']),
              'PS44.Alarm_Adver': int.parse(firstItem['PS44.Alarm_Adver']),
              'PS45.Algun_Air_On':
                  firstItem['PS45.Algun_Air_On'].toLowerCase() == 'true',
              'PS45.Num_Air_On': int.parse(firstItem['PS45.Num_Air_On']),
              'PS45.Alarm_Adver': int.parse(firstItem['PS45.Alarm_Adver']),
              'PS46.Algun_Air_On':
                  firstItem['PS46.Algun_Air_On'].toLowerCase() == 'true',
              'PS46.Num_Air_On': int.parse(firstItem['PS46.Num_Air_On']),
              'PS46.Alarm_Adver': int.parse(firstItem['PS46.Alarm_Adver']),
              'PS47.Algun_Air_On':
                  firstItem['PS47.Algun_Air_On'].toLowerCase() == 'true',
              'PS47.Num_Air_On': int.parse(firstItem['PS47.Num_Air_On']),
              'PS47.Alarm_Adver': int.parse(firstItem['PS47.Alarm_Adver']),
              'PS47B.Algun_Air_On':
                  firstItem['PS47B.Algun_Air_On'].toLowerCase() == 'true',
              'PS47B.Num_Air_On': int.parse(firstItem['PS47B.Num_Air_On']),
              'PS47B.Alarm_Adver': int.parse(firstItem['PS47B.Alarm_Adver']),
              'PS48.Algun_Air_On':
                  firstItem['PS48.Algun_Air_On'].toLowerCase() == 'true',
              'PS48.Num_Air_On': int.parse(firstItem['PS48.Num_Air_On']),
              'PS48.Alarm_Adver': int.parse(firstItem['PS48.Alarm_Adver']),
              'PS49.Algun_Air_On':
                  firstItem['PS49.Algun_Air_On'].toLowerCase() == 'true',
              'PS49.Num_Air_On': int.parse(firstItem['PS49.Num_Air_On']),
              'PS49.Alarm_Adver': int.parse(firstItem['PS49.Alarm_Adver']),
              'PS50.Algun_Air_On':
                  firstItem['PS50.Algun_Air_On'].toLowerCase() == 'true',
              'PS50.Num_Air_On': int.parse(firstItem['PS50.Num_Air_On']),
              'PS50.Alarm_Adver': int.parse(firstItem['PS50.Alarm_Adver']),
              'PS51.Algun_Air_On':
                  firstItem['PS51.Algun_Air_On'].toLowerCase() == 'true',
              'PS51.Num_Air_On': int.parse(firstItem['PS51.Num_Air_On']),
              'PS51.Alarm_Adver': int.parse(firstItem['PS51.Alarm_Adver']),
              'PS52.Algun_Air_On':
                  firstItem['PS52.Algun_Air_On'].toLowerCase() == 'true',
              'PS52.Num_Air_On': int.parse(firstItem['PS52.Num_Air_On']),
              'PS52.Alarm_Adver': int.parse(firstItem['PS52.Alarm_Adver']),
              'PS53.Algun_Air_On':
                  firstItem['PS53.Algun_Air_On'].toLowerCase() == 'true',
              'PS53.Num_Air_On': int.parse(firstItem['PS53.Num_Air_On']),
              'PS53.Alarm_Adver': int.parse(firstItem['PS53.Alarm_Adver']),
              'PS54.Algun_Air_On':
                  firstItem['PS54.Algun_Air_On'].toLowerCase() == 'true',
              'PS54.Num_Air_On': int.parse(firstItem['PS54.Num_Air_On']),
              'PS54.Alarm_Adver': int.parse(firstItem['PS54.Alarm_Adver']),
              'PS55.Algun_Air_On':
                  firstItem['PS55.Algun_Air_On'].toLowerCase() == 'true',
              'PS55.Num_Air_On': int.parse(firstItem['PS55.Num_Air_On']),
              'PS55.Alarm_Adver': int.parse(firstItem['PS55.Alarm_Adver']),
              'PS56.Algun_Air_On':
                  firstItem['PS56.Algun_Air_On'].toLowerCase() == 'true',
              'PS56.Num_Air_On': int.parse(firstItem['PS56.Num_Air_On']),
              'PS56.Alarm_Adver': int.parse(firstItem['PS56.Alarm_Adver']),
              'PS57.Algun_Air_On':
                  firstItem['PS57.Algun_Air_On'].toLowerCase() == 'true',
              'PS57.Num_Air_On': int.parse(firstItem['PS57.Num_Air_On']),
              'PS57.Alarm_Adver': int.parse(firstItem['PS57.Alarm_Adver']),
              'PS58.Algun_Air_On':
                  firstItem['PS58.Algun_Air_On'].toLowerCase() == 'true',
              'PS58.Num_Air_On': int.parse(firstItem['PS58.Num_Air_On']),
              'PS58.Alarm_Adver': int.parse(firstItem['PS58.Alarm_Adver']),
              'PS05.Algun_Air_On':
                  firstItem['PS05.Algun_Air_On'].toLowerCase() == 'true',
              'PS05.Num_Air_On': int.parse(firstItem['PS05.Num_Air_On']),
              'PS05.Alarm_Adver': int.parse(firstItem['PS05.Alarm_Adver']),
              'PC102.Algun_Air_On':
                  firstItem['PC102.Algun_Air_On'].toLowerCase() == 'true',
              'PC102.Num_Air_On': int.parse(firstItem['PC102.Num_Air_On']),
              'PC102.Alarm_Adver': int.parse(firstItem['PC102.Alarm_Adver']),
              'PC20.Algun_Air_On':
                  firstItem['PC20.Algun_Air_On'].toLowerCase() == 'true',
              'PC20.Num_Air_On': int.parse(firstItem['PC20.Num_Air_On']),
              'PC20.Alarm_Adver': int.parse(firstItem['PC20.Alarm_Adver']),
              'PC106.Algun_Air_On':
                  firstItem['PC106.Algun_Air_On'].toLowerCase() == 'true',
              'PC106.Num_Air_On': int.parse(firstItem['PC106.Num_Air_On']),
              'PC106.Alarm_Adver': int.parse(firstItem['PC106.Alarm_Adver']),
              'PC108.Algun_Air_On':
                  firstItem['PC108.Algun_Air_On'].toLowerCase() == 'true',
              'PC108.Num_Air_On': int.parse(firstItem['PC108.Num_Air_On']),
              'PC108.Alarm_Adver': int.parse(firstItem['PC108.Alarm_Adver']),
              'PC111.Algun_Air_On':
                  firstItem['PC111.Algun_Air_On'].toLowerCase() == 'true',
              'PC111.Num_Air_On': int.parse(firstItem['PC111.Num_Air_On']),
              'PC111.Alarm_Adver': int.parse(firstItem['PC111.Alarm_Adver']),
              'PC113.Algun_Air_On':
                  firstItem['PC113.Algun_Air_On'].toLowerCase() == 'true',
              'PC113.Num_Air_On': int.parse(firstItem['PC113.Num_Air_On']),
              'PC113.Alarm_Adver': int.parse(firstItem['PC113.Alarm_Adver']),
              'PC114.Algun_Air_On':
                  firstItem['PC114.Algun_Air_On'].toLowerCase() == 'true',
              'PC114.Num_Air_On': int.parse(firstItem['PC114.Num_Air_On']),
              'PC114.Alarm_Adver': int.parse(firstItem['PC114.Alarm_Adver']),
              'PC115.Algun_Air_On':
                  firstItem['PC115.Algun_Air_On'].toLowerCase() == 'true',
              'PC115.Num_Air_On': int.parse(firstItem['PC115.Num_Air_On']),
              'PC115.Alarm_Adver': int.parse(firstItem['PC115.Alarm_Adver']),
              'PS08.Algun_Air_On':
                  firstItem['PS08.Algun_Air_On'].toLowerCase() == 'true',
              'PS08.Num_Air_On': int.parse(firstItem['PS08.Num_Air_On']),
              'PS08.Alarm_Adver': int.parse(firstItem['PS08.Alarm_Adver']),
              'PC116.Algun_Air_On':
                  firstItem['PC116.Algun_Air_On'].toLowerCase() == 'true',
              'PC116.Num_Air_On': int.parse(firstItem['PC116.Num_Air_On']),
              'PC116.Alarm_Adver': int.parse(firstItem['PC116.Alarm_Adver']),
              'PC107.Algun_Air_On':
                  firstItem['PC107.Algun_Air_On'].toLowerCase() == 'true',
              'PC107.Num_Air_On': int.parse(firstItem['PC107.Num_Air_On']),
              'PC107.Alarm_Adver': int.parse(firstItem['PC107.Alarm_Adver']),
              'PS34.Algun_Air_On':
                  firstItem['PS34.Algun_Air_On'].toLowerCase() == 'true',
              'PS34.Num_Air_On': int.parse(firstItem['PS34.Num_Air_On']),
              'PS34.Alarm_Adver': int.parse(firstItem['PS34.Alarm_Adver']),
              'PC117.Algun_Air_On':
                  firstItem['PC117.Algun_Air_On'].toLowerCase() == 'true',
              'PC117.Num_Air_On': int.parse(firstItem['PC117.Num_Air_On']),
              'PC117.Alarm_Adver': int.parse(firstItem['PC117.Alarm_Adver']),
              'PS24.Algun_Air_On':
                  firstItem['PS24.Algun_Air_On'].toLowerCase() == 'true',
              'PS24.Num_Air_On': int.parse(firstItem['PS24.Num_Air_On']),
              'PS24.Alarm_Adver': int.parse(firstItem['PS24.Alarm_Adver']),
              //   'PC117.Algun_Air_On':
              //       firstItem['PC117.Algun_Air_On'].toLowerCase() == 'true',
              //   'PC117.Num_Air_On': int.parse(firstItem['PC117.Num_Air_On']),
              //   'PC117.Alarm_Adver': int.parse(firstItem['PC117.Alarm_Adver']),

              'PS10.Algun_Air_On':
                  firstItem['PS10.Algun_Air_On'].toLowerCase() == 'true',
              'PS10.Num_Air_On': int.parse(firstItem['PS10.Num_Air_On']),
              'PS10.Alarm_Adver': int.parse(firstItem['PS10.Alarm_Adver']),
              'PS33.Algun_Air_On':
                  firstItem['PS33.Algun_Air_On'].toLowerCase() == 'true',
              'PS33.Num_Air_On': int.parse(firstItem['PS33.Num_Air_On']),
              'PS33.Alarm_Adver': int.parse(firstItem['PS33.Alarm_Adver']),
              'PS01.Algun_Air_On':
                  firstItem['PS01.Algun_Air_On'].toLowerCase() == 'true',
              'PS01.Num_Air_On': int.parse(firstItem['PS01.Num_Air_On']),
              'PS01.Alarm_Adver': int.parse(firstItem['PS01.Alarm_Adver']),
              'PS02.Algun_Air_On':
                  firstItem['PS02.Algun_Air_On'].toLowerCase() == 'true',
              'PS02.Num_Air_On': int.parse(firstItem['PS02.Num_Air_On']),
              'PS02.Alarm_Adver': int.parse(firstItem['PS02.Alarm_Adver']),
              'PS03.Algun_Air_On':
                  firstItem['PS03.Algun_Air_On'].toLowerCase() == 'true',
              'PS03.Num_Air_On': int.parse(firstItem['PS03.Num_Air_On']),
              'PS03.Alarm_Adver': int.parse(firstItem['PS03.Alarm_Adver']),
              'PS07.Algun_Air_On':
                  firstItem['PS07.Algun_Air_On'].toLowerCase() == 'true',
              'PS07.Num_Air_On': int.parse(firstItem['PS07.Num_Air_On']),
              'PS07.Alarm_Adver': int.parse(firstItem['PS07.Alarm_Adver']),
              'PS09.Algun_Air_On':
                  firstItem['PS09.Algun_Air_On'].toLowerCase() == 'true',
              'PS09.Num_Air_On': int.parse(firstItem['PS09.Num_Air_On']),
              'PS09.Alarm_Adver': int.parse(firstItem['PS09.Alarm_Adver']),
              'PS11.Algun_Air_On':
                  firstItem['PS11.Algun_Air_On'].toLowerCase() == 'true',
              'PS11.Num_Air_On': int.parse(firstItem['PS11.Num_Air_On']),
              'PS11.Alarm_Adver': int.parse(firstItem['PS11.Alarm_Adver']),
              'PS13.Algun_Air_On':
                  firstItem['PS13.Algun_Air_On'].toLowerCase() == 'true',
              'PS13.Num_Air_On': int.parse(firstItem['PS13.Num_Air_On']),
              'PS13.Alarm_Adver': int.parse(firstItem['PS13.Alarm_Adver']),
              'PS14.Algun_Air_On':
                  firstItem['PS14.Algun_Air_On'].toLowerCase() == 'true',
              'PS14.Num_Air_On': int.parse(firstItem['PS14.Num_Air_On']),
              'PS14.Alarm_Adver': int.parse(firstItem['PS14.Alarm_Adver']),
              'PS15.Algun_Air_On':
                  firstItem['PS15.Algun_Air_On'].toLowerCase() == 'true',
              'PS15.Num_Air_On': int.parse(firstItem['PS15.Num_Air_On']),
              'PS15.Alarm_Adver': int.parse(firstItem['PS15.Alarm_Adver']),
              'PS16.Algun_Air_On':
                  firstItem['PS16.Algun_Air_On'].toLowerCase() == 'true',
              'PS16.Num_Air_On': int.parse(firstItem['PS16.Num_Air_On']),
              'PS16.Alarm_Adver': int.parse(firstItem['PS16.Alarm_Adver']),
              'PS17.Algun_Air_On':
                  firstItem['PS17.Algun_Air_On'].toLowerCase() == 'true',
              'PS17.Num_Air_On': int.parse(firstItem['PS17.Num_Air_On']),
              'PS17.Alarm_Adver': int.parse(firstItem['PS17.Alarm_Adver']),
              'PS18.Algun_Air_On':
                  firstItem['PS18.Algun_Air_On'].toLowerCase() == 'true',
              'PS18.Num_Air_On': int.parse(firstItem['PS18.Num_Air_On']),
              'PS18.Alarm_Adver': int.parse(firstItem['PS18.Alarm_Adver']),
              'PS19.Algun_Air_On':
                  firstItem['PS19.Algun_Air_On'].toLowerCase() == 'true',
              'PS19.Num_Air_On': int.parse(firstItem['PS19.Num_Air_On']),
              'PS19.Alarm_Adver': int.parse(firstItem['PS19.Alarm_Adver']),
              'PS21.Algun_Air_On':
                  firstItem['PS21.Algun_Air_On'].toLowerCase() == 'true',
              'PS21.Num_Air_On': int.parse(firstItem['PS21.Num_Air_On']),
              'PS21.Alarm_Adver': int.parse(firstItem['PS21.Alarm_Adver']),
              'PS22.Algun_Air_On':
                  firstItem['PS22.Algun_Air_On'].toLowerCase() == 'true',
              'PS22.Num_Air_On': int.parse(firstItem['PS22.Num_Air_On']),
              'PS22.Alarm_Adver': int.parse(firstItem['PS22.Alarm_Adver']),
              'PS23.Algun_Air_On':
                  firstItem['PS23.Algun_Air_On'].toLowerCase() == 'true',
              'PS23.Num_Air_On': int.parse(firstItem['PS23.Num_Air_On']),
              'PS23.Alarm_Adver': int.parse(firstItem['PS23.Alarm_Adver']),
              'PS25.Algun_Air_On':
                  firstItem['PS25.Algun_Air_On'].toLowerCase() == 'true',
              'PS25.Num_Air_On': int.parse(firstItem['PS25.Num_Air_On']),
              'PS25.Alarm_Adver': int.parse(firstItem['PS25.Alarm_Adver']),
              'PS26.Algun_Air_On':
                  firstItem['PS26.Algun_Air_On'].toLowerCase() == 'true',
              'PS26.Num_Air_On': int.parse(firstItem['PS26.Num_Air_On']),
              'PS26.Alarm_Adver': int.parse(firstItem['PS26.Alarm_Adver']),
              'PS28.Algun_Air_On':
                  firstItem['PS28.Algun_Air_On'].toLowerCase() == 'true',
              'PS28.Num_Air_On': int.parse(firstItem['PS28.Num_Air_On']),
              'PS28.Alarm_Adver': int.parse(firstItem['PS28.Alarm_Adver']),
              'PS29.Algun_Air_On':
                  firstItem['PS29.Algun_Air_On'].toLowerCase() == 'true',
              'PS29.Num_Air_On': int.parse(firstItem['PS29.Num_Air_On']),
              'PS29.Alarm_Adver': int.parse(firstItem['PS29.Alarm_Adver']),
              'PS31.Algun_Air_On':
                  firstItem['PS31.Algun_Air_On'].toLowerCase() == 'true',
              'PS31.Num_Air_On': int.parse(firstItem['PS31.Num_Air_On']),
              'PS31.Alarm_Adver': int.parse(firstItem['PS31.Alarm_Adver']),
              'PS32.Algun_Air_On':
                  firstItem['PS32.Algun_Air_On'].toLowerCase() == 'true',
              'PS32.Num_Air_On': int.parse(firstItem['PS32.Num_Air_On']),
              'PS32.Alarm_Adver': int.parse(firstItem['PS32.Alarm_Adver']),
              'PS35.Algun_Air_On':
                  firstItem['PS35.Algun_Air_On'].toLowerCase() == 'true',
              'PS35.Num_Air_On': int.parse(firstItem['PS35.Num_Air_On']),
              'PS35.Alarm_Adver': int.parse(firstItem['PS35.Alarm_Adver']),
              'PS36.Algun_Air_On':
                  firstItem['PS36.Algun_Air_On'].toLowerCase() == 'true',
              'PS36.Num_Air_On': int.parse(firstItem['PS36.Num_Air_On']),
              'PS36.Alarm_Adver': int.parse(firstItem['PS36.Alarm_Adver']),
              'PS37.Algun_Air_On':
                  firstItem['PS37.Algun_Air_On'].toLowerCase() == 'true',
              'PS37.Num_Air_On': int.parse(firstItem['PS37.Num_Air_On']),
              'PS37.Alarm_Adver': int.parse(firstItem['PS37.Alarm_Adver']),
              'PS38.Algun_Air_On':
                  firstItem['PS38.Algun_Air_On'].toLowerCase() == 'true',
              'PS38.Num_Air_On': int.parse(firstItem['PS38.Num_Air_On']),
              'PS38.Alarm_Adver': int.parse(firstItem['PS38.Alarm_Adver']),
              'PS39.Algun_Air_On':
                  firstItem['PS39.Algun_Air_On'].toLowerCase() == 'true',
              'PS39.Num_Air_On': int.parse(firstItem['PS39.Num_Air_On']),
              'PS39.Alarm_Adver': int.parse(firstItem['PS39.Alarm_Adver']),
            });

            // Contar cuántas piscinas tienen estado false
            int piscinasOnCount = 0;
            firstItem.forEach((key, value) {
              if (key.endsWith('Num_Air_On') && int.parse(value) > 0) {
                piscinasOnCount++;
              }
            });

            // Crear y agregar el objeto a apiDataListOffAntenas
            apiDataListOnPs.add({
              'PiscinasOn': piscinasOnCount.toString(),
            });

            _apiDataListInfoGeneralPis.addAll([apiDataList, apiDataListOnPs]);

            print(_apiDataListInfoGeneralPis[0][0]);

            isLoading2 = false; // Finalizar el estado de cargando
            notifyListeners();
            // print(isLoading2);
            // print(_apiDataListPS01)
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

  // cambiar a los tags de josefina

  void subscribePiscinasAntenas() {
    isLoading2 = true; // Comenzar el estado de cargando
    _hasError = false; // Reiniciar el estado de error

    _subscribeTo('FJOSAntenas');
    notifyListeners();

    if (subscriptionAntenas == null) {
      // print('aaaaaaaaaaaaaa');
      _apiDataListAntenas.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListOffAntenas = [];
      if (_broadcastStream != null) {
        // print('aaaaaaaaaaaaaa');
        subscriptionAntenas = _broadcastStream!.listen((event) {
          apiDataList.clear();
          apiDataListOffAntenas.clear();
          final decodedEvent = json.decode(event);
          if (decodedEvent.containsKey('Antenas')) {
            dynamic itemAntenas = decodedEvent['Antenas'][0];

            apiDataList.add({
              'Pot_TA03-1': int.parse(itemAntenas['Pot_TA03-1']),
              'Pot_TA01-1': int.parse(itemAntenas['Pot_TA01-1']),
              'Pot_TA01-2': int.parse(itemAntenas['Pot_TA01-2']),
              'Pot_TA117-1': int.parse(itemAntenas['Pot_TA117-1']),
              'Pot_TA02-1': int.parse(itemAntenas['Pot_TA02-1']),
              'Pot_TA10-1': int.parse(itemAntenas['Pot_TA10-1']),
              'Pot_TA02-2': int.parse(itemAntenas['Pot_TA02-2']),
              'Pot_TA103-1': int.parse(itemAntenas['Pot_TA103-1']),
              'Pot_TA104-1': int.parse(itemAntenas['Pot_TA104-1']),
              'Pot_TA04-1': int.parse(itemAntenas['Pot_TA04-1']),
              'Pot_TA16-1': int.parse(itemAntenas['Pot_TA16-1']),
              'Pot_TA05-1': int.parse(itemAntenas['Pot_TA05-1']),
              'Pot_TA106-1': int.parse(itemAntenas['Pot_TA106-1']),
              'Pot_TA05-2': int.parse(itemAntenas['Pot_TA05-2']),
              'Pot_TA11-1': int.parse(itemAntenas['Pot_TA11-1']),
              'Pot_TA06-1': int.parse(itemAntenas['Pot_TA06-1']),
              'Pot_TA102-1': int.parse(itemAntenas['Pot_TA102-1']),
              'Pot_TA07-1': int.parse(itemAntenas['Pot_TA07-1']),
              'Pot_TA08-1': int.parse(itemAntenas['Pot_TA08-1']),
              'Pot_TA111-1': int.parse(itemAntenas['Pot_TA111-1']),
              'Pot_TA09-1': int.parse(itemAntenas['Pot_TA09-1']),
              'Pot_TA42-2': int.parse(itemAntenas['Pot_TA42-2']),
              'Pot_TA115-1': int.parse(itemAntenas['Pot_TA115-1']),
              'Pot_TA101-1': int.parse(itemAntenas['Pot_TA101-1']),
              'Pot_TA107-1': int.parse(itemAntenas['Pot_TA107-1']),
              'Pot_TA108-1': int.parse(itemAntenas['Pot_TA108-1']),
              'Pot_TA113-1': int.parse(itemAntenas['Pot_TA113-1']),
              'Pot_TA114-1': int.parse(itemAntenas['Pot_TA114-1']),
              'Pot_TA116-1': int.parse(itemAntenas['Pot_TA116-1']),
              'Pot_TA13-1': int.parse(itemAntenas['Pot_TA13-1']),
              'Pot_TA14-1': int.parse(itemAntenas['Pot_TA14-1']),
              'Pot_TA15-1': int.parse(itemAntenas['Pot_TA15-1']),
              'Pot_TA17-1': int.parse(itemAntenas['Pot_TA17-1']),
              'Pot_TA18-1': int.parse(itemAntenas['Pot_TA18-1']),
              'Pot_TA19-1': int.parse(itemAntenas['Pot_TA19-1']),
              'Pot_TA20-1': int.parse(itemAntenas['Pot_TA20-1']),
              'Pot_TA21-1': int.parse(itemAntenas['Pot_TA21-1']),
              'Pot_TA22-1': int.parse(itemAntenas['Pot_TA22-1']),
              'Pot_TA23-1': int.parse(itemAntenas['Pot_TA23-1']),
              'Pot_TA23-2': int.parse(itemAntenas['Pot_TA23-2']),
              'Pot_TA24-1': int.parse(itemAntenas['Pot_TA24-1']),
              'Pot_TA24-2': int.parse(itemAntenas['Pot_TA24-2']),
              'Pot_TA25-1': int.parse(itemAntenas['Pot_TA25-1']),
              'Pot_TA26-1': int.parse(itemAntenas['Pot_TA26-1']),
              'Pot_TA27-1': int.parse(itemAntenas['Pot_TA27-1']),
              'Pot_TA27-2': int.parse(itemAntenas['Pot_TA27-2']),
              'Pot_TA28-1': int.parse(itemAntenas['Pot_TA28-1']),
              'Pot_TA29-1': int.parse(itemAntenas['Pot_TA29-1']),
              'Pot_TA30-1': int.parse(itemAntenas['Pot_TA30-1']),
              'Pot_TA30-2': int.parse(itemAntenas['Pot_TA30-2']),
              'Pot_TA31-1': int.parse(itemAntenas['Pot_TA31-1']),
              'Pot_TA32-1': int.parse(itemAntenas['Pot_TA32-1']),
              'Pot_TA33-1': int.parse(itemAntenas['Pot_TA33-1']),
              'Pot_TA34-1': int.parse(itemAntenas['Pot_TA34-1']),
              'Pot_TA35-1': int.parse(itemAntenas['Pot_TA35-1']),
              'Pot_TA36-1': int.parse(itemAntenas['Pot_TA36-1']),
              'Pot_TA37-1': int.parse(itemAntenas['Pot_TA37-1']),
              'Pot_TA38-1': int.parse(itemAntenas['Pot_TA38-1']),
              'Pot_TA38-2': int.parse(itemAntenas['Pot_TA38-2']),
              'Pot_TA39-1': int.parse(itemAntenas['Pot_TA39-1']),
              'Pot_TA39-2': int.parse(itemAntenas['Pot_TA39-2']),
              'Pot_TA40-1': int.parse(itemAntenas['Pot_TA40-1']),
              'Pot_TA40-2': int.parse(itemAntenas['Pot_TA40-2']),
              'Pot_TA41-1': int.parse(itemAntenas['Pot_TA41-1']),
              'Pot_TA41-2': int.parse(itemAntenas['Pot_TA41-2']),
              'Pot_TA42-1': int.parse(itemAntenas['Pot_TA42-1']),
              'Pot_TA43-1': int.parse(itemAntenas['Pot_TA43-1']),
              'Pot_TA43-2': int.parse(itemAntenas['Pot_TA43-2']),
              'Pot_TA44-1': int.parse(itemAntenas['Pot_TA44-1']),
              'Pot_TA45-1': int.parse(itemAntenas['Pot_TA45-1']),
              'Pot_TA46-1': int.parse(itemAntenas['Pot_TA46-1']),
              'Pot_TA47-1': int.parse(itemAntenas['Pot_TA47-1']),
              'Pot_TA47B-1': int.parse(itemAntenas['Pot_TA47B-1']),
              'Pot_TA48-1': int.parse(itemAntenas['Pot_TA48-1']),
              'Pot_TA49-1': int.parse(itemAntenas['Pot_TA49-1']),
              'Pot_TA50-1': int.parse(itemAntenas['Pot_TA50-1']),
              'Pot_TA51-1': int.parse(itemAntenas['Pot_TA51-1']),
              'Pot_TA52-1': int.parse(itemAntenas['Pot_TA52-1']),
              'Pot_TA53-1': int.parse(itemAntenas['Pot_TA53-1']),
              'Pot_TA54-1': int.parse(itemAntenas['Pot_TA54-1']),
              'Pot_TA55-1': int.parse(itemAntenas['Pot_TA55-1']),
              'Pot_TA56-1': int.parse(itemAntenas['Pot_TA56-1']),
              'Pot_TA57-1': int.parse(itemAntenas['Pot_TA57-1']),
              'Pot_TA58-1': int.parse(itemAntenas['Pot_TA58-1']),
              'Pot_AP1-B': int.parse(itemAntenas['Pot_AP1-B']),
              'Pot_AP1': int.parse(itemAntenas['Pot-AP1']),
              'Pot_AP2': int.parse(itemAntenas['Pot-AP2']),
              'Pot_AP3': int.parse(itemAntenas['Pot-AP3']),
              'Pot_Camp-PTP-Mari': int.parse(itemAntenas['Pot_Camp-PTP-Mari']),
              'Pot_EB_G1': int.parse(itemAntenas['Pot_EB_G1']),
              // 'Pot_EB_G2': int.parse(itemAntenas['Pot_EB_G2']),
              'Pot_PTP-Camp-T1': int.parse(itemAntenas['Pot_PTP-Camp-T1']),
              'Pot_PTP-Camp-T2': int.parse(itemAntenas['Pot_PTP-Camp-T2']),
              'Pot_PTP-Camp-T3': int.parse(itemAntenas['Pot_PTP-Camp-T3']),
              'Pot_PTP-Mari': int.parse(itemAntenas['Pot_PTP-Mari']),
              'Pot_PTP-T1': int.parse(itemAntenas['Pot_PTP-T1']),
              'Pot_PTP-T2': int.parse(itemAntenas['Pot_PTP-T2']),
              'Pot_PTP-T3': int.parse(itemAntenas['Pot_PTP-T3']),
              'Stat_TA13-1': itemAntenas['Stat_TA13-1'] == "TRUE",
              'Stat_TA39-2': itemAntenas['Stat_TA39-2'] == "TRUE",
              'Stat_TA114-1': itemAntenas['Stat_TA114-1'] == "TRUE",
              'Stat_TA37-1': itemAntenas['Stat_TA37-1'] == "TRUE",
              'Stat_TA01-1': itemAntenas['Stat_TA01-1'] == "TRUE",
              'Stat_TA49-1': itemAntenas['Stat_TA49-1'] == "TRUE",
              'Stat_TA01-2': itemAntenas['Stat_TA01-2'] == "TRUE",
              'Stat_TA15-1': itemAntenas['Stat_TA15-1'] == "TRUE",
              'Stat_TA40-2': itemAntenas['Stat_TA40-2'] == "TRUE",
              'Stat_TA115-1': itemAntenas['Stat_TA115-1'] == "TRUE",
              'Stat_TA02-1': itemAntenas['Stat_TA02-1'] == "TRUE",
              'Stat_TA02-2': itemAntenas['Stat_TA02-2'] == "TRUE",
              'Stat_TA03-1': itemAntenas['Stat_TA03-1'] == "TRUE",
              'Stat_TA101-1': itemAntenas['Stat_TA101-1'] == "TRUE",
              'Stat_TA29-1': itemAntenas['Stat_TA29-1'] == "TRUE",
              'Stat_TA04-1': itemAntenas['Stat_TA04-1'] == "TRUE",
              'Stat_TA42-2': itemAntenas['Stat_TA42-2'] == "TRUE",
              'Stat_TA14-1': itemAntenas['Stat_TA14-1'] == "TRUE",
              'Stat_TA05-1': itemAntenas['Stat_TA05-1'] == "TRUE",
              'Stat_TA05-2': itemAntenas['Stat_TA05-2'] == "TRUE",
              'Stat_TA17-1': itemAntenas['Stat_TA17-1'] == "TRUE",
              'Stat_PTP-Camp-T3': itemAntenas['Stat_PTP-Camp-T3'] == "TRUE",
              'Stat_TA06-1': itemAntenas['Stat_TA06-1'] == "TRUE",
              'Stat_TA107-1': itemAntenas['Stat_TA107-1'] == "TRUE",
              'Stat_TA32-1': itemAntenas['Stat_TA32-1'] == "TRUE",
              'Stat_TA45-1': itemAntenas['Stat_TA45-1'] == "TRUE",
              'Stat_TA08-1': itemAntenas['Stat_TA08-1'] == "TRUE",
              'Stat_TA18-1': itemAntenas['Stat_TA18-1'] == "TRUE",
              'Stat_TA07-1': itemAntenas['Stat_TA07-1'] == "TRUE",
              'Stat_PTP-Mari': itemAntenas['Stat_PTP-Mari'] == "TRUE",
              'Stat_TA09-1': itemAntenas['Stat_TA09-1'] == "TRUE",
              'Stat_TA10-1': itemAntenas['Stat_TA10-1'] == "TRUE",
              'Stat_TA102-1': itemAntenas['Stat_TA102-1'] == "TRUE",
              'Stat_TA103-1': itemAntenas['Stat_TA103-1'] == "TRUE",
              'Stat_TA104-1': itemAntenas['Stat_TA104-1'] == "TRUE",
              'Stat_TA106-1': itemAntenas['Stat_TA106-1'] == "TRUE",

              'Stat_TA108-1': itemAntenas['Stat_TA108-1'] == "TRUE",
              'Stat_TA11-1': itemAntenas['Stat_TA11-1'] == "TRUE",
              'Stat_TA111-1': itemAntenas['Stat_TA111-1'] == "TRUE",
              'Stat_TA113-1': itemAntenas['Stat_TA113-1'] == "TRUE",
              'Stat_TA116-1': itemAntenas['Stat_TA116-1'] == "TRUE",
              'Stat_TA117-1': itemAntenas['Stat_TA117-1'] == "TRUE",
              'Stat_TA16-1': itemAntenas['Stat_TA16-1'] == "TRUE",
              'Stat_TA19-1': itemAntenas['Stat_TA19-1'] == "TRUE",
              'Stat_TA20-1': itemAntenas['Stat_TA20-1'] == "TRUE",
              'Stat_TA21-1': itemAntenas['Stat_TA21-1'] == "TRUE",
              'Stat_TA22-1': itemAntenas['Stat_TA22-1'] == "TRUE",
              'Stat_TA23-1': itemAntenas['Stat_TA23-1'] == "TRUE",
              'Stat_TA23-2': itemAntenas['Stat_TA23-2'] == "TRUE",
              'Stat_TA24-1': itemAntenas['Stat_TA24-1'] == "TRUE",
              'Stat_TA24-2': itemAntenas['Stat_TA24-2'] == "TRUE",
              'Stat_TA25-1': itemAntenas['Stat_TA25-1'] == "TRUE",
              'Stat_TA26-1': itemAntenas['Stat_TA26-1'] == "TRUE",
              'Stat_TA27-1': itemAntenas['Stat_TA27-1'] == "TRUE",
              'Stat_TA27-2': itemAntenas['Stat_TA27-2'] == "TRUE",
              'Stat_TA28-1': itemAntenas['Stat_TA28-1'] == "TRUE",
              'Stat_TA30-1': itemAntenas['Stat_TA30-1'] == "TRUE",
              'Stat_TA30-2': itemAntenas['Stat_TA30-2'] == "TRUE",
              'Stat_TA31-1': itemAntenas['Stat_TA31-1'] == "TRUE",
              'Stat_TA33-1': itemAntenas['Stat_TA33-1'] == "TRUE",
              'Stat_TA34-1': itemAntenas['Stat_TA34-1'] == "TRUE",
              'Stat_TA35-1': itemAntenas['Stat_TA35-1'] == "TRUE",
              'Stat_TA36-1': itemAntenas['Stat_TA36-1'] == "TRUE",
              'Stat_TA38-1': itemAntenas['Stat_TA38-1'] == "TRUE",
              'Stat_TA38-2': itemAntenas['Stat_TA38-2'] == "TRUE",
              'Stat_TA39-1': itemAntenas['Stat_TA39-1'] == "TRUE",
              'Stat_TA40-1': itemAntenas['Stat_TA40-1'] == "TRUE",
              'Stat_TA41-1': itemAntenas['Stat_TA41-1'] == "TRUE",
              'Stat_TA41-2': itemAntenas['Stat_TA41-2'] == "TRUE",
              'Stat_TA42-1': itemAntenas['Stat_TA42-1'] == "TRUE",
              'Stat_TA43-1': itemAntenas['Stat_TA43-1'] == "TRUE",
              'Stat_TA43-2': itemAntenas['Stat_TA43-2'] == "TRUE",
              'Stat_TA44-1': itemAntenas['Stat_TA44-1'] == "TRUE",
              'Stat_TA46-1': itemAntenas['Stat_TA46-1'] == "TRUE",
              'Stat_TA47-1': itemAntenas['Stat_TA47-1'] == "TRUE",
              'Stat_TA47B-1': itemAntenas['Stat_TA47B-1'] == "TRUE",
              'Stat_TA48-1': itemAntenas['Stat_TA48-1'] == "TRUE",
              'Stat_TA50-1': itemAntenas['Stat_TA50-1'] == "TRUE",
              'Stat_TA51-1': itemAntenas['Stat_TA51-1'] == "TRUE",
              'Stat_TA52-1': itemAntenas['Stat_TA52-1'] == "TRUE",
              'Stat_TA53-1': itemAntenas['Stat_TA53-1'] == "TRUE",
              'Stat_TA54-1': itemAntenas['Stat_TA54-1'] == "TRUE",
              'Stat_TA55-1': itemAntenas['Stat_TA55-1'] == "TRUE",
              'Stat_TA56-1': itemAntenas['Stat_TA56-1'] == "TRUE",
              'Stat_TA57-1': itemAntenas['Stat_TA57-1'] == "TRUE",
              'Stat_TA58-1': itemAntenas['Stat_TA58-1'] == "TRUE",
              'Stat_AP1': itemAntenas['Stat_AP1'] == "TRUE",
              'Stat_AP1-B': itemAntenas['Stat_AP1-B'] == "TRUE",
              'Stat_AP2': itemAntenas['Stat_AP2'] == "TRUE",
              'Stat_AP3': itemAntenas['Stat_AP3'] == "TRUE",
              'Stat_Camp-PTP-Mari': itemAntenas['Stat_Camp-PTP-Mari'] == "TRUE",
              'Stat_PTP-T1': itemAntenas['Stat_PTP-T1'] == "TRUE",
              'Stat_PTP-T2': itemAntenas['Stat_PTP-T2'] == "TRUE",
              'Stat_PTP-T3': itemAntenas['Stat_PTP-T3'] == "TRUE",
              'Stat_EB_G1': itemAntenas['Stat_EB_G1'] == "TRUE",
              'Stat_EB_G2': itemAntenas['Stat_EB_G2'] == "TRUE",
              'Stat_PTP-Camp-T1': itemAntenas['Stat_PTP-Camp-T1'] == "TRUE",
              'Stat_PTP-Camp-T2': itemAntenas['Stat_PTP-Camp-T2'] == "TRUE",
            });

            // Contar cuántas piscinas tienen estado false
            int antenasOffCount = 0;
            itemAntenas.forEach((key, value) {
              if (key.endsWith('_Status') && value.toLowerCase() == 'false') {
                antenasOffCount++;
              }
            });

            // Crear y agregar el objeto a apiDataListOffAntenas
            apiDataListOffAntenas.add({
              'AntenasOff': antenasOffCount.toString(),
            });

            _apiDataListAntenas.addAll([apiDataList, apiDataListOffAntenas]);

            // print(_apiDataListInfoGeneralPis);

            isLoading2 = false; // Finalizar el estado de cargando
            notifyListeners();
            // print(isLoading2);
            print(_apiDataListAntenas[0][0]);
          }
        }, onError: (error) {
          isLoading2 = false; // Finalizar el estado de cargando
          _hasError = true; // Activar el estado de error
          _errorMessage = error.toString(); // Almacenar mensaje de error
          notifyListeners();
        });
      } else {}
    }
  }

// Cambiar a los tags de josefina

  // void subscribePiscinasAntenasAndInfoGeneral() {
  //   isLoading2 = true; // Comenzar el estado de cargando
  //   _hasError = false; // Reiniciar el estado de error

  //   _subscribeTo('InfoGeneralPS');
  //   notifyListeners();

  //   // print('qqqqq');

  //   if (subscriptionInfoGeneralPis == null) {
  //     // _apiDataListInfoGeneralPisSaved.add(_apiDataListInfoGeneralPis);
  //     notifyListeners();
  //     // print('Eliminandoooo');
  //     _apiDataListInfoGeneralPis.clear();
  //     List<Map<dynamic, dynamic>> apiDataList = [];
  //     List<Map<dynamic, dynamic>> apiDataListOnPs = [];
  //     List<Map<dynamic, dynamic>> apiDataListAntenas = [];
  //     List<Map<dynamic, dynamic>> apiDataListOffAntenas = [];

  //     try {
  //       if (_broadcastStream != null) {
  //         subscriptionInfoGeneralPis = _broadcastStream!.listen((event) {
  //           // print('Aquiii');
  //           apiDataList.clear();
  //           apiDataListOnPs.clear();
  //           apiDataListAntenas.clear();
  //           apiDataListOffAntenas.clear();

  //           final decodedEvent = json.decode(event);
  //           if (decodedEvent.containsKey('InfoGeneralPS')) {
  //             dynamic firstItem = decodedEvent['InfoGeneralPS'][0];
  //             dynamic itemAntenas = decodedEvent['Antenas'][0];

  //             apiDataList.add({
  //               'PS06.Algun_Air_On':
  //                   firstItem['PS06.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS06.Num_Air_On': int.parse(firstItem['PS06.Num_Air_On']),
  //               'PS06.Alarm_Adver': int.parse(firstItem['PS06.Alarm_Adver']),
  //               'PC103.Algun_Air_On':
  //                   firstItem['PC103.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC103.Num_Air_On': int.parse(firstItem['PC103.Num_Air_On']),
  //               'PC103.Alarm_Adver': int.parse(firstItem['PC103.Alarm_Adver']),

  //               'PC104.Algun_Air_On':
  //                   firstItem['PC104.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC104.Num_Air_On': int.parse(firstItem['PC104.Num_Air_On']),
  //               'PC104.Alarm_Adver': int.parse(firstItem['PC104.Alarm_Adver']),

  //               'PC107.Algun_Air_On':
  //                   firstItem['PC107.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC107.Num_Air_On': int.parse(firstItem['PC107.Num_Air_On']),
  //               'PC107.Alarm_Adver': int.parse(firstItem['PC107.Alarm_Adver']),

  //               'PS30.Algun_Air_On':
  //                   firstItem['PS30.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS30.Num_Air_On': int.parse(firstItem['PS30.Num_Air_On']),
  //               'PS30.Alarm_Adver': int.parse(firstItem['PS30.Alarm_Adver']),
  //               'PS04.Algun_Air_On':
  //                   firstItem['PS04.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS04.Num_Air_On': int.parse(firstItem['PS04.Num_Air_On']),
  //               'PS04.Alarm_Adver': int.parse(firstItem['PS04.Alarm_Adver']),
  //               'PC101.Algun_Air_On':
  //                   firstItem['PC101.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC101.Num_Air_On': int.parse(firstItem['PC101.Num_Air_On']),
  //               'PC101.Alarm_Adver': int.parse(firstItem['PC101.Alarm_Adver']),
  //               'PS27.Algun_Air_On':
  //                   firstItem['PS27.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS27.Num_Air_On': int.parse(firstItem['PS27.Num_Air_On']),
  //               'PS27.Alarm_Adver': int.parse(firstItem['PS27.Alarm_Adver']),
  //               'PS40.Algun_Air_On':
  //                   firstItem['PS40.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS40.Num_Air_On': int.parse(firstItem['PS40.Num_Air_On']),
  //               'PS40.Alarm_Adver': int.parse(firstItem['PS40.Alarm_Adver']),
  //               'PS41.Algun_Air_On':
  //                   firstItem['PS41.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS41.Num_Air_On': int.parse(firstItem['PS41.Num_Air_On']),
  //               'PS41.Alarm_Adver': int.parse(firstItem['PS41.Alarm_Adver']),
  //               'PS42.Algun_Air_On':
  //                   firstItem['PS42.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS42.Num_Air_On': int.parse(firstItem['PS42.Num_Air_On']),
  //               'PS42.Alarm_Adver': int.parse(firstItem['PS42.Alarm_Adver']),
  //               'PS43.Algun_Air_On':
  //                   firstItem['PS43.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS43.Num_Air_On': int.parse(firstItem['PS43.Num_Air_On']),
  //               'PS43.Alarm_Adver': int.parse(firstItem['PS43.Alarm_Adver']),
  //               'PS44.Algun_Air_On':
  //                   firstItem['PS44.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS44.Num_Air_On': int.parse(firstItem['PS44.Num_Air_On']),
  //               'PS44.Alarm_Adver': int.parse(firstItem['PS44.Alarm_Adver']),
  //               'PS45.Algun_Air_On':
  //                   firstItem['PS45.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS45.Num_Air_On': int.parse(firstItem['PS45.Num_Air_On']),
  //               'PS45.Alarm_Adver': int.parse(firstItem['PS45.Alarm_Adver']),
  //               'PS46.Algun_Air_On':
  //                   firstItem['PS46.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS46.Num_Air_On': int.parse(firstItem['PS46.Num_Air_On']),
  //               'PS46.Alarm_Adver': int.parse(firstItem['PS46.Alarm_Adver']),
  //               'PS47.Algun_Air_On':
  //                   firstItem['PS47.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS47.Num_Air_On': int.parse(firstItem['PS47.Num_Air_On']),
  //               'PS47.Alarm_Adver': int.parse(firstItem['PS47.Alarm_Adver']),
  //               'PS47B.Algun_Air_On':
  //                   firstItem['PS47B.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS47B.Num_Air_On': int.parse(firstItem['PS47B.Num_Air_On']),
  //               'PS47B.Alarm_Adver': int.parse(firstItem['PS47B.Alarm_Adver']),
  //               'PS48.Algun_Air_On':
  //                   firstItem['PS48.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS48.Num_Air_On': int.parse(firstItem['PS48.Num_Air_On']),
  //               'PS48.Alarm_Adver': int.parse(firstItem['PS48.Alarm_Adver']),
  //               'PS49.Algun_Air_On':
  //                   firstItem['PS49.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS49.Num_Air_On': int.parse(firstItem['PS49.Num_Air_On']),
  //               'PS49.Alarm_Adver': int.parse(firstItem['PS49.Alarm_Adver']),
  //               'PS50.Algun_Air_On':
  //                   firstItem['PS50.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS50.Num_Air_On': int.parse(firstItem['PS50.Num_Air_On']),
  //               'PS50.Alarm_Adver': int.parse(firstItem['PS50.Alarm_Adver']),
  //               'PS51.Algun_Air_On':
  //                   firstItem['PS51.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS51.Num_Air_On': int.parse(firstItem['PS51.Num_Air_On']),
  //               'PS51.Alarm_Adver': int.parse(firstItem['PS51.Alarm_Adver']),
  //               'PS52.Algun_Air_On':
  //                   firstItem['PS52.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS52.Num_Air_On': int.parse(firstItem['PS52.Num_Air_On']),
  //               'PS52.Alarm_Adver': int.parse(firstItem['PS52.Alarm_Adver']),
  //               'PS53.Algun_Air_On':
  //                   firstItem['PS53.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS53.Num_Air_On': int.parse(firstItem['PS53.Num_Air_On']),
  //               'PS53.Alarm_Adver': int.parse(firstItem['PS53.Alarm_Adver']),
  //               'PS54.Algun_Air_On':
  //                   firstItem['PS54.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS54.Num_Air_On': int.parse(firstItem['PS54.Num_Air_On']),
  //               'PS54.Alarm_Adver': int.parse(firstItem['PS54.Alarm_Adver']),
  //               'PS55.Algun_Air_On':
  //                   firstItem['PS55.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS55.Num_Air_On': int.parse(firstItem['PS55.Num_Air_On']),
  //               'PS55.Alarm_Adver': int.parse(firstItem['PS55.Alarm_Adver']),
  //               'PS56.Algun_Air_On':
  //                   firstItem['PS56.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS56.Num_Air_On': int.parse(firstItem['PS56.Num_Air_On']),
  //               'PS56.Alarm_Adver': int.parse(firstItem['PS56.Alarm_Adver']),
  //               'PS57.Algun_Air_On':
  //                   firstItem['PS57.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS57.Num_Air_On': int.parse(firstItem['PS57.Num_Air_On']),
  //               'PS57.Alarm_Adver': int.parse(firstItem['PS57.Alarm_Adver']),
  //               'PS58.Algun_Air_On':
  //                   firstItem['PS58.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS58.Num_Air_On': int.parse(firstItem['PS58.Num_Air_On']),
  //               'PS58.Alarm_Adver': int.parse(firstItem['PS58.Alarm_Adver']),
  //               'PS05.Algun_Air_On':
  //                   firstItem['PS05.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS05.Num_Air_On': int.parse(firstItem['PS05.Num_Air_On']),
  //               'PS05.Alarm_Adver': int.parse(firstItem['PS05.Alarm_Adver']),
  //               'PC102.Algun_Air_On':
  //                   firstItem['PC102.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC102.Num_Air_On': int.parse(firstItem['PC102.Num_Air_On']),
  //               'PC102.Alarm_Adver': int.parse(firstItem['PC102.Alarm_Adver']),
  //               'PC20.Algun_Air_On':
  //                   firstItem['PC20.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC20.Num_Air_On': int.parse(firstItem['PC20.Num_Air_On']),
  //               'PC20.Alarm_Adver': int.parse(firstItem['PC20.Alarm_Adver']),
  //               'PC106.Algun_Air_On':
  //                   firstItem['PC106.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC106.Num_Air_On': int.parse(firstItem['PC106.Num_Air_On']),
  //               'PC106.Alarm_Adver': int.parse(firstItem['PC106.Alarm_Adver']),
  //               'PC108.Algun_Air_On':
  //                   firstItem['PC108.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC108.Num_Air_On': int.parse(firstItem['PC108.Num_Air_On']),
  //               'PC108.Alarm_Adver': int.parse(firstItem['PC108.Alarm_Adver']),
  //               'PC111.Algun_Air_On':
  //                   firstItem['PC111.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC111.Num_Air_On': int.parse(firstItem['PC111.Num_Air_On']),
  //               'PC111.Alarm_Adver': int.parse(firstItem['PC111.Alarm_Adver']),
  //               'PC113.Algun_Air_On':
  //                   firstItem['PC113.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC113.Num_Air_On': int.parse(firstItem['PC113.Num_Air_On']),
  //               'PC113.Alarm_Adver': int.parse(firstItem['PC113.Alarm_Adver']),
  //               'PC114.Algun_Air_On':
  //                   firstItem['PC114.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC114.Num_Air_On': int.parse(firstItem['PC114.Num_Air_On']),
  //               'PC114.Alarm_Adver': int.parse(firstItem['PC114.Alarm_Adver']),
  //               'PC115.Algun_Air_On':
  //                   firstItem['PC115.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC115.Num_Air_On': int.parse(firstItem['PC115.Num_Air_On']),
  //               'PC115.Alarm_Adver': int.parse(firstItem['PC115.Alarm_Adver']),
  //               'PS08.Algun_Air_On':
  //                   firstItem['PS08.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS08.Num_Air_On': int.parse(firstItem['PS08.Num_Air_On']),
  //               'PS08.Alarm_Adver': int.parse(firstItem['PS08.Alarm_Adver']),
  //               'PC116.Algun_Air_On':
  //                   firstItem['PC116.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC116.Num_Air_On': int.parse(firstItem['PC116.Num_Air_On']),
  //               'PC116.Alarm_Adver': int.parse(firstItem['PC116.Alarm_Adver']),

  //               'PS34.Algun_Air_On':
  //                   firstItem['PS34.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS34.Num_Air_On': int.parse(firstItem['PS34.Num_Air_On']),
  //               'PS34.Alarm_Adver': int.parse(firstItem['PS34.Alarm_Adver']),
  //               'PC117.Algun_Air_On':
  //                   firstItem['PC117.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC117.Num_Air_On': int.parse(firstItem['PC117.Num_Air_On']),
  //               'PC117.Alarm_Adver': int.parse(firstItem['PC117.Alarm_Adver']),
  //               'PS24.Algun_Air_On':
  //                   firstItem['PS24.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS24.Num_Air_On': int.parse(firstItem['PS24.Num_Air_On']),
  //               'PS24.Alarm_Adver': int.parse(firstItem['PS24.Alarm_Adver']),
  //               //   'PC117.Algun_Air_On':
  //               //       firstItem['PC117.Algun_Air_On'].toLowerCase() == 'true',
  //               //   'PC117.Num_Air_On': int.parse(firstItem['PC117.Num_Air_On']),
  //               //   'PC117.Alarm_Adver': int.parse(firstItem['PC117.Alarm_Adver']),

  //               'PS10.Algun_Air_On':
  //                   firstItem['PS10.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS10.Num_Air_On': int.parse(firstItem['PS10.Num_Air_On']),
  //               'PS10.Alarm_Adver': int.parse(firstItem['PS10.Alarm_Adver']),
  //               'PS33.Algun_Air_On':
  //                   firstItem['PS33.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS33.Num_Air_On': int.parse(firstItem['PS33.Num_Air_On']),
  //               'PS33.Alarm_Adver': int.parse(firstItem['PS33.Alarm_Adver']),
  //               'PS01.Algun_Air_On':
  //                   firstItem['PS01.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS01.Num_Air_On': int.parse(firstItem['PS01.Num_Air_On']),
  //               'PS01.Alarm_Adver': int.parse(firstItem['PS01.Alarm_Adver']),
  //               'PS02.Algun_Air_On':
  //                   firstItem['PS02.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS02.Num_Air_On': int.parse(firstItem['PS02.Num_Air_On']),
  //               'PS02.Alarm_Adver': int.parse(firstItem['PS02.Alarm_Adver']),
  //               'PS03.Algun_Air_On':
  //                   firstItem['PS03.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS03.Num_Air_On': int.parse(firstItem['PS03.Num_Air_On']),
  //               'PS03.Alarm_Adver': int.parse(firstItem['PS03.Alarm_Adver']),
  //               'PS07.Algun_Air_On':
  //                   firstItem['PS07.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS07.Num_Air_On': int.parse(firstItem['PS07.Num_Air_On']),
  //               'PS07.Alarm_Adver': int.parse(firstItem['PS07.Alarm_Adver']),
  //               'PS09.Algun_Air_On':
  //                   firstItem['PS09.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS09.Num_Air_On': int.parse(firstItem['PS09.Num_Air_On']),
  //               'PS09.Alarm_Adver': int.parse(firstItem['PS09.Alarm_Adver']),
  //               'PS11.Algun_Air_On':
  //                   firstItem['PS11.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS11.Num_Air_On': int.parse(firstItem['PS11.Num_Air_On']),
  //               'PS11.Alarm_Adver': int.parse(firstItem['PS11.Alarm_Adver']),
  //               'PS13.Algun_Air_On':
  //                   firstItem['PS13.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS13.Num_Air_On': int.parse(firstItem['PS13.Num_Air_On']),
  //               'PS13.Alarm_Adver': int.parse(firstItem['PS13.Alarm_Adver']),
  //               'PS14.Algun_Air_On':
  //                   firstItem['PS14.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS14.Num_Air_On': int.parse(firstItem['PS14.Num_Air_On']),
  //               'PS14.Alarm_Adver': int.parse(firstItem['PS14.Alarm_Adver']),
  //               'PS15.Algun_Air_On':
  //                   firstItem['PS15.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS15.Num_Air_On': int.parse(firstItem['PS15.Num_Air_On']),
  //               'PS15.Alarm_Adver': int.parse(firstItem['PS15.Alarm_Adver']),
  //               'PS16.Algun_Air_On':
  //                   firstItem['PS16.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS16.Num_Air_On': int.parse(firstItem['PS16.Num_Air_On']),
  //               'PS16.Alarm_Adver': int.parse(firstItem['PS16.Alarm_Adver']),
  //               'PS17.Algun_Air_On':
  //                   firstItem['PS17.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS17.Num_Air_On': int.parse(firstItem['PS17.Num_Air_On']),
  //               'PS17.Alarm_Adver': int.parse(firstItem['PS17.Alarm_Adver']),
  //               'PS18.Algun_Air_On':
  //                   firstItem['PS18.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS18.Num_Air_On': int.parse(firstItem['PS18.Num_Air_On']),
  //               'PS18.Alarm_Adver': int.parse(firstItem['PS18.Alarm_Adver']),
  //               'PS19.Algun_Air_On':
  //                   firstItem['PS19.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS19.Num_Air_On': int.parse(firstItem['PS19.Num_Air_On']),
  //               'PS19.Alarm_Adver': int.parse(firstItem['PS19.Alarm_Adver']),
  //               'PS21.Algun_Air_On':
  //                   firstItem['PS21.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS21.Num_Air_On': int.parse(firstItem['PS21.Num_Air_On']),
  //               'PS21.Alarm_Adver': int.parse(firstItem['PS21.Alarm_Adver']),
  //               'PS22.Algun_Air_On':
  //                   firstItem['PS22.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS22.Num_Air_On': int.parse(firstItem['PS22.Num_Air_On']),
  //               'PS22.Alarm_Adver': int.parse(firstItem['PS22.Alarm_Adver']),
  //               'PS23.Algun_Air_On':
  //                   firstItem['PS23.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS23.Num_Air_On': int.parse(firstItem['PS23.Num_Air_On']),
  //               'PS23.Alarm_Adver': int.parse(firstItem['PS23.Alarm_Adver']),
  //               'PS25.Algun_Air_On':
  //                   firstItem['PS25.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS25.Num_Air_On': int.parse(firstItem['PS25.Num_Air_On']),
  //               'PS25.Alarm_Adver': int.parse(firstItem['PS25.Alarm_Adver']),
  //               'PS26.Algun_Air_On':
  //                   firstItem['PS26.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS26.Num_Air_On': int.parse(firstItem['PS26.Num_Air_On']),
  //               'PS26.Alarm_Adver': int.parse(firstItem['PS26.Alarm_Adver']),
  //               'PS28.Algun_Air_On':
  //                   firstItem['PS28.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS28.Num_Air_On': int.parse(firstItem['PS28.Num_Air_On']),
  //               'PS28.Alarm_Adver': int.parse(firstItem['PS28.Alarm_Adver']),
  //               'PS29.Algun_Air_On':
  //                   firstItem['PS29.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS29.Num_Air_On': int.parse(firstItem['PS29.Num_Air_On']),
  //               'PS29.Alarm_Adver': int.parse(firstItem['PS29.Alarm_Adver']),
  //               'PS31.Algun_Air_On':
  //                   firstItem['PS31.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS31.Num_Air_On': int.parse(firstItem['PS31.Num_Air_On']),
  //               'PS31.Alarm_Adver': int.parse(firstItem['PS31.Alarm_Adver']),
  //               'PS32.Algun_Air_On':
  //                   firstItem['PS32.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS32.Num_Air_On': int.parse(firstItem['PS32.Num_Air_On']),
  //               'PS32.Alarm_Adver': int.parse(firstItem['PS32.Alarm_Adver']),
  //               'PS35.Algun_Air_On':
  //                   firstItem['PS35.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS35.Num_Air_On': int.parse(firstItem['PS35.Num_Air_On']),
  //               'PS35.Alarm_Adver': int.parse(firstItem['PS35.Alarm_Adver']),
  //               'PS36.Algun_Air_On':
  //                   firstItem['PS36.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS36.Num_Air_On': int.parse(firstItem['PS36.Num_Air_On']),
  //               'PS36.Alarm_Adver': int.parse(firstItem['PS36.Alarm_Adver']),
  //               'PS37.Algun_Air_On':
  //                   firstItem['PS37.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS37.Num_Air_On': int.parse(firstItem['PS37.Num_Air_On']),
  //               'PS37.Alarm_Adver': int.parse(firstItem['PS37.Alarm_Adver']),
  //               'PS38.Algun_Air_On':
  //                   firstItem['PS38.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS38.Num_Air_On': int.parse(firstItem['PS38.Num_Air_On']),
  //               'PS38.Alarm_Adver': int.parse(firstItem['PS38.Alarm_Adver']),
  //               'PS39.Algun_Air_On':
  //                   firstItem['PS39.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS39.Num_Air_On': int.parse(firstItem['PS39.Num_Air_On']),
  //               'PS39.Alarm_Adver': int.parse(firstItem['PS39.Alarm_Adver']),
  //               'UDT_DATA_GLOB_Hora_Ini_1_GLOB':
  //                   firstItem['UDT_DATA_GLOB_Hora_Ini_1_GLOB']?.split('.')[0] ??
  //                       '00:00:00',
  //               'UDT_DATA_GLOB_Hora_Fin_2_GLOB':
  //                   firstItem['UDT_DATA_GLOB_Hora_Fin_2_GLOB']?.split('.')[0] ??
  //                       '00:00:00',
  //             });

  //             // Contar cuántas piscinas tienen estado false
  //             int piscinasOnCount = 0;
  //             firstItem.forEach((key, value) {
  //               if (key.endsWith('Num_Air_On') && int.parse(value) > 0) {
  //                 piscinasOnCount++;
  //               }
  //             });

  //             // Crear y agregar el objeto a apiDataListOffAntenas
  //             apiDataListOnPs.add({
  //               'PiscinasOn': piscinasOnCount.toString(),
  //             });

  //             // Antenas //

  //             apiDataListAntenas.add({
  //               'Pot_TA03-1': int.parse(itemAntenas['Pot_TA03-1']),
  //               'Pot_TA01-1': int.parse(itemAntenas['Pot_TA01-1']),
  //               'Pot_TA01-2': int.parse(itemAntenas['Pot_TA01-2']),
  //               'Pot_TA117-1': int.parse(itemAntenas['Pot_TA117-1']),
  //               'Pot_TA02-1': int.parse(itemAntenas['Pot_TA02-1']),
  //               'Pot_TA10-1': int.parse(itemAntenas['Pot_TA10-1']),
  //               'Pot_TA02-2': int.parse(itemAntenas['Pot_TA02-2']),
  //               'Pot_TA103-1': int.parse(itemAntenas['Pot_TA103-1']),
  //               'Pot_TA104-1': int.parse(itemAntenas['Pot_TA104-1']),
  //               'Pot_TA04-1': int.parse(itemAntenas['Pot_TA04-1']),
  //               'Pot_TA16-1': int.parse(itemAntenas['Pot_TA16-1']),
  //               'Pot_TA05-1': int.parse(itemAntenas['Pot_TA05-1']),
  //               'Pot_TA106-1': int.parse(itemAntenas['Pot_TA106-1']),
  //               'Pot_TA05-2': int.parse(itemAntenas['Pot_TA05-2']),
  //               'Pot_TA11-1': int.parse(itemAntenas['Pot_TA11-1']),
  //               'Pot_TA06-1': int.parse(itemAntenas['Pot_TA06-1']),
  //               'Pot_TA102-1': int.parse(itemAntenas['Pot_TA102-1']),
  //               'Pot_TA07-1': int.parse(itemAntenas['Pot_TA07-1']),
  //               'Pot_TA08-1': int.parse(itemAntenas['Pot_TA08-1']),
  //               'Pot_TA111-1': int.parse(itemAntenas['Pot_TA111-1']),
  //               'Pot_TA09-1': int.parse(itemAntenas['Pot_TA09-1']),
  //               'Pot_TA42-2': int.parse(itemAntenas['Pot_TA42-2']),
  //               'Pot_TA115-1': int.parse(itemAntenas['Pot_TA115-1']),
  //               'Pot_TA101-1': int.parse(itemAntenas['Pot_TA101-1']),
  //               'Pot_TA107-1': int.parse(itemAntenas['Pot_TA107-1']),
  //               'Pot_TA108-1': int.parse(itemAntenas['Pot_TA108-1']),
  //               'Pot_TA113-1': int.parse(itemAntenas['Pot_TA113-1']),
  //               'Pot_TA114-1': int.parse(itemAntenas['Pot_TA114-1']),
  //               'Pot_TA116-1': int.parse(itemAntenas['Pot_TA116-1']),
  //               'Pot_TA13-1': int.parse(itemAntenas['Pot_TA13-1']),
  //               'Pot_TA14-1': int.parse(itemAntenas['Pot_TA14-1']),
  //               'Pot_TA15-1': int.parse(itemAntenas['Pot_TA15-1']),
  //               'Pot_TA17-1': int.parse(itemAntenas['Pot_TA17-1']),
  //               'Pot_TA18-1': int.parse(itemAntenas['Pot_TA18-1']),
  //               'Pot_TA19-1': int.parse(itemAntenas['Pot_TA19-1']),
  //               'Pot_TA20-1': int.parse(itemAntenas['Pot_TA20-1']),
  //               'Pot_TA21-1': int.parse(itemAntenas['Pot_TA21-1']),
  //               'Pot_TA22-1': int.parse(itemAntenas['Pot_TA22-1']),
  //               'Pot_TA23-1': int.parse(itemAntenas['Pot_TA23-1']),
  //               'Pot_TA23-2': int.parse(itemAntenas['Pot_TA23-2']),
  //               'Pot_TA24-1': int.parse(itemAntenas['Pot_TA24-1']),
  //               'Pot_TA24-2': int.parse(itemAntenas['Pot_TA24-2']),
  //               'Pot_TA25-1': int.parse(itemAntenas['Pot_TA25-1']),
  //               'Pot_TA26-1': int.parse(itemAntenas['Pot_TA26-1']),
  //               'Pot_TA27-1': int.parse(itemAntenas['Pot_TA27-1']),
  //               'Pot_TA27-2': int.parse(itemAntenas['Pot_TA27-2']),
  //               'Pot_TA28-1': int.parse(itemAntenas['Pot_TA28-1']),
  //               'Pot_TA29-1': int.parse(itemAntenas['Pot_TA29-1']),
  //               'Pot_TA30-1': int.parse(itemAntenas['Pot_TA30-1']),
  //               'Pot_TA30-2': int.parse(itemAntenas['Pot_TA30-2']),
  //               'Pot_TA31-1': int.parse(itemAntenas['Pot_TA31-1']),
  //               'Pot_TA32-1': int.parse(itemAntenas['Pot_TA32-1']),
  //               'Pot_TA33-1': int.parse(itemAntenas['Pot_TA33-1']),
  //               'Pot_TA34-1': int.parse(itemAntenas['Pot_TA34-1']),
  //               'Pot_TA35-1': int.parse(itemAntenas['Pot_TA35-1']),
  //               'Pot_TA36-1': int.parse(itemAntenas['Pot_TA36-1']),
  //               'Pot_TA37-1': int.parse(itemAntenas['Pot_TA37-1']),
  //               'Pot_TA38-1': int.parse(itemAntenas['Pot_TA38-1']),
  //               'Pot_TA38-2': int.parse(itemAntenas['Pot_TA38-2']),
  //               'Pot_TA39-1': int.parse(itemAntenas['Pot_TA39-1']),
  //               'Pot_TA39-2': int.parse(itemAntenas['Pot_TA39-2']),
  //               'Pot_TA40-1': int.parse(itemAntenas['Pot_TA40-1']),
  //               'Pot_TA40-2': int.parse(itemAntenas['Pot_TA40-2']),
  //               'Pot_TA41-1': int.parse(itemAntenas['Pot_TA41-1']),
  //               'Pot_TA41-2': int.parse(itemAntenas['Pot_TA41-2']),
  //               'Pot_TA42-1': int.parse(itemAntenas['Pot_TA42-1']),
  //               'Pot_TA43-1': int.parse(itemAntenas['Pot_TA43-1']),
  //               'Pot_TA43-2': int.parse(itemAntenas['Pot_TA43-2']),
  //               'Pot_TA44-1': int.parse(itemAntenas['Pot_TA44-1']),
  //               'Pot_TA45-1': int.parse(itemAntenas['Pot_TA45-1']),
  //               'Pot_TA46-1': int.parse(itemAntenas['Pot_TA46-1']),
  //               'Pot_TA47-1': int.parse(itemAntenas['Pot_TA47-1']),
  //               'Pot_TA47B-1': int.parse(itemAntenas['Pot_TA47B-1']),
  //               'Pot_TA48-1': int.parse(itemAntenas['Pot_TA48-1']),
  //               'Pot_TA49-1': int.parse(itemAntenas['Pot_TA49-1']),
  //               'Pot_TA50-1': int.parse(itemAntenas['Pot_TA50-1']),
  //               'Pot_TA51-1': int.parse(itemAntenas['Pot_TA51-1']),
  //               'Pot_TA52-1': int.parse(itemAntenas['Pot_TA52-1']),
  //               'Pot_TA53-1': int.parse(itemAntenas['Pot_TA53-1']),
  //               'Pot_TA54-1': int.parse(itemAntenas['Pot_TA54-1']),
  //               'Pot_TA55-1': int.parse(itemAntenas['Pot_TA55-1']),
  //               'Pot_TA56-1': int.parse(itemAntenas['Pot_TA56-1']),
  //               'Pot_TA57-1': int.parse(itemAntenas['Pot_TA57-1']),
  //               'Pot_TA58-1': int.parse(itemAntenas['Pot_TA58-1']),
  //               'Pot_AP1-B': int.parse(itemAntenas['Pot_AP1-B']),
  //               'Pot_AP1': int.parse(itemAntenas['Pot-AP1']),
  //               'Pot_AP2': int.parse(itemAntenas['Pot-AP2']),
  //               'Pot_AP3': int.parse(itemAntenas['Pot-AP3']),
  //               'Pot_Camp-PTP-Mari':
  //                   int.parse(itemAntenas['Pot_Camp-PTP-Mari']),
  //               'Pot_EB_G1': int.parse(itemAntenas['Pot_EB_G1']),
  //               // 'Pot_EB_G2': int.parse(itemAntenas['Pot_EB_G2']),
  //               'Pot_PTP-Camp-T1': int.parse(itemAntenas['Pot_PTP-Camp-T1']),
  //               'Pot_PTP-Camp-T2': int.parse(itemAntenas['Pot_PTP-Camp-T2']),
  //               'Pot_PTP-Camp-T3': int.parse(itemAntenas['Pot_PTP-Camp-T3']),
  //               'Pot_PTP-Mari': int.parse(itemAntenas['Pot_PTP-Mari']),
  //               'Pot_PTP-T1': int.parse(itemAntenas['Pot_PTP-T1']),
  //               'Pot_PTP-T2': int.parse(itemAntenas['Pot_PTP-T2']),
  //               'Pot_PTP-T3': int.parse(itemAntenas['Pot_PTP-T3']),
  //               'Stat_TA13-1': itemAntenas['Stat_TA13-1'] == "TRUE",
  //               'Stat_TA39-2': itemAntenas['Stat_TA39-2'] == "TRUE",
  //               'Stat_TA114-1': itemAntenas['Stat_TA114-1'] == "TRUE",
  //               'Stat_TA37-1': itemAntenas['Stat_TA37-1'] == "TRUE",
  //               'Stat_TA01-1': itemAntenas['Stat_TA01-1'] == "TRUE",
  //               'Stat_TA49-1': itemAntenas['Stat_TA49-1'] == "TRUE",
  //               'Stat_TA01-2': itemAntenas['Stat_TA01-2'] == "TRUE",
  //               'Stat_TA15-1': itemAntenas['Stat_TA15-1'] == "TRUE",
  //               'Stat_TA40-2': itemAntenas['Stat_TA40-2'] == "TRUE",
  //               'Stat_TA115-1': itemAntenas['Stat_TA115-1'] == "TRUE",
  //               'Stat_TA02-1': itemAntenas['Stat_TA02-1'] == "TRUE",
  //               'Stat_TA02-2': itemAntenas['Stat_TA02-2'] == "TRUE",
  //               'Stat_TA03-1': itemAntenas['Stat_TA03-1'] == "TRUE",
  //               'Stat_TA101-1': itemAntenas['Stat_TA101-1'] == "TRUE",
  //               'Stat_TA104-1': itemAntenas['Stat_TA104-1'] == "TRUE",
  //               'Stat_TA07-1': itemAntenas['Stat_TA07-1'] == "TRUE",

  //               'Stat_TA29-1': itemAntenas['Stat_TA29-1'] == "TRUE",
  //               'Stat_TA04-1': itemAntenas['Stat_TA04-1'] == "TRUE",
  //               'Stat_TA42-2': itemAntenas['Stat_TA42-2'] == "TRUE",
  //               'Stat_TA14-1': itemAntenas['Stat_TA14-1'] == "TRUE",
  //               'Stat_TA05-1': itemAntenas['Stat_TA05-1'] == "TRUE",
  //               'Stat_TA05-2': itemAntenas['Stat_TA05-2'] == "TRUE",
  //               'Stat_TA17-1': itemAntenas['Stat_TA17-1'] == "TRUE",
  //               'Stat_PTP-Camp-T3': itemAntenas['Stat_PTP-Camp-T3'] == "TRUE",
  //               'Stat_TA06-1': itemAntenas['Stat_TA06-1'] == "TRUE",
  //               'Stat_TA107-1': itemAntenas['Stat_TA107-1'] == "TRUE",
  //               'Stat_TA32-1': itemAntenas['Stat_TA32-1'] == "TRUE",
  //               'Stat_TA45-1': itemAntenas['Stat_TA45-1'] == "TRUE",
  //               'Stat_TA08-1': itemAntenas['Stat_TA08-1'] == "TRUE",
  //               'Stat_TA18-1': itemAntenas['Stat_TA18-1'] == "TRUE",
  //               'Stat_TA09-1': itemAntenas['Stat_TA09-1'] == "TRUE",
  //               'Stat_TA10-1': itemAntenas['Stat_TA10-1'] == "TRUE",
  //               'Stat_TA102-1': itemAntenas['Stat_TA102-1'] == "TRUE",
  //               'Stat_TA103-1': itemAntenas['Stat_TA103-1'] == "TRUE",
  //               'Stat_TA106-1': itemAntenas['Stat_TA106-1'] == "TRUE",
  //               'Stat_TA108-1': itemAntenas['Stat_TA108-1'] == "TRUE",
  //               'Stat_TA11-1': itemAntenas['Stat_TA11-1'] == "TRUE",
  //               'Stat_TA111-1': itemAntenas['Stat_TA111-1'] == "TRUE",
  //               'Stat_TA113-1': itemAntenas['Stat_TA113-1'] == "TRUE",
  //               'Stat_TA116-1': itemAntenas['Stat_TA116-1'] == "TRUE",
  //               'Stat_TA117-1': itemAntenas['Stat_TA117-1'] == "TRUE",
  //               'Stat_TA16-1': itemAntenas['Stat_TA16-1'] == "TRUE",
  //               'Stat_TA19-1': itemAntenas['Stat_TA19-1'] == "TRUE",
  //               'Stat_TA20-1': itemAntenas['Stat_TA20-1'] == "TRUE",
  //               'Stat_TA21-1': itemAntenas['Stat_TA21-1'] == "TRUE",
  //               'Stat_TA22-1': itemAntenas['Stat_TA22-1'] == "TRUE",
  //               'Stat_TA23-1': itemAntenas['Stat_TA23-1'] == "TRUE",
  //               'Stat_TA23-2': itemAntenas['Stat_TA23-2'] == "TRUE",
  //               'Stat_TA24-1': itemAntenas['Stat_TA24-1'] == "TRUE",
  //               'Stat_TA24-2': itemAntenas['Stat_TA24-2'] == "TRUE",
  //               'Stat_TA25-1': itemAntenas['Stat_TA25-1'] == "TRUE",
  //               'Stat_TA26-1': itemAntenas['Stat_TA26-1'] == "TRUE",
  //               'Stat_TA27-1': itemAntenas['Stat_TA27-1'] == "TRUE",
  //               'Stat_TA27-2': itemAntenas['Stat_TA27-2'] == "TRUE",
  //               'Stat_TA28-1': itemAntenas['Stat_TA28-1'] == "TRUE",
  //               'Stat_TA30-1': itemAntenas['Stat_TA30-1'] == "TRUE",
  //               'Stat_TA30-2': itemAntenas['Stat_TA30-2'] == "TRUE",
  //               'Stat_TA31-1': itemAntenas['Stat_TA31-1'] == "TRUE",
  //               'Stat_TA33-1': itemAntenas['Stat_TA33-1'] == "TRUE",
  //               'Stat_TA34-1': itemAntenas['Stat_TA34-1'] == "TRUE",
  //               'Stat_TA35-1': itemAntenas['Stat_TA35-1'] == "TRUE",
  //               'Stat_TA36-1': itemAntenas['Stat_TA36-1'] == "TRUE",
  //               'Stat_TA38-1': itemAntenas['Stat_TA38-1'] == "TRUE",
  //               'Stat_TA38-2': itemAntenas['Stat_TA38-2'] == "TRUE",
  //               'Stat_TA39-1': itemAntenas['Stat_TA39-1'] == "TRUE",
  //               'Stat_TA40-1': itemAntenas['Stat_TA40-1'] == "TRUE",
  //               'Stat_TA41-1': itemAntenas['Stat_TA41-1'] == "TRUE",
  //               'Stat_TA41-2': itemAntenas['Stat_TA41-2'] == "TRUE",
  //               'Stat_TA42-1': itemAntenas['Stat_TA42-1'] == "TRUE",
  //               'Stat_TA43-1': itemAntenas['Stat_TA43-1'] == "TRUE",
  //               'Stat_TA43-2': itemAntenas['Stat_TA43-2'] == "TRUE",
  //               'Stat_TA44-1': itemAntenas['Stat_TA44-1'] == "TRUE",
  //               'Stat_TA46-1': itemAntenas['Stat_TA46-1'] == "TRUE",
  //               'Stat_TA47-1': itemAntenas['Stat_TA47-1'] == "TRUE",
  //               'Stat_TA47B-1': itemAntenas['Stat_TA47B-1'] == "TRUE",
  //               'Stat_TA48-1': itemAntenas['Stat_TA48-1'] == "TRUE",
  //               'Stat_TA50-1': itemAntenas['Stat_TA50-1'] == "TRUE",
  //               'Stat_TA51-1': itemAntenas['Stat_TA51-1'] == "TRUE",
  //               'Stat_TA52-1': itemAntenas['Stat_TA52-1'] == "TRUE",
  //               'Stat_TA53-1': itemAntenas['Stat_TA53-1'] == "TRUE",
  //               'Stat_TA54-1': itemAntenas['Stat_TA54-1'] == "TRUE",
  //               'Stat_TA55-1': itemAntenas['Stat_TA55-1'] == "TRUE",
  //               'Stat_TA56-1': itemAntenas['Stat_TA56-1'] == "TRUE",
  //               'Stat_TA57-1': itemAntenas['Stat_TA57-1'] == "TRUE",
  //               'Stat_TA58-1': itemAntenas['Stat_TA58-1'] == "TRUE",
  //               'Stat_AP1': itemAntenas['Stat_AP1'] == "TRUE",
  //               'Stat_AP1-B': itemAntenas['Stat_AP1-B'] == "TRUE",
  //               'Stat_AP2': itemAntenas['Stat_AP2'] == "TRUE",
  //               'Stat_AP3': itemAntenas['Stat_AP3'] == "TRUE",
  //               'Stat_Camp-PTP-Mari':
  //                   itemAntenas['Stat_Camp-PTP-Mari'] == "TRUE",
  //               'Stat_PTP-T1': itemAntenas['Stat_PTP-T1'] == "TRUE",
  //               'Stat_PTP-T2': itemAntenas['Stat_PTP-T2'] == "TRUE",
  //               'Stat_PTP-T3': itemAntenas['Stat_PTP-T3'] == "TRUE",
  //               'Stat_EB_G1': itemAntenas['Stat_EB_G1'] == "TRUE",
  //               'Stat_EB_G2': itemAntenas['Stat_EB_G2'] == "TRUE",
  //               'Stat_PTP-Camp-T1': itemAntenas['Stat_PTP-Camp-T1'] == "TRUE",
  //               'Stat_PTP-Camp-T2': itemAntenas['Stat_PTP-Camp-T2'] == "TRUE",
  //             });

  //             // Contar cuántas piscinas tienen estado false
  //             int antenasOffCount = 0;
  //             itemAntenas.forEach((key, value) {
  //               // print(value);
  //               if (key.startsWith('Stat') && value == 'FALSE') {
  //                 antenasOffCount++;
  //               }
  //             });

  //             // Crear y agregar el objeto a apiDataListOffAntenas
  //             apiDataListOffAntenas.add({
  //               'AntenasOff': antenasOffCount.toString(),
  //             });

  //             _apiDataListInfoGeneralPis.addAll([
  //               apiDataList,
  //               apiDataListOnPs,
  //               apiDataListAntenas,
  //               apiDataListOffAntenas
  //             ]);

  //             // print(_apiDataListInfoGeneralPis[1][0]);

  //             isLoading2 = false; // Finalizar el estado de cargando
  //             notifyListeners();
  //             // print(isLoading2);
  //             // print(_apiDataListPS01)
  //           }
  //         }, onError: (error) {
  //           isLoading2 = false; // Finalizar el estado de cargando
  //           _hasError = true; // Activar el estado de error
  //           // _errorMessage = error.toString(); // Almacenar mensaje de error
  //           // print('aaerrrrorrrrr');
  //           notifyListeners();
  //         });
  //       } else {}
  //     } catch (e) {
  //       // print('aaerrrrorrrrr');
  //     }
  //   }
  // }

  void subscribePiscinasAntenasAndInfoGeneral() {
    isLoading2 = true;
    _hasError = false;

    _subscribeTo('InfoGeneralPS');
    notifyListeners();

    if (subscriptionInfoGeneralPis == null) {
      notifyListeners();
      _apiDataListInfoGeneralPis.clear();
      List<Map<dynamic, dynamic>> apiDataList = [];
      List<Map<dynamic, dynamic>> apiDataListOnPs = [];
      List<Map<dynamic, dynamic>> apiDataListAntenas = [];
      List<Map<dynamic, dynamic>> apiDataListOffAntenas = [];

      try {
        if (_broadcastStream != null) {
          subscriptionInfoGeneralPis = _broadcastStream!.listen((event) {
            apiDataList.clear();
            apiDataListOnPs.clear();
            apiDataListAntenas.clear();
            apiDataListOffAntenas.clear();

            final decodedEvent = json.decode(event);
            if (decodedEvent.containsKey('InfoGeneralPS')) {
              // Verificar si todos los datos necesarios están presentes
              if (!_datosCompletos(decodedEvent)) {
                isLoading2 =
                    true; // Mantener en estado de carga si los datos están incompletos
                return; // No procesar datos incompletos
              }

              dynamic firstItem = decodedEvent['InfoGeneralPS'][0];
              dynamic itemAntenas = decodedEvent['Antenas'][0];

              try {
                // Procesar datos para apiDataList
                Map<String, dynamic> piscinasData = {};
                // Verificar y mapear todos los campos necesarios
                for (String piscina in _piscinasCamposRequeridos) {
                  if (!_verificarCamposPiscina(firstItem, piscina)) {
                    return; // Si faltan campos para alguna piscina, no continuar
                  }
                  piscinasData['$piscina.Algun_Air_On'] =
                      firstItem['$piscina.Algun_Air_On'].toLowerCase() ==
                          'true';
                  piscinasData['$piscina.Num_Air_On'] =
                      int.parse(firstItem['$piscina.Num_Air_On']);
                  piscinasData['$piscina.Alarm_Adver'] =
                      int.parse(firstItem['$piscina.Alarm_Adver']);
                }

                // Añadir campos horarios con verificación
                if (firstItem.containsKey('UDT_DATA_GLOB_Hora_Ini_1_GLOB')) {
                  piscinasData['UDT_DATA_GLOB_Hora_Ini_1_GLOB'] =
                      firstItem['UDT_DATA_GLOB_Hora_Ini_1_GLOB']
                              ?.split('.')[0] ??
                          '00:00:00';
                } else {
                  piscinasData['UDT_DATA_GLOB_Hora_Ini_1_GLOB'] = '00:00:00';
                }

                if (firstItem.containsKey('UDT_DATA_GLOB_Hora_Fin_2_GLOB')) {
                  piscinasData['UDT_DATA_GLOB_Hora_Fin_2_GLOB'] =
                      firstItem['UDT_DATA_GLOB_Hora_Fin_2_GLOB']
                              ?.split('.')[0] ??
                          '00:00:00';
                } else {
                  piscinasData['UDT_DATA_GLOB_Hora_Fin_2_GLOB'] = '00:00:00';
                }

                apiDataList.add(piscinasData);

                // Contar piscinas activas con verificación
                int piscinasOnCount = 0;
                firstItem.forEach((key, value) {
                  if (key.endsWith('Num_Air_On') && value != null) {
                    try {
                      if (int.parse(value) > 0) {
                        piscinasOnCount++;
                      }
                    } catch (e) {
                      // Ignorar errores de parseo
                    }
                  }
                });

                apiDataListOnPs.add({
                  'PiscinasOn': piscinasOnCount.toString(),
                });

                // Validar y procesar datos de antenas
                if (!_verificarCamposAntenas(itemAntenas)) {
                  return; // Si faltan campos de antenas, no continuar
                }

                // Procesar datos de antenas con verificación
                Map<String, dynamic> antenasData = {};
                for (String antena in _antenasCamposRequeridos) {
                  if (itemAntenas.containsKey('Pot_$antena')) {
                    antenasData['Pot_$antena'] =
                        _parseIntSafe(itemAntenas['Pot_$antena']);
                  }
                  if (itemAntenas.containsKey('Stat_$antena')) {
                    antenasData['Stat_$antena'] =
                        itemAntenas['Stat_$antena'] == "TRUE";
                  }
                }

                apiDataListAntenas.add(antenasData);

                // Contar antenas inactivas
                int antenasOffCount = 0;
                itemAntenas.forEach((key, value) {
                  if (key.startsWith('Stat') && value == 'FALSE') {
                    antenasOffCount++;
                  }
                });

                apiDataListOffAntenas.add({
                  'AntenasOff': antenasOffCount.toString(),
                });

                // Modificación a realizar dentro del bloque if donde actualizas _apiDataListInfoGeneralPis
                if (apiDataList.isNotEmpty &&
                    apiDataListOnPs.isNotEmpty &&
                    apiDataListAntenas.isNotEmpty &&
                    apiDataListOffAntenas.isNotEmpty) {
                  // Verificar que cada mapa dentro de cada lista tenga datos correctos
                  bool datosCompletos = _verificarDatosCompletos(
                      apiDataList,
                      apiDataListOnPs,
                      apiDataListAntenas,
                      apiDataListOffAntenas);

                  if (datosCompletos) {
                    _apiDataListInfoGeneralPis.clear();
                    _apiDataListInfoGeneralPis.addAll([
                      apiDataList,
                      apiDataListOnPs,
                      apiDataListAntenas,
                      apiDataListOffAntenas
                    ]);

                    isLoading2 = false;
                    notifyListeners();
                  } else {
                    // Si los datos no están completos, mantener el estado de carga
                    isLoading2 = true;
                    print(
                        "Datos incompletos detectados - no se actualizó el estado");
                  }
                }
              } catch (e) {
                print('Error procesando datos: $e');
                // No actualizar los datos cuando hay errores
              }
            }
          }, onError: (error) {
            isLoading2 = false;
            _hasError = true;
            notifyListeners();
          });
        }
      } catch (e) {
        print('Error en suscripción: $e');
      }
    }
  }

// Lista de campos requeridos para las piscinas
  final List<String> _piscinasCamposRequeridos = [
    'PS06', 'PC103', 'PC104', 'PC107', 'PS30', 'PS04', 'PC101', 'PS27', 'PS40',
    'PS41', 'PS42', 'PS43', 'PS44', 'PS45', 'PS46', 'PS47', 'PS47B', 'PS48',
    'PS49',
    'PS50', 'PS51', 'PS52', 'PS53', 'PS54', 'PS55', 'PS56', 'PS57', 'PS58',
    'PS05',
    'PC102', 'PC20', 'PC106', 'PC108', 'PC111', 'PC113', 'PC114', 'PC115',
    'PC116', 'PC117',
    'PS08', 'PS34', 'PS24', 'PS10', 'PS33', 'PS01', 'PS02', 'PS03', 'PS07',
    'PS09',
    'PS11', 'PS13', 'PS14', 'PS15', 'PS16', 'PS17', 'PS18', 'PS19', 'PS21',
    'PS22',
    'PS23', 'PS25', 'PS26', 'PS28', 'PS29', 'PS31', 'PS32', 'PS35', 'PS36',
    'PS37',
    'PS38', 'PS39'
    // Añade todas las piscinas necesarias aquí
  ];

// Lista de campos requeridos para las antenas
  final List<String> _antenasCamposRequeridos = [
    'TA03-1', 'TA01-1', 'TA01-2', 'TA117-1', 'TA02-1', 'TA10-1', 'TA02-2',
    'TA103-1', 'TA104-1', 'TA04-1', 'TA16-1', 'TA05-1', 'TA106-1', 'TA05-2',
    'TA11-1', 'TA06-1', 'TA102-1', 'TA07-1', 'TA08-1', 'TA111-1', 'TA09-1',
    'TA42-2', 'TA115-1', 'TA101-1', 'TA107-1', 'TA108-1', 'TA113-1', 'TA114-1',
    'TA116-1', 'TA13-1', 'TA14-1', 'TA15-1', 'TA17-1', 'TA18-1', 'TA19-1',
    'TA20-1', 'TA21-1', 'TA22-1', 'TA23-1', 'TA23-2', 'TA24-1', 'TA24-2',
    'TA25-1', 'TA26-1', 'TA27-1', 'TA27-2', 'TA28-1', 'TA29-1', 'TA30-1',
    'TA30-2', 'TA31-1', 'TA32-1', 'TA33-1', 'TA34-1', 'TA35-1', 'TA36-1',
    'TA37-1', 'TA38-1', 'TA38-2', 'TA39-1', 'TA39-2', 'TA40-1', 'TA40-2',
    'TA41-1', 'TA41-2', 'TA42-1', 'TA43-1', 'TA43-2', 'TA44-1', 'TA45-1',
    'TA46-1', 'TA47-1', 'TA47B-1', 'TA48-1', 'TA49-1', 'TA50-1', 'TA51-1',
    'TA52-1', 'TA53-1', 'TA54-1', 'TA55-1', 'TA56-1', 'TA57-1', 'TA58-1',
    'AP1-B', 'AP1', 'AP2', 'AP3', 'Camp-PTP-Mari', 'EB_G1', 'PTP-Camp-T1',
    'PTP-Camp-T2', 'PTP-Camp-T3', 'PTP-Mari', 'PTP-T1', 'PTP-T2', 'PTP-T3'
    // Añade todas las antenas necesarias aquí
  ];

// Verificar si todos los campos requeridos están presentes para una piscina
  bool _verificarCamposPiscina(dynamic item, String piscina) {
    return item != null &&
        item.containsKey('$piscina.Algun_Air_On') &&
        item.containsKey('$piscina.Num_Air_On') &&
        item.containsKey('$piscina.Alarm_Adver');
  }

// Verificar si los campos requeridos para antenas están presentes
  bool _verificarCamposAntenas(dynamic itemAntenas) {
    if (itemAntenas == null) return false;

    // Verificar al menos algunos campos esenciales
    bool tieneAlgunosPot = false;
    bool tieneAlgunosStat = false;

    for (String antena in _antenasCamposRequeridos) {
      if (itemAntenas.containsKey('Pot_$antena')) tieneAlgunosPot = true;
      if (itemAntenas.containsKey('Stat_$antena')) tieneAlgunosStat = true;
      if (tieneAlgunosPot && tieneAlgunosStat) return true;
    }

    return false;
  }

// Verificar si el evento tiene todos los datos necesarios
  bool _datosCompletos(Map<String, dynamic> evento) {
    if (!evento.containsKey('InfoGeneralPS') ||
        !evento.containsKey('Antenas') ||
        evento['InfoGeneralPS'] == null ||
        evento['InfoGeneralPS'].isEmpty ||
        evento['Antenas'] == null ||
        evento['Antenas'].isEmpty) {
      return false;
    }
    return true;
  }

// Parseo seguro de int
  int _parseIntSafe(dynamic valor) {
    if (valor == null) return 0;
    try {
      return int.parse(valor.toString());
    } catch (e) {
      return 0;
    }
  }

  // Añadir este método a tu clase PiscinasJosefinaProvider
  bool _verificarDatosCompletos(
      List<Map<dynamic, dynamic>> apiDataList,
      List<Map<dynamic, dynamic>> apiDataListOnPs,
      List<Map<dynamic, dynamic>> apiDataListAntenas,
      List<Map<dynamic, dynamic>> apiDataListOffAntenas) {
    // 1. Verificar datos de piscinas
    if (apiDataList.isEmpty || apiDataList[0].isEmpty) return false;

    // Verificar que los campos clave existan en apiDataList
    Map<dynamic, dynamic> piscinasData = apiDataList[0];
    for (String piscina in _piscinasCamposRequeridos) {
      if (!piscinasData.containsKey('$piscina.Algun_Air_On') ||
          !piscinasData.containsKey('$piscina.Num_Air_On') ||
          !piscinasData.containsKey('$piscina.Alarm_Adver')) {
        print("Faltan campos requeridos para $piscina");
        return false;
      }
    }

    // 2. Verificar datos del conteo de piscinas
    if (apiDataListOnPs.isEmpty || apiDataListOnPs[0].isEmpty) return false;
    if (!apiDataListOnPs[0].containsKey('PiscinasOn')) {
      print("Falta el contador PiscinasOn");
      return false;
    }

    // 3. Verificar datos de antenas
    if (apiDataListAntenas.isEmpty || apiDataListAntenas[0].isEmpty)
      return false;

    // Verificar al menos algunos campos clave de antenas
    Map<dynamic, dynamic> antenasData = apiDataListAntenas[0];
    bool tienePotencias = false;
    bool tieneEstados = false;

    for (String antena in _antenasCamposRequeridos) {
      if (antenasData.containsKey('Pot_$antena')) tienePotencias = true;
      if (antenasData.containsKey('Stat_$antena')) tieneEstados = true;
      if (tienePotencias && tieneEstados) break;
    }

    if (!tienePotencias || !tieneEstados) {
      print("Faltan datos de potencia o estado de antenas");
      return false;
    }

    // 4. Verificar contador de antenas offline
    if (apiDataListOffAntenas.isEmpty || apiDataListOffAntenas[0].isEmpty)
      return false;
    if (!apiDataListOffAntenas[0].containsKey('AntenasOff')) {
      print("Falta el contador AntenasOff");
      return false;
    }

    // Si todas las verificaciones pasan, los datos están completos
    return true;
  }

  static Future<dynamic> getPiscinasHistorialAireacionJosefina(
      Map<String, String> fechas, String baseUrl, String endpoint) async {
    try {
      // Construir la URL
      final url = Uri.parse('$baseUrl$endpoint');
      print(url);

      // Codificar las fechas en formato JSON
      final cuerpo = json.encode(fechas);
      final cabecera = {'Content-Type': 'application/json'};

      // Realizar la solicitud POST
      final respuesta = await http.post(url, headers: cabecera, body: cuerpo);
      print(respuesta);
      // Verificar el código de estado HTTP
      if (respuesta.statusCode == 200) {
        // Decodificar el cuerpo de la respuesta
        dynamic mapaRespuesta = json.decode(respuesta.body);
        print(mapaRespuesta);
        return mapaRespuesta; // Devolver los datos decodificados
      } else {
        // Manejar el error si la respuesta no fue exitosa
        throw Exception('Error al obtener datos: ${respuesta.statusCode}');
      }
    } catch (e) {
      // Manejo de cualquier error durante la solicitud o decodificación
      print('Error: $e');
      throw Exception('Fallo en la solicitud: $e');
    }
  }

  // void subscribePiscinasInfoGeneralGraca() {
  //   isLoading2 = true; // Comenzar el estado de cargando
  //   _hasError = false; // Reiniciar el estado de error

  //   _subscribeTo('InfoGeneralPS');
  //   notifyListeners();

  //   // print('qqqqq');

  //   if (subscriptionInfoGeneralPis == null) {
  //     _apiDataListInfoGeneralPis.clear();
  //     List<Map<dynamic, dynamic>> apiDataList = [];
  //     List<Map<dynamic, dynamic>> apiDataListOnPs = [];
  //     if (_broadcastStream != null) {
  //       subscriptionInfoGeneralPis = _broadcastStream!.listen((event) {
  //         apiDataList.clear();
  //         apiDataListOnPs.clear();
  //         final decodedEvent = json.decode(event);
  //         if (decodedEvent.containsKey('InfoGeneralPS')) {
  //           dynamic firstItem = decodedEvent['InfoGeneralPS'][0];

  //           apiDataList.add({
  //             'PS035.Algun_Air_On':
  //                 firstItem['PS035.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS035.Num_Air_On': int.parse(firstItem['PS035.Num_Air_On']),
  //             'PS035.Alarm_Adver': int.parse(firstItem['PS035.Alarm_Adver']),
  //             'PS34B.Algun_Air_On':
  //                 firstItem['PS34B.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS34B.Num_Air_On': int.parse(firstItem['PS34B.Num_Air_On']),
  //             'PS34B.Alarm_Adver': int.parse(firstItem['PS34B.Alarm_Adver']),
  //             'PC036.Algun_Air_On':
  //                 firstItem['PC036.Algun_Air_On'].toLowerCase() == 'true',
  //             'PC036.Num_Air_On': int.parse(firstItem['PC036.Num_Air_On']),
  //             'PC036.Alarm_Adver': int.parse(firstItem['PC036.Alarm_Adver']),
  //             'PS22B.Algun_Air_On':
  //                 firstItem['PS22B.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS22B.Num_Air_On': int.parse(firstItem['PS22B.Num_Air_On']),
  //             'PS22B.Alarm_Adver': int.parse(firstItem['PS22B.Alarm_Adver']),
  //             'PS22A.Algun_Air_On':
  //                 firstItem['PS22A.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS22A.Num_Air_On': int.parse(firstItem['PS22A.Num_Air_On']),
  //             'PS22A.Alarm_Adver': int.parse(firstItem['PS22A.Alarm_Adver']),
  //             'PS024.Algun_Air_On':
  //                 firstItem['PS024.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS024.Num_Air_On': int.parse(firstItem['PS024.Num_Air_On']),
  //             'PS024.Alarm_Adver': int.parse(firstItem['PS024.Alarm_Adver']),
  //             'PS025.Algun_Air_On':
  //                 firstItem['PS025.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS025.Num_Air_On': int.parse(firstItem['PS025.Num_Air_On']),
  //             'PS025.Alarm_Adver': int.parse(firstItem['PS025.Alarm_Adver']),
  //             'PS026.Algun_Air_On':
  //                 firstItem['PS026.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS026.Num_Air_On': int.parse(firstItem['PS026.Num_Air_On']),
  //             'PS026.Alarm_Adver': int.parse(firstItem['PS026.Alarm_Adver']),
  //             'PS027.Algun_Air_On':
  //                 firstItem['PS027.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS027.Num_Air_On': int.parse(firstItem['PS027.Num_Air_On']),
  //             'PS027.Alarm_Adver': int.parse(firstItem['PS027.Alarm_Adver']),
  //             'PS028.Algun_Air_On':
  //                 firstItem['PS028.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS028.Num_Air_On': int.parse(firstItem['PS028.Num_Air_On']),
  //             'PS028.Alarm_Adver': int.parse(firstItem['PS028.Alarm_Adver']),
  //             'PS029.Algun_Air_On':
  //                 firstItem['PS029.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS029.Num_Air_On': int.parse(firstItem['PS029.Num_Air_On']),
  //             'PS029.Alarm_Adver': int.parse(firstItem['PS029.Alarm_Adver']),
  //             'PS030.Algun_Air_On':
  //                 firstItem['PS030.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS030.Num_Air_On': int.parse(firstItem['PS030.Num_Air_On']),
  //             'PS030.Alarm_Adver': int.parse(firstItem['PS030.Alarm_Adver']),
  //             'PS031.Algun_Air_On':
  //                 firstItem['PS031.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS031.Num_Air_On': int.parse(firstItem['PS031.Num_Air_On']),
  //             'PS031.Alarm_Adver': int.parse(firstItem['PS031.Alarm_Adver']),
  //             'PS032.Algun_Air_On':
  //                 firstItem['PS032.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS032.Num_Air_On': int.parse(firstItem['PS032.Num_Air_On']),
  //             'PS032.Alarm_Adver': int.parse(firstItem['PS032.Alarm_Adver']),
  //             'PS33A.Algun_Air_On':
  //                 firstItem['PS33A.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS33A.Num_Air_On': int.parse(firstItem['PS33A.Num_Air_On']),
  //             'PS33A.Alarm_Adver': int.parse(firstItem['PS33A.Alarm_Adver']),
  //             'PS33B.Algun_Air_On':
  //                 firstItem['PS33B.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS33B.Num_Air_On': int.parse(firstItem['PS33B.Num_Air_On']),
  //             'PS33B.Alarm_Adver': int.parse(firstItem['PS33B.Alarm_Adver']),
  //             'PS039.Algun_Air_On':
  //                 firstItem['PS039.Algun_Air_On'].toLowerCase() == 'true',
  //             'PS039.Num_Air_On': int.parse(firstItem['PS039.Num_Air_On']),
  //             'PS039.Alarm_Adver': int.parse(firstItem['PS039.Alarm_Adver']),
  //           });

  //           // Contar cuántas piscinas tienen estado false
  //           int piscinasOnCount = 0;
  //           firstItem.forEach((key, value) {
  //             if (key.endsWith('Num_Air_On') && int.parse(value) > 0) {
  //               piscinasOnCount++;
  //             }
  //           });

  //           // Crear y agregar el objeto a apiDataListOffAntenas
  //           apiDataListOnPs.add({
  //             'PiscinasOn': piscinasOnCount.toString(),
  //           });

  //           _apiDataListInfoGeneralPis.addAll([apiDataList, apiDataListOnPs]);

  //           // print(_apiDataListInfoGeneralPis[1][0]);

  //           isLoading2 = false; // Finalizar el estado de cargando
  //           notifyListeners();
  //           // print(isLoading2);
  //           // print(_apiDataListPS01)
  //         }
  //       }, onError: (error) {
  //         isLoading2 = false; // Finalizar el estado de cargando
  //         _hasError = true; // Activar el estado de error
  //         _errorMessage = error.toString(); // Almacenar mensaje de error
  //         notifyListeners();
  //       });
  //     } else {}
  //   }
  // }

  // void subscribePiscinasAntenas() {
  //   isLoading2 = true; // Comenzar el estado de cargando
  //   _hasError = false; // Reiniciar el estado de error

  //   _subscribeTo('Antenas');
  //   notifyListeners();

  //   if (subscriptionAntenas == null) {
  //     // print('aaaaaaaaaaaaaa');
  //     _apiDataListAntenas.clear();
  //     List<Map<dynamic, dynamic>> apiDataList = [];
  //     List<Map<dynamic, dynamic>> apiDataListOffAntenas = [];
  //     if (_broadcastStream != null) {
  //       // print('aaaaaaaaaaaaaa');
  //       subscriptionAntenas = _broadcastStream!.listen((event) {
  //         apiDataList.clear();
  //         apiDataListOffAntenas.clear();
  //         final decodedEvent = json.decode(event);
  //         if (decodedEvent.containsKey('Antenas')) {
  //           dynamic itemAntenas = decodedEvent['Antenas'][0];

  //           apiDataList.add({
  //             'AP1_Potencia': int.parse(itemAntenas['AP1_Potencia']),
  //             'AP2_Potencia': int.parse(itemAntenas['AP2_Potencia']),
  //             'PtP_Torre_HMI_Potencia':
  //                 int.parse(itemAntenas['PtP_Torre_HMI_Potencia']),
  //             'PtP_HMI_Potencia': int.parse(itemAntenas['PtP_HMI_Potencia']),
  //             'PC36_TA01_Potencia':
  //                 int.parse(itemAntenas['PC36_TA01_Potencia']),
  //             'PC36_TA02_Potencia':
  //                 int.parse(itemAntenas['PC36_TA02_Potencia']),
  //             'PS24_TA01_Potencia':
  //                 int.parse(itemAntenas['PS24_TA01_Potencia']),
  //             'PS24_TA02_Potencia':
  //                 int.parse(itemAntenas['PS24_TA02_Potencia']),
  //             'PS24_TA03_Potencia':
  //                 int.parse(itemAntenas['PS24_TA03_Potencia']),
  //             'PS25_TA01_Potencia':
  //                 int.parse(itemAntenas['PS25_TA01_Potencia']),
  //             'PS25_TA02_Potencia':
  //                 int.parse(itemAntenas['PS25_TA02_Potencia']),
  //             'PS26_TA01_Potencia':
  //                 int.parse(itemAntenas['PS26_TA01_Potencia']),
  //             'PS26_TA02_Potencia':
  //                 int.parse(itemAntenas['PS26_TA02_Potencia']),
  //             'PS26_TA03_Potencia':
  //                 int.parse(itemAntenas['PS26_TA03_Potencia']),
  //             'PS27_TA01_Potencia':
  //                 int.parse(itemAntenas['PS27_TA01_Potencia']),
  //             'PS27_TA02_Potencia':
  //                 int.parse(itemAntenas['PS27_TA02_Potencia']),
  //             'PS28_TA01_Potencia':
  //                 int.parse(itemAntenas['PS28_TA01_Potencia']),
  //             'PS28_TA02_Potencia':
  //                 int.parse(itemAntenas['PS28_TA02_Potencia']),
  //             'PS28_TA03_Potencia':
  //                 int.parse(itemAntenas['PS28_TA03_Potencia']),
  //             'PS29_TA01_Potencia':
  //                 int.parse(itemAntenas['PS29_TA01_Potencia']),
  //             'PS29_TA02_Potencia':
  //                 int.parse(itemAntenas['PS29_TA02_Potencia']),
  //             'PS35_TA01_Potencia':
  //                 int.parse(itemAntenas['PS35_TA01_Potencia']),
  //             'PS35_TA02_Potencia':
  //                 int.parse(itemAntenas['PS35_TA02_Potencia']),
  //             'PS22A_TA01_Potencia':
  //                 int.parse(itemAntenas['PS22A_TA01_Potencia']),
  //             'PS22A_TA02_Potencia':
  //                 int.parse(itemAntenas['PS22A_TA02_Potencia']),
  //             'PS22B_TA01_Potencia':
  //                 int.parse(itemAntenas['PS22B_TA01_Potencia']),
  //             'PS22B_TA02_Potencia':
  //                 int.parse(itemAntenas['PS22B_TA02_Potencia']),
  //             'PS34B_TA01_Potencia':
  //                 int.parse(itemAntenas['PS34B_TA01_Potencia']),
  //             'PS34B_TA02_Potencia':
  //                 int.parse(itemAntenas['PS34B_TA02_Potencia']),
  //             'PS34B_TA03_Potencia':
  //                 int.parse(itemAntenas['PS34B_TA03_Potencia']),
  //             'PS34B_TA04_Potencia':
  //                 int.parse(itemAntenas['PS34B_TA04_Potencia']),
  //             'PS34B_TA05_Potencia':
  //                 int.parse(itemAntenas['PS34B_TA05_Potencia']),
  //             'PS34B_TA06_Potencia':
  //                 int.parse(itemAntenas['PS34B_TA06_Potencia']),
  //             'PS34B_TA07_Potencia':
  //                 int.parse(itemAntenas['PS34B_TA07_Potencia']),
  //             'PS30_TA01_Potencia':
  //                 int.parse(itemAntenas['PS30_TA01_Potencia']),
  //             'PS30_TA02_Potencia':
  //                 int.parse(itemAntenas['PS30_TA02_Potencia']),
  //             'PS30_TA03_Potencia':
  //                 int.parse(itemAntenas['PS30_TA03_Potencia']),
  //             'PS31_TA01_Potencia':
  //                 int.parse(itemAntenas['PS31_TA01_Potencia']),
  //             'PS31_TA02_Potencia':
  //                 int.parse(itemAntenas['PS31_TA02_Potencia']),
  //             'PS31_TA03_Potencia':
  //                 int.parse(itemAntenas['PS31_TA03_Potencia']),
  //             'PS31_TA04_Potencia':
  //                 int.parse(itemAntenas['PS31_TA04_Potencia']),
  //             'PS32_TA01_Potencia':
  //                 int.parse(itemAntenas['PS32_TA01_Potencia']),
  //             'PS32_TA02_Potencia':
  //                 int.parse(itemAntenas['PS32_TA02_Potencia']),
  //             'PS32_TA03_Potencia':
  //                 int.parse(itemAntenas['PS32_TA03_Potencia']),
  //             'PS32_TA04_Potencia':
  //                 int.parse(itemAntenas['PS32_TA04_Potencia']),
  //             'PS39_TA01_Potencia':
  //                 int.parse(itemAntenas['PS39_TA01_Potencia']),
  //             'PS39_TA02_Potencia':
  //                 int.parse(itemAntenas['PS39_TA02_Potencia']),
  //             'PS39_TA03_Potencia':
  //                 int.parse(itemAntenas['PS39_TA03_Potencia']),
  //             'PS33A_TA01_Potencia':
  //                 int.parse(itemAntenas['PS33A_TA01_Potencia']),
  //             'PS33A_TA02_Potencia':
  //                 int.parse(itemAntenas['PS33A_TA02_Potencia']),
  //             'PS33A_TA03_Potencia':
  //                 int.parse(itemAntenas['PS33A_TA03_Potencia']),
  //             'PS33B_TA01_Potencia':
  //                 int.parse(itemAntenas['PS33B_TA01_Potencia']),
  //             'PS33B_TA02_Potencia':
  //                 int.parse(itemAntenas['PS33B_TA02_Potencia']),
  //             'PS33B_TA03_Potencia':
  //                 int.parse(itemAntenas['PS33B_TA03_Potencia']),
  //             'AP1_Status': itemAntenas['AP1_Status'].toLowerCase() == 'true',
  //             'AP2_Status': itemAntenas['AP2_Status'].toLowerCase() == 'true',
  //             'PtP_Torre_HMI_Status':
  //                 itemAntenas['PtP_Torre_HMI_Status'].toLowerCase() == 'true',
  //             'PtP_HMI_Status':
  //                 itemAntenas['PtP_HMI_Status'].toLowerCase() == 'true',
  //             'PC36_TA01_Status':
  //                 itemAntenas['PC36_TA01_Status'].toLowerCase() == 'true',
  //             'PC36_TA02_Status':
  //                 itemAntenas['PC36_TA02_Status'].toLowerCase() == 'true',
  //             'PS24_TA01_Status':
  //                 itemAntenas['PS24_TA01_Status'].toLowerCase() == 'true',
  //             'PS24_TA02_Status':
  //                 itemAntenas['PS24_TA02_Status'].toLowerCase() == 'true',
  //             'PS24_TA03_Status':
  //                 itemAntenas['PS24_TA03_Status'].toLowerCase() == 'true',
  //             'PS25_TA01_Status':
  //                 itemAntenas['PS25_TA01_Status'].toLowerCase() == 'true',
  //             'PS25_TA02_Status':
  //                 itemAntenas['PS25_TA02_Status'].toLowerCase() == 'true',
  //             'PS26_TA01_Status':
  //                 itemAntenas['PS26_TA01_Status'].toLowerCase() == 'true',
  //             'PS26_TA02_Status':
  //                 itemAntenas['PS26_TA02_Status'].toLowerCase() == 'true',
  //             'PS26_TA03_Status':
  //                 itemAntenas['PS26_TA03_Status'].toLowerCase() == 'true',
  //             'PS27_TA01_Status':
  //                 itemAntenas['PS27_TA01_Status'].toLowerCase() == 'true',
  //             'PS27_TA02_Status':
  //                 itemAntenas['PS27_TA02_Status'].toLowerCase() == 'true',
  //             'PS28_TA01_Status':
  //                 itemAntenas['PS28_TA01_Status'].toLowerCase() == 'true',
  //             'PS28_TA02_Status':
  //                 itemAntenas['PS28_TA02_Status'].toLowerCase() == 'true',
  //             'PS28_TA03_Status':
  //                 itemAntenas['PS28_TA03_Status'].toLowerCase() == 'true',
  //             'PS29_TA01_Status':
  //                 itemAntenas['PS29_TA01_Status'].toLowerCase() == 'true',
  //             'PS29_TA02_Status':
  //                 itemAntenas['PS29_TA02_Status'].toLowerCase() == 'true',
  //             'PS35_TA01_Status':
  //                 itemAntenas['PS35_TA01_Status'].toLowerCase() == 'true',
  //             'PS35_TA02_Status':
  //                 itemAntenas['PS35_TA02_Status'].toLowerCase() == 'true',
  //             'PS22A_TA01_Status':
  //                 itemAntenas['PS22A_TA01_Status'].toLowerCase() == 'true',
  //             'PS22A_TA02_Status':
  //                 itemAntenas['PS22A_TA02_Status'].toLowerCase() == 'true',
  //             'PS22B_TA01_Status':
  //                 itemAntenas['PS22B_TA01_Status'].toLowerCase() == 'true',
  //             'PS22B_TA02_Status':
  //                 itemAntenas['PS22B_TA02_Status'].toLowerCase() == 'true',
  //             'PS34B_TA01_Status':
  //                 itemAntenas['PS34B_TA01_Status'].toLowerCase() == 'true',
  //             'PS34B_TA02_Status':
  //                 itemAntenas['PS34B_TA02_Status'].toLowerCase() == 'true',
  //             'PS34B_TA03_Status':
  //                 itemAntenas['PS34B_TA03_Status'].toLowerCase() == 'true',
  //             'PS34B_TA04_Status':
  //                 itemAntenas['PS34B_TA04_Status'].toLowerCase() == 'true',
  //             'PS34B_TA05_Status':
  //                 itemAntenas['PS34B_TA05_Status'].toLowerCase() == 'true',
  //             'PS34B_TA06_Status':
  //                 itemAntenas['PS34B_TA06_Status'].toLowerCase() == 'true',
  //             'PS34B_TA07_Status':
  //                 itemAntenas['PS34B_TA07_Status'].toLowerCase() == 'true',
  //             'PS30_TA01_Status':
  //                 itemAntenas['PS30_TA01_Status'].toLowerCase() == 'true',
  //             'PS30_TA02_Status':
  //                 itemAntenas['PS30_TA02_Status'].toLowerCase() == 'true',
  //             'PS30_TA03_Status':
  //                 itemAntenas['PS30_TA03_Status'].toLowerCase() == 'true',
  //             'PS31_TA01_Status':
  //                 itemAntenas['PS31_TA01_Status'].toLowerCase() == 'true',
  //             'PS31_TA02_Status':
  //                 itemAntenas['PS31_TA02_Status'].toLowerCase() == 'true',
  //             'PS31_TA03_Status':
  //                 itemAntenas['PS31_TA03_Status'].toLowerCase() == 'true',
  //             'PS31_TA04_Status':
  //                 itemAntenas['PS31_TA04_Status'].toLowerCase() == 'true',
  //             'PS32_TA01_Status':
  //                 itemAntenas['PS32_TA01_Status'].toLowerCase() == 'true',
  //             'PS32_TA02_Status':
  //                 itemAntenas['PS32_TA02_Status'].toLowerCase() == 'true',
  //             'PS32_TA03_Status':
  //                 itemAntenas['PS32_TA03_Status'].toLowerCase() == 'true',
  //             'PS32_TA04_Status':
  //                 itemAntenas['PS32_TA04_Status'].toLowerCase() == 'true',
  //             'PS39_TA01_Status':
  //                 itemAntenas['PS39_TA01_Status'].toLowerCase() == 'true',
  //             'PS39_TA02_Status':
  //                 itemAntenas['PS39_TA02_Status'].toLowerCase() == 'true',
  //             'PS39_TA03_Status':
  //                 itemAntenas['PS39_TA03_Status'].toLowerCase() == 'true',
  //             'PS33A_TA01_Status':
  //                 itemAntenas['PS33A_TA01_Status'].toLowerCase() == 'true',
  //             'PS33A_TA02_Status':
  //                 itemAntenas['PS33A_TA02_Status'].toLowerCase() == 'true',
  //             'PS33A_TA03_Status':
  //                 itemAntenas['PS33A_TA03_Status'].toLowerCase() == 'true',
  //             'PS33B_TA01_Status':
  //                 itemAntenas['PS33B_TA01_Status'].toLowerCase() == 'true',
  //             'PS33B_TA02_Status':
  //                 itemAntenas['PS33B_TA02_Status'].toLowerCase() == 'true',
  //             'PS33B_TA03_Status':
  //                 itemAntenas['PS33B_TA03_Status'].toLowerCase() == 'true',
  //           });

  //           // Contar cuántas piscinas tienen estado false
  //           int antenasOffCount = 0;
  //           itemAntenas.forEach((key, value) {
  //             if (key.endsWith('_Status') && value.toLowerCase() == 'false') {
  //               antenasOffCount++;
  //             }
  //           });

  //           // Crear y agregar el objeto a apiDataListOffAntenas
  //           apiDataListOffAntenas.add({
  //             'AntenasOff': antenasOffCount.toString(),
  //           });

  //           _apiDataListAntenas.addAll([apiDataList, apiDataListOffAntenas]);

  //           // print(_apiDataListInfoGeneralPis);

  //           isLoading2 = false; // Finalizar el estado de cargando
  //           notifyListeners();
  //           // print(isLoading2);
  //           // print(_apiDataListAntenas);
  //         }
  //       }, onError: (error) {
  //         isLoading2 = false; // Finalizar el estado de cargando
  //         _hasError = true; // Activar el estado de error
  //         _errorMessage = error.toString(); // Almacenar mensaje de error
  //         notifyListeners();
  //       });
  //     } else {}
  //   }
  // }

  // void subscribePiscinasAntenasAndInfoGeneral() {
  //   isLoading2 = true; // Comenzar el estado de cargando
  //   _hasError = false; // Reiniciar el estado de error

  //   _subscribeTo('InfoGeneralPS');
  //   notifyListeners();

  //   // print('qqqqq');

  //   if (subscriptionInfoGeneralPis == null) {
  //     // _apiDataListInfoGeneralPisSaved.add(_apiDataListInfoGeneralPis);
  //     notifyListeners();
  //     // print('Eliminandoooo');
  //     _apiDataListInfoGeneralPis.clear();
  //     List<Map<dynamic, dynamic>> apiDataList = [];
  //     List<Map<dynamic, dynamic>> apiDataListOnPs = [];
  //     List<Map<dynamic, dynamic>> apiDataListAntenas = [];
  //     List<Map<dynamic, dynamic>> apiDataListOffAntenas = [];

  //     try {
  //       if (_broadcastStream != null) {
  //         subscriptionInfoGeneralPis = _broadcastStream!.listen((event) {
  //           // print('Aquiii');
  //           apiDataList.clear();
  //           apiDataListOnPs.clear();
  //           apiDataListAntenas.clear();
  //           apiDataListOffAntenas.clear();

  //           final decodedEvent = json.decode(event);
  //           if (decodedEvent.containsKey('InfoGeneralPS')) {
  //             dynamic firstItem = decodedEvent['InfoGeneralPS'][0];
  //             dynamic itemAntenas = decodedEvent['Antenas'][0];

  //             apiDataList.add({
  //               'PS035.Algun_Air_On':
  //                   firstItem['PS035.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS035.Num_Air_On': int.parse(firstItem['PS035.Num_Air_On']),
  //               'PS035.Alarm_Adver': int.parse(firstItem['PS035.Alarm_Adver']),
  //               'PS34B.Algun_Air_On':
  //                   firstItem['PS34B.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS34B.Num_Air_On': int.parse(firstItem['PS34B.Num_Air_On']),
  //               'PS34B.Alarm_Adver': int.parse(firstItem['PS34B.Alarm_Adver']),
  //               'PC036.Algun_Air_On':
  //                   firstItem['PC036.Algun_Air_On'].toLowerCase() == 'true',
  //               'PC036.Num_Air_On': int.parse(firstItem['PC036.Num_Air_On']),
  //               'PC036.Alarm_Adver': int.parse(firstItem['PC036.Alarm_Adver']),
  //               'PS22B.Algun_Air_On':
  //                   firstItem['PS22B.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS22B.Num_Air_On': int.parse(firstItem['PS22B.Num_Air_On']),
  //               'PS22B.Alarm_Adver': int.parse(firstItem['PS22B.Alarm_Adver']),
  //               'PS22A.Algun_Air_On':
  //                   firstItem['PS22A.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS22A.Num_Air_On': int.parse(firstItem['PS22A.Num_Air_On']),
  //               'PS22A.Alarm_Adver': int.parse(firstItem['PS22A.Alarm_Adver']),
  //               'PS024.Algun_Air_On':
  //                   firstItem['PS024.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS024.Num_Air_On': int.parse(firstItem['PS024.Num_Air_On']),
  //               'PS024.Alarm_Adver': int.parse(firstItem['PS024.Alarm_Adver']),
  //               'PS025.Algun_Air_On':
  //                   firstItem['PS025.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS025.Num_Air_On': int.parse(firstItem['PS025.Num_Air_On']),
  //               'PS025.Alarm_Adver': int.parse(firstItem['PS025.Alarm_Adver']),
  //               'PS026.Algun_Air_On':
  //                   firstItem['PS026.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS026.Num_Air_On': int.parse(firstItem['PS026.Num_Air_On']),
  //               'PS026.Alarm_Adver': int.parse(firstItem['PS026.Alarm_Adver']),
  //               'PS027.Algun_Air_On':
  //                   firstItem['PS027.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS027.Num_Air_On': int.parse(firstItem['PS027.Num_Air_On']),
  //               'PS027.Alarm_Adver': int.parse(firstItem['PS027.Alarm_Adver']),
  //               'PS028.Algun_Air_On':
  //                   firstItem['PS028.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS028.Num_Air_On': int.parse(firstItem['PS028.Num_Air_On']),
  //               'PS028.Alarm_Adver': int.parse(firstItem['PS028.Alarm_Adver']),
  //               'PS029.Algun_Air_On':
  //                   firstItem['PS029.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS029.Num_Air_On': int.parse(firstItem['PS029.Num_Air_On']),
  //               'PS029.Alarm_Adver': int.parse(firstItem['PS029.Alarm_Adver']),
  //               'PS030.Algun_Air_On':
  //                   firstItem['PS030.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS030.Num_Air_On': int.parse(firstItem['PS030.Num_Air_On']),
  //               'PS030.Alarm_Adver': int.parse(firstItem['PS030.Alarm_Adver']),
  //               'PS031.Algun_Air_On':
  //                   firstItem['PS031.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS031.Num_Air_On': int.parse(firstItem['PS031.Num_Air_On']),
  //               'PS031.Alarm_Adver': int.parse(firstItem['PS031.Alarm_Adver']),
  //               'PS032.Algun_Air_On':
  //                   firstItem['PS032.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS032.Num_Air_On': int.parse(firstItem['PS032.Num_Air_On']),
  //               'PS032.Alarm_Adver': int.parse(firstItem['PS032.Alarm_Adver']),
  //               'PS33A.Algun_Air_On':
  //                   firstItem['PS33A.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS33A.Num_Air_On': int.parse(firstItem['PS33A.Num_Air_On']),
  //               'PS33A.Alarm_Adver': int.parse(firstItem['PS33A.Alarm_Adver']),
  //               'PS33B.Algun_Air_On':
  //                   firstItem['PS33B.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS33B.Num_Air_On': int.parse(firstItem['PS33B.Num_Air_On']),
  //               'PS33B.Alarm_Adver': int.parse(firstItem['PS33B.Alarm_Adver']),
  //               'PS039.Algun_Air_On':
  //                   firstItem['PS039.Algun_Air_On'].toLowerCase() == 'true',
  //               'PS039.Num_Air_On': int.parse(firstItem['PS039.Num_Air_On']),
  //               'PS039.Alarm_Adver': int.parse(firstItem['PS039.Alarm_Adver']),
  //               'Hora_Ini_1_GLOB': firstItem['Hora_Ini_1_GLOB'],
  //               'Hora_Ini_2_GLOB': firstItem['Hora_Ini_2_GLOB'],
  //               'Hora_Fin_1_GLOB': firstItem['Hora_Fin_1_GLOB'],
  //               'Hora_Fin_2_GLOB': firstItem['Hora_Fin_2_GLOB'],
  //             });

  //             // Contar cuántas piscinas tienen estado false
  //             int piscinasOnCount = 0;
  //             firstItem.forEach((key, value) {
  //               if (key.endsWith('Num_Air_On') && int.parse(value) > 0) {
  //                 piscinasOnCount++;
  //               }
  //             });

  //             // Crear y agregar el objeto a apiDataListOffAntenas
  //             apiDataListOnPs.add({
  //               'PiscinasOn': piscinasOnCount.toString(),
  //             });

  //             // Antenas //

  //             apiDataListAntenas.add({
  //               'AP1_Potencia': int.parse(itemAntenas['AP1_Potencia']),
  //               'AP2_Potencia': int.parse(itemAntenas['AP2_Potencia']),
  //               'PtP_Torre_HMI_Potencia':
  //                   int.parse(itemAntenas['PtP_Torre_HMI_Potencia']),
  //               'PtP_HMI_Potencia': int.parse(itemAntenas['PtP_HMI_Potencia']),
  //               'PC36_TA01_Potencia':
  //                   int.parse(itemAntenas['PC36_TA01_Potencia']),
  //               'PC36_TA02_Potencia':
  //                   int.parse(itemAntenas['PC36_TA02_Potencia']),
  //               'PS24_TA01_Potencia':
  //                   int.parse(itemAntenas['PS24_TA01_Potencia']),
  //               'PS24_TA02_Potencia':
  //                   int.parse(itemAntenas['PS24_TA02_Potencia']),
  //               'PS24_TA03_Potencia':
  //                   int.parse(itemAntenas['PS24_TA03_Potencia']),
  //               'PS25_TA01_Potencia':
  //                   int.parse(itemAntenas['PS25_TA01_Potencia']),
  //               'PS25_TA02_Potencia':
  //                   int.parse(itemAntenas['PS25_TA02_Potencia']),
  //               'PS26_TA01_Potencia':
  //                   int.parse(itemAntenas['PS26_TA01_Potencia']),
  //               'PS26_TA02_Potencia':
  //                   int.parse(itemAntenas['PS26_TA02_Potencia']),
  //               'PS26_TA03_Potencia':
  //                   int.parse(itemAntenas['PS26_TA03_Potencia']),
  //               'PS27_TA01_Potencia':
  //                   int.parse(itemAntenas['PS27_TA01_Potencia']),
  //               'PS27_TA02_Potencia':
  //                   int.parse(itemAntenas['PS27_TA02_Potencia']),
  //               'PS28_TA01_Potencia':
  //                   int.parse(itemAntenas['PS28_TA01_Potencia']),
  //               'PS28_TA02_Potencia':
  //                   int.parse(itemAntenas['PS28_TA02_Potencia']),
  //               'PS28_TA03_Potencia':
  //                   int.parse(itemAntenas['PS28_TA03_Potencia']),
  //               'PS29_TA01_Potencia':
  //                   int.parse(itemAntenas['PS29_TA01_Potencia']),
  //               'PS29_TA02_Potencia':
  //                   int.parse(itemAntenas['PS29_TA02_Potencia']),
  //               'PS35_TA01_Potencia':
  //                   int.parse(itemAntenas['PS35_TA01_Potencia']),
  //               'PS35_TA02_Potencia':
  //                   int.parse(itemAntenas['PS35_TA02_Potencia']),
  //               'PS22A_TA01_Potencia':
  //                   int.parse(itemAntenas['PS22A_TA01_Potencia']),
  //               'PS22A_TA02_Potencia':
  //                   int.parse(itemAntenas['PS22A_TA02_Potencia']),
  //               'PS22B_TA01_Potencia':
  //                   int.parse(itemAntenas['PS22B_TA01_Potencia']),
  //               'PS22B_TA02_Potencia':
  //                   int.parse(itemAntenas['PS22B_TA02_Potencia']),
  //               'PS34B_TA01_Potencia':
  //                   int.parse(itemAntenas['PS34B_TA01_Potencia']),
  //               'PS34B_TA02_Potencia':
  //                   int.parse(itemAntenas['PS34B_TA02_Potencia']),
  //               'PS34B_TA03_Potencia':
  //                   int.parse(itemAntenas['PS34B_TA03_Potencia']),
  //               'PS34B_TA04_Potencia':
  //                   int.parse(itemAntenas['PS34B_TA04_Potencia']),
  //               'PS34B_TA05_Potencia':
  //                   int.parse(itemAntenas['PS34B_TA05_Potencia']),
  //               'PS34B_TA06_Potencia':
  //                   int.parse(itemAntenas['PS34B_TA06_Potencia']),
  //               'PS34B_TA07_Potencia':
  //                   int.parse(itemAntenas['PS34B_TA07_Potencia']),
  //               'PS30_TA01_Potencia':
  //                   int.parse(itemAntenas['PS30_TA01_Potencia']),
  //               'PS30_TA02_Potencia':
  //                   int.parse(itemAntenas['PS30_TA02_Potencia']),
  //               'PS30_TA03_Potencia':
  //                   int.parse(itemAntenas['PS30_TA03_Potencia']),
  //               'PS31_TA01_Potencia':
  //                   int.parse(itemAntenas['PS31_TA01_Potencia']),
  //               'PS31_TA02_Potencia':
  //                   int.parse(itemAntenas['PS31_TA02_Potencia']),
  //               'PS31_TA03_Potencia':
  //                   int.parse(itemAntenas['PS31_TA03_Potencia']),
  //               'PS31_TA04_Potencia':
  //                   int.parse(itemAntenas['PS31_TA04_Potencia']),
  //               'PS32_TA01_Potencia':
  //                   int.parse(itemAntenas['PS32_TA01_Potencia']),
  //               'PS32_TA02_Potencia':
  //                   int.parse(itemAntenas['PS32_TA02_Potencia']),
  //               'PS32_TA03_Potencia':
  //                   int.parse(itemAntenas['PS32_TA03_Potencia']),
  //               'PS32_TA04_Potencia':
  //                   int.parse(itemAntenas['PS32_TA04_Potencia']),
  //               'PS39_TA01_Potencia':
  //                   int.parse(itemAntenas['PS39_TA01_Potencia']),
  //               'PS39_TA02_Potencia':
  //                   int.parse(itemAntenas['PS39_TA02_Potencia']),
  //               'PS39_TA03_Potencia':
  //                   int.parse(itemAntenas['PS39_TA03_Potencia']),
  //               'PS33A_TA01_Potencia':
  //                   int.parse(itemAntenas['PS33A_TA01_Potencia']),
  //               'PS33A_TA02_Potencia':
  //                   int.parse(itemAntenas['PS33A_TA02_Potencia']),
  //               'PS33A_TA03_Potencia':
  //                   int.parse(itemAntenas['PS33A_TA03_Potencia']),
  //               'PS33B_TA01_Potencia':
  //                   int.parse(itemAntenas['PS33B_TA01_Potencia']),
  //               'PS33B_TA02_Potencia':
  //                   int.parse(itemAntenas['PS33B_TA02_Potencia']),
  //               'PS33B_TA03_Potencia':
  //                   int.parse(itemAntenas['PS33B_TA03_Potencia']),
  //               'AP1_Status': itemAntenas['AP1_Status'].toLowerCase() == 'true',
  //               'AP2_Status': itemAntenas['AP2_Status'].toLowerCase() == 'true',
  //               'PtP_Torre_HMI_Status':
  //                   itemAntenas['PtP_Torre_HMI_Status'].toLowerCase() == 'true',
  //               'PtP_HMI_Status':
  //                   itemAntenas['PtP_HMI_Status'].toLowerCase() == 'true',
  //               'PC36_TA01_Status':
  //                   itemAntenas['PC36_TA01_Status'].toLowerCase() == 'true',
  //               'PC36_TA02_Status':
  //                   itemAntenas['PC36_TA02_Status'].toLowerCase() == 'true',
  //               'PS22A_TA01_Status':
  //                   itemAntenas['PS22A_TA01_Status'].toLowerCase() == 'true',
  //               'PS22A_TA02_Status':
  //                   itemAntenas['PS22A_TA02_Status'].toLowerCase() == 'true',
  //               'PS22B_TA01_Status':
  //                   itemAntenas['PS22B_TA01_Status'].toLowerCase() == 'true',
  //               'PS22B_TA02_Status':
  //                   itemAntenas['PS22B_TA02_Status'].toLowerCase() == 'true',
  //               'PS24_TA01_Status':
  //                   itemAntenas['PS24_TA01_Status'].toLowerCase() == 'true',
  //               'PS24_TA02_Status':
  //                   itemAntenas['PS24_TA02_Status'].toLowerCase() == 'true',
  //               'PS24_TA03_Status':
  //                   itemAntenas['PS24_TA03_Status'].toLowerCase() == 'true',
  //               'PS25_TA01_Status':
  //                   itemAntenas['PS25_TA01_Status'].toLowerCase() == 'true',
  //               'PS25_TA02_Status':
  //                   itemAntenas['PS25_TA02_Status'].toLowerCase() == 'true',
  //               'PS26_TA01_Status':
  //                   itemAntenas['PS26_TA01_Status'].toLowerCase() == 'true',
  //               'PS26_TA02_Status':
  //                   itemAntenas['PS26_TA02_Status'].toLowerCase() == 'true',
  //               'PS26_TA03_Status':
  //                   itemAntenas['PS26_TA03_Status'].toLowerCase() == 'true',
  //               'PS27_TA01_Status':
  //                   itemAntenas['PS27_TA01_Status'].toLowerCase() == 'true',
  //               'PS27_TA02_Status':
  //                   itemAntenas['PS27_TA02_Status'].toLowerCase() == 'true',
  //               'PS28_TA01_Status':
  //                   itemAntenas['PS28_TA01_Status'].toLowerCase() == 'true',
  //               'PS28_TA02_Status':
  //                   itemAntenas['PS28_TA02_Status'].toLowerCase() == 'true',
  //               'PS28_TA03_Status':
  //                   itemAntenas['PS28_TA03_Status'].toLowerCase() == 'true',
  //               'PS29_TA01_Status':
  //                   itemAntenas['PS29_TA01_Status'].toLowerCase() == 'true',
  //               'PS29_TA02_Status':
  //                   itemAntenas['PS29_TA02_Status'].toLowerCase() == 'true',
  //               'PS30_TA01_Status':
  //                   itemAntenas['PS30_TA01_Status'].toLowerCase() == 'true',
  //               'PS30_TA02_Status':
  //                   itemAntenas['PS30_TA02_Status'].toLowerCase() == 'true',
  //               'PS30_TA03_Status':
  //                   itemAntenas['PS30_TA03_Status'].toLowerCase() == 'true',
  //               'PS31_TA01_Status':
  //                   itemAntenas['PS31_TA01_Status'].toLowerCase() == 'true',
  //               'PS31_TA02_Status':
  //                   itemAntenas['PS31_TA02_Status'].toLowerCase() == 'true',
  //               'PS31_TA03_Status':
  //                   itemAntenas['PS31_TA03_Status'].toLowerCase() == 'true',
  //               'PS31_TA04_Status':
  //                   itemAntenas['PS31_TA04_Status'].toLowerCase() == 'true',
  //               'PS32_TA01_Status':
  //                   itemAntenas['PS32_TA01_Status'].toLowerCase() == 'true',
  //               'PS32_TA02_Status':
  //                   itemAntenas['PS32_TA02_Status'].toLowerCase() == 'true',
  //               'PS32_TA03_Status':
  //                   itemAntenas['PS32_TA03_Status'].toLowerCase() == 'true',
  //               'PS32_TA04_Status':
  //                   itemAntenas['PS32_TA04_Status'].toLowerCase() == 'true',
  //               'PS33A_TA01_Status':
  //                   itemAntenas['PS33A_TA01_Status'].toLowerCase() == 'true',
  //               'PS33A_TA02_Status':
  //                   itemAntenas['PS33A_TA02_Status'].toLowerCase() == 'true',
  //               'PS33A_TA03_Status':
  //                   itemAntenas['PS33A_TA03_Status'].toLowerCase() == 'true',
  //               'PS33B_TA01_Status':
  //                   itemAntenas['PS33B_TA01_Status'].toLowerCase() == 'true',
  //               'PS33B_TA02_Status':
  //                   itemAntenas['PS33B_TA02_Status'].toLowerCase() == 'true',
  //               'PS33B_TA03_Status':
  //                   itemAntenas['PS33B_TA03_Status'].toLowerCase() == 'true',
  //               'PS34B_TA01_Status':
  //                   itemAntenas['PS34B_TA01_Status'].toLowerCase() == 'true',
  //               'PS34B_TA02_Status':
  //                   itemAntenas['PS34B_TA02_Status'].toLowerCase() == 'true',
  //               'PS34B_TA03_Status':
  //                   itemAntenas['PS34B_TA03_Status'].toLowerCase() == 'true',
  //               'PS34B_TA04_Status':
  //                   itemAntenas['PS34B_TA04_Status'].toLowerCase() == 'true',
  //               'PS34B_TA05_Status':
  //                   itemAntenas['PS34B_TA05_Status'].toLowerCase() == 'true',
  //               'PS34B_TA06_Status':
  //                   itemAntenas['PS34B_TA06_Status'].toLowerCase() == 'true',
  //               'PS34B_TA07_Status':
  //                   itemAntenas['PS34B_TA07_Status'].toLowerCase() == 'true',
  //               'PS35_TA01_Status':
  //                   itemAntenas['PS35_TA01_Status'].toLowerCase() == 'true',
  //               'PS35_TA02_Status':
  //                   itemAntenas['PS35_TA02_Status'].toLowerCase() == 'true',
  //               'PS39_TA01_Status':
  //                   itemAntenas['PS39_TA01_Status'].toLowerCase() == 'true',
  //               'PS39_TA02_Status':
  //                   itemAntenas['PS39_TA02_Status'].toLowerCase() == 'true',
  //               'PS39_TA03_Status':
  //                   itemAntenas['PS39_TA03_Status'].toLowerCase() == 'true',
  //             });

  //             // Contar cuántas piscinas tienen estado false
  //             int antenasOffCount = 0;
  //             itemAntenas.forEach((key, value) {
  //               if (key.endsWith('_Status') && value.toLowerCase() == 'false') {
  //                 antenasOffCount++;
  //               }
  //             });

  //             // Crear y agregar el objeto a apiDataListOffAntenas
  //             apiDataListOffAntenas.add({
  //               'AntenasOff': antenasOffCount.toString(),
  //             });

  //             _apiDataListInfoGeneralPis.addAll([
  //               apiDataList,
  //               apiDataListOnPs,
  //               apiDataListAntenas,
  //               apiDataListOffAntenas
  //             ]);

  //             // print(_apiDataListInfoGeneralPis[1][0]);

  //             isLoading2 = false; // Finalizar el estado de cargando
  //             notifyListeners();
  //             // print(isLoading2);
  //             // print(_apiDataListPS01)
  //           }
  //         }, onError: (error) {
  //           isLoading2 = false; // Finalizar el estado de cargando
  //           _hasError = true; // Activar el estado de error
  //           // _errorMessage = error.toString(); // Almacenar mensaje de error
  //           // print('aaerrrrorrrrr');
  //           notifyListeners();
  //         });
  //       } else {}
  //     } catch (e) {
  //       // print('aaerrrrorrrrr');
  //     }
  //   }
  // }

  // static Future<dynamic> getPiscinasHistorialGraca(
  //     Map<String, String> fechas, String baseUrl, String endpoint) async {
  //   try {
  //     // Construir la URL
  //     final url = Uri.parse('$baseUrl$endpoint');
  //     print(url);

  //     // Codificar las fechas en formato JSON
  //     final cuerpo = json.encode(fechas);
  //     final cabecera = {'Content-Type': 'application/json'};

  //     // Realizar la solicitud POST
  //     final respuesta = await http.post(url, headers: cabecera, body: cuerpo);
  //     print(respuesta);
  //     // Verificar el código de estado HTTP
  //     if (respuesta.statusCode == 200) {
  //       // Decodificar el cuerpo de la respuesta
  //       dynamic mapaRespuesta = json.decode(respuesta.body);
  //       print(mapaRespuesta);
  //       return mapaRespuesta; // Devolver los datos decodificados
  //     } else {
  //       // Manejar el error si la respuesta no fue exitosa
  //       throw Exception('Error al obtener datos: ${respuesta.statusCode}');
  //     }
  //   } catch (e) {
  //     // Manejo de cualquier error durante la solicitud o decodificación
  //     print('Error: $e');
  //     throw Exception('Fallo en la solicitud: $e');
  //   }
  // }
}

















// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:appnaturisa/helpers/piscina.dart';

// class PiscinasJosefinaProvider extends ChangeNotifier {
//   // WebSocket y configuración de conexión
//   static Stream<dynamic>? _broadcastStream;
//   static bool isLoading2 = true;
//   bool _hasError = false;
//   String _errorMessage = '';
//   bool isReconnecting = false;
//   static bool isConnected = false;
//   static int _reconnectAttempts = 0;
//   final int _maxReconnectAttempts = 5;
//   static const Duration _reconnectDelay = Duration(seconds: 2);
//   static String? currentSubscription;
//   static IOWebSocketChannel? channel;

//   // Datos para cada piscina
//   final Map<String, List<dynamic>> _apiDataMap = {
//     'PC20': [],
//     'PC101': [],
//     'PC102': [],
//     'PC103': [],
//     'PC106': [],
//     'PC107': [],
//     'PC108': [],
//     'PC111': [],
//     'PC113': [],
//     'PC114': [],
//     'PC115': [],
//     'PC116': [],
//     'PC117': [],
//     'PS01': [],
//     'PS02': [],
//     'PS03': [],
//     'PS04': [],
//     'PS05': [],
//     'PS06': [],
//     'PS07': [],
//     'PS08': [],
//     'PS09': [],
//     'PS10': [],
//     'PS11': [],
//     'PS13': [],
//     'PS14': [],
//     'PS15': [],
//     'PS16': [],
//     'PS17': [],
//     'PS18': [],
//     'PS19': [],
//     'PS21': [],
//     'PS22': [],
//     'PS23': [],
//     'PS24': [],
//     'PS25': [],
//     'PS26': [],
//     'PS27': [],
//     'PS28': [],
//     'PS29': [],
//     'PS30': [],
//     'PS31': [],
//     'PS32': [],
//     'PS33': [],
//     'PS34': [],
//     'PS35': [],
//     'PS36': [],
//     'PS37': [],
//     'PS38': [],
//     'PS39': [],
//     'PS40': [],
//     'PS41': [],
//     'PS42': [],
//     'PS43': [],
//     'PS44': [],
//     'PS45': [],
//     'PS46': [],
//     'PS47': [],
//     'PS47B': [],
//     'PS48': [],
//     'PS49': [],
//     'PS50': [],
//     'PS51': [],
//     'PS52': [],
//     'PS53': [],
//     'PS54': [],
//     'PS55': [],
//     'PS56': [],
//     'PS57': [],
//     'PS58': [],
//     'InfoGeneralPis': [],
//     'Antenas': [],
//   };

//   // Suscripciones
//   static final Map<String, StreamSubscription?> _subscriptions = {};

//   // Getters para acceder a los datos
//   List<dynamic> getApiDataList(String key) => _apiDataMap[key] ?? [];
  
//   // Getters específicos para mantener compatibilidad
//   List<dynamic> get apiDataListPC20 => getApiDataList('PC20');
//   List<dynamic> get apiDataListPC101 => getApiDataList('PC101');
//   List<dynamic> get apiDataListPC102 => getApiDataList('PC102');
//   List<dynamic> get apiDataListPC103 => getApiDataList('PC103');
//   List<dynamic> get apiDataListPC106 => getApiDataList('PC106');
//   List<dynamic> get apiDataListPC107 => getApiDataList('PC107');
//   List<dynamic> get apiDataListPC108 => getApiDataList('PC108');
//   List<dynamic> get apiDataListPC111 => getApiDataList('PC111');
//   List<dynamic> get apiDataListPC113 => getApiDataList('PC113');
//   List<dynamic> get apiDataListPC114 => getApiDataList('PC114');
//   List<dynamic> get apiDataListPC115 => getApiDataList('PC115');
//   List<dynamic> get apiDataListPC116 => getApiDataList('PC116');
//   List<dynamic> get apiDataListPC117 => getApiDataList('PC117');
//   List<dynamic> get apiDataListPS01 => getApiDataList('PS01');
//   List<dynamic> get apiDataListPS02 => getApiDataList('PS02');
//   List<dynamic> get apiDataListPS03 => getApiDataList('PS03');
//   List<dynamic> get apiDataListPS04 => getApiDataList('PS04');
//   List<dynamic> get apiDataListPS05 => getApiDataList('PS05');
//   List<dynamic> get apiDataListPS06 => getApiDataList('PS06');
//   List<dynamic> get apiDataListPS07 => getApiDataList('PS07');
//   List<dynamic> get apiDataListPS08 => getApiDataList('PS08');
//   List<dynamic> get apiDataListPS09 => getApiDataList('PS09');
//   List<dynamic> get apiDataListPS10 => getApiDataList('PS10');
//   List<dynamic> get apiDataListPS11 => getApiDataList('PS11');
//   List<dynamic> get apiDataListPS13 => getApiDataList('PS13');
//   List<dynamic> get apiDataListPS14 => getApiDataList('PS14');
//   List<dynamic> get apiDataListPS15 => getApiDataList('PS15');
//   List<dynamic> get apiDataListPS16 => getApiDataList('PS16');
//   List<dynamic> get apiDataListPS17 => getApiDataList('PS17');
//   List<dynamic> get apiDataListPS18 => getApiDataList('PS18');
//   List<dynamic> get apiDataListPS19 => getApiDataList('PS19');
//   List<dynamic> get apiDataListPS21 => getApiDataList('PS21');
//   List<dynamic> get apiDataListPS22 => getApiDataList('PS22');
//   List<dynamic> get apiDataListPS23 => getApiDataList('PS23');
//   List<dynamic> get apiDataListPS24 => getApiDataList('PS24');
//   List<dynamic> get apiDataListPS25 => getApiDataList('PS25');
//   List<dynamic> get apiDataListPS26 => getApiDataList('PS26');
//   List<dynamic> get apiDataListPS27 => getApiDataList('PS27');
//   List<dynamic> get apiDataListPS28 => getApiDataList('PS28');
//   List<dynamic> get apiDataListPS29 => getApiDataList('PS29');
//   List<dynamic> get apiDataListPS30 => getApiDataList('PS30');
//   List<dynamic> get apiDataListPS31 => getApiDataList('PS31');
//   List<dynamic> get apiDataListPS32 => getApiDataList('PS32');
//   List<dynamic> get apiDataListPS33 => getApiDataList('PS33');
//   List<dynamic> get apiDataListPS34 => getApiDataList('PS34');
//   List<dynamic> get apiDataListPS35 => getApiDataList('PS35');
//   List<dynamic> get apiDataListPS36 => getApiDataList('PS36');
//   List<dynamic> get apiDataListPS37 => getApiDataList('PS37');
//   List<dynamic> get apiDataListPS38 => getApiDataList('PS38');
//   List<dynamic> get apiDataListPS39 => getApiDataList('PS39');
//   List<dynamic> get apiDataListPS40 => getApiDataList('PS40');
//   List<dynamic> get apiDataListPS41 => getApiDataList('PS41');
//   List<dynamic> get apiDataListPS42 => getApiDataList('PS42');
//   List<dynamic> get apiDataListPS43 => getApiDataList('PS43');
//   List<dynamic> get apiDataListPS44 => getApiDataList('PS44');
//   List<dynamic> get apiDataListPS45 => getApiDataList('PS45');
//   List<dynamic> get apiDataListPS46 => getApiDataList('PS46');
//   List<dynamic> get apiDataListPS47 => getApiDataList('PS47');
//   List<dynamic> get apiDataListPS47B => getApiDataList('PS47B');
//   List<dynamic> get apiDataListPS48 => getApiDataList('PS48');
//   List<dynamic> get apiDataListPS49 => getApiDataList('PS49');
//   List<dynamic> get apiDataListPS50 => getApiDataList('PS50');
//   List<dynamic> get apiDataListPS51 => getApiDataList('PS51');
//   List<dynamic> get apiDataListPS52 => getApiDataList('PS52');
//   List<dynamic> get apiDataListPS53 => getApiDataList('PS53');
//   List<dynamic> get apiDataListPS54 => getApiDataList('PS54');
//   List<dynamic> get apiDataListPS55 => getApiDataList('PS55');
//   List<dynamic> get apiDataListPS56 => getApiDataList('PS56');
//   List<dynamic> get apiDataListPS57 => getApiDataList('PS57');
//   List<dynamic> get apiDataListPS58 => getApiDataList('PS58');

//   List<dynamic> get apiDataListInfoGeneralPis => getApiDataList('InfoGeneralPis');
//   List<dynamic> get apiDataListAntenas => getApiDataList('Antenas');

//   bool get isLoading => isLoading2;
//   bool get hasError => _hasError;
//   String get errorMessage => _errorMessage;

//   // Constructor
//   PiscinasJosefinaProvider() {
//     connectWebSocket();
//   }

//   // Conexión WebSocket
//   void connectWebSocket() {
//     if (channel == null || channel!.closeCode != null) {
//       try {
//         channel = IOWebSocketChannel.connect(Uri.parse('ws://201.217.78.155:6060'));
//         _broadcastStream = channel!.stream.asBroadcastStream();
//         _broadcastStream!.listen((data) {}, 
//           onError: (error) {
//             _handleDisconnect();
//           }, 
//           onDone: () {
//             _handleDisconnect();
//           }
//         );

//         isConnected = true;
//         resetReconnectAttempts();

//         // Después de conectar, resuscribirse automáticamente
//         if (currentSubscription != null) {
//           _subscribeTo(currentSubscription!);
//         }
//       } catch (e) {
//         _hasError = true;
//         print('Error al conectar WebSocket: $e');
//         _handleDisconnect();
//       }
//     }
//   }

//   void _handleDisconnect() {
//     channel = null;
//     isConnected = false;
//     if (_reconnectAttempts < _maxReconnectAttempts) {
//       _reconnectAttempts++;
//       Future.delayed(_reconnectDelay, () {
//         connectWebSocket();
//       });
//     }
//   }

//   static void resetReconnectAttempts() {
//     _reconnectAttempts = 0;
//   }

//   void _subscribeTo(String subscription) {
//     if (isConnected) {
//       channel!.sink.add('subscribeFJOS$subscription');
//       currentSubscription = subscription;
//       notifyListeners();
//     }
//   }

//   void reconnectIfNeeded() async {
//     if (channel == null) {
//       channel = IOWebSocketChannel.connect('ws://201.217.78.155:6060');
//       channel!.stream.listen(
//         (message) {}, 
//         onDone: () {},
//         onError: (error) {}
//       );
//     }
//   }

//   // Método genérico para suscribirse a una piscina
//   void subscribe(String piscina, {String? taName, String? ta01Name, String? ta02Name, String? antena}) {
//     isLoading2 = true;
//     _hasError = false;

//     _subscribeTo(piscina);
//     notifyListeners();

//     if (_subscriptions[piscina] == null) {
//       // Limpiar datos existentes
//       _apiDataMap[piscina]?.clear();
      
//       // Variables locales para almacenar datos
//       List<Map<dynamic, dynamic>> apiDataList = [];
//       List<Map<dynamic, dynamic>> apiDataListTCP = [];
//       List<Map<dynamic, dynamic>> apiDataListAntenas = [];

//       if (_broadcastStream != null) {
//         _subscriptions[piscina] = _broadcastStream!.listen((event) {
//           // Limpiar datos locales
//           apiDataList.clear();
//           apiDataListTCP.clear();
//           apiDataListAntenas.clear();

//           final decodedEvent = json.decode(event);

//           if (decodedEvent.containsKey(piscina)) {
//             try {
//               // Procesar datos principales de la piscina
//               dynamic firstItem = decodedEvent[piscina][0];
//               if (firstItem != null) {
//                 apiDataList.add(parseFirstItem(firstItem));
//               }

//               // Procesar datos TCP
//               dynamic itemTCP = decodedEvent['${piscina}TCP'][0];
//               if (itemTCP != null) {
//                 if (ta01Name != null) {
//                   apiDataListTCP.add(parseTCPItem(itemTCP, ta01Name));
//                 }
//                 if (ta02Name != null) {
//                   apiDataListTCP.add(parseTCPItem(itemTCP, ta02Name));
//                 }
//                 if (taName != null && ta01Name == null) {
//                   apiDataListTCP.add(parseTCPItem(itemTCP, taName));
//                 }
//               }

//               // Procesar datos de antenas
//               dynamic itemAntenas = decodedEvent['${piscina}Antenas'][0];
//               if (itemAntenas != null && antena != null) {
//                 Map<String, dynamic> antenasData = {};
                
//                 // Si es una piscina con dos antenas
//                 if (ta02Name != null) {
//                   antenasData['Pot_$antena-1'] = safeIntParse(itemAntenas['Pot_$antena-1']);
//                   antenasData['Pot_$antena-2'] = safeIntParse(itemAntenas['Pot_$antena-2']);
//                   antenasData['Stat_$antena-1'] = itemAntenas['Stat_$antena-1']?.toLowerCase() == 'true';
//                   antenasData['Stat_$antena-2'] = itemAntenas['Stat_$antena-2']?.toLowerCase() == 'true';
//                 } else {
//                   antenasData['Pot_$antena-1'] = safeIntParse(itemAntenas['Pot_$antena-1']);
//                   antenasData['Stat_$antena-1'] = itemAntenas['Stat_$antena-1']?.toLowerCase() == 'true';
//                 }
                
//                 apiDataListAntenas.add(antenasData);
//               }

//               // Solo actualizar si hay datos válidos
//               if (apiDataList.isNotEmpty || apiDataListTCP.isNotEmpty || apiDataListAntenas.isNotEmpty) {
//                 _apiDataMap[piscina]?.clear();
//                 _apiDataMap[piscina]?.addAll([apiDataList, apiDataListTCP, apiDataListAntenas]);
                
//                 isLoading2 = false;
//                 if (!Piscina.contieneSoloArreglosVacios(_apiDataMap[piscina] ?? [])) {
//                   notifyListeners();
//                 }
//               }
//             } catch (e) {
//               print('Error procesando datos para $piscina: $e');
//               _hasError = true;
//               _errorMessage = e.toString();
//               isLoading2 = false;
//               notifyListeners();
//             }
//           }
//         }, onError: (error) {
//           isLoading2 = false;
//           _hasError = true;
//           _errorMessage = error.toString();
//           notifyListeners();
//         });
//       }
//     }
//   }

//   // Método para PC106 específicamente
//   void subscribePC106() {
//     subscribe('PC106', taName: 'TA_106_01', antena: 'TA106');
//   }

//   // Métodos auxiliares para parsear datos
//   Map<String, dynamic> parseFirstItem(dynamic item) {
//     return {
//       'Num_Auto': safeIntParse(item['Num_Auto']),
//       'Num_Air_On': safeIntParse(item['Num_Air_On']),
//       'Hrs_Trab_Sem': '${safeDoubleParse(item['Hrs_Trab_Sem']).round()} H/Sem',
//       'Hrs_Trab_Act': '${safeDoubleParse(item['Hrs_Trab_Act']).round()} H/Sem',
//       'Ener_Mes_Act': '${safeDoubleParse(item['Ener_Mes_Act']).round()} KWh/M',
//       'Ener_Mes_Pas': '${safeDoubleParse(item['Ener_Mes_Pas']).round()} KWh/M',
//       'Ener_Total_Index': safeDoubleParse(item['Ener_Total_Index']).round(),
//       'Pot_Inst': '${safeDoubleParse(item['Pot_Inst']).round()} KW',
//       'Alarm_Adver': safeIntParse(item['Alarm_Adver']),
//       'Hora_Ini_1': item['Hora_Ini_1']?.split('.')[0] ?? '00:00:00',
//       'Hora_Ini_2': item['Hora_Ini_2']?.split('.')[0] ?? '00:00:00',
//       'Hora_Fin_1': item['Hora_Fin_1']?.split('.')[0] ?? '00:00:00',
//       'Hora_Fin_2': item['Hora_Fin_2']?.split('.')[0] ?? '00:00:00',
//       'Algun_Air_On': item['Algun_Air_On']?.toLowerCase() == 'true',
//       'Run_Rem': item['Run_Rem']?.toLowerCase() == 'true',
//       'Bloq_Auto_Hora': item['Bloq_Auto_Hora']?.toLowerCase() == 'true',
//     };
//   }

//   Map<String, dynamic> parseTCPItem(dynamic item, String taPrefix) {
//     return {
//       '$taPrefix.Inputs': safeIntParse(item['$taPrefix.Inputs']),
//       '$taPrefix.Outputs': safeIntParse(item['$taPrefix.Outputs']),
//       '$taPrefix.Horas_Trab_Act': safeDoubleParse(item['$taPrefix.Horas_Trab_Act']).toStringAsFixed(2),
//       '$taPrefix.Horas_Trab_Guar': safeDoubleParse(item['$taPrefix.Horas_Trab_Guar']).toStringAsFixed(2),
//       '$taPrefix.Stat_Comm_MB': item['$taPrefix.Stat_Comm_MB']?.toLowerCase() == 'true',
//       '$taPrefix.Stat_Comm': item['$taPrefix.Stat_Comm']?.toLowerCase() == 'true',
//       '$taPrefix.V_Avg': safeDoubleParse(item['$taPrefix.V_Avg']).toStringAsFixed(2),
//       '$taPrefix.I_Tot': safeDoubleParse(item['$taPrefix.I_Tot']).toStringAsFixed(2),
//       '$taPrefix.P_Tot': safeDoubleParse(item['$taPrefix.P_Tot']).toStringAsFixed(2),
//       '$taPrefix.PF_Avg': safeDoubleParse(item['$taPrefix.PF_Avg']).toStringAsFixed(2),
//       '$taPrefix.V_12': safeDoubleParse(item['$taPrefix.V_12']).toStringAsFixed(2),
//       '$taPrefix.V_23': safeDoubleParse(item['$taPrefix.V_23']).toStringAsFixed(2),
//       '$taPrefix.V_31': safeDoubleParse(item['$taPrefix.V_31']).toStringAsFixed(2),
//       '$taPrefix.VLL_Avg': safeDoubleParse(item['$taPrefix.VLL_Avg']).toStringAsFixed(2),
//       '$taPrefix.THDV_tot': safeDoubleParse(item['$taPrefix.THDV_tot']).toStringAsFixed(2),
//       '$taPrefix.THDI_tot': safeDoubleParse(item['$taPrefix.THDI_tot']).toStringAsFixed(2),
//       '$taPrefix.V_1': safeDoubleParse(item['$taPrefix.V_1']).toStringAsFixed(2),
//       '$taPrefix.I_1': safeDoubleParse(item['$taPrefix.I_1']).toStringAsFixed(2),
//       '$taPrefix.V_2': safeDoubleParse(item['$taPrefix.V_2']).toStringAsFixed(2),
//       '$taPrefix.I_2': safeDoubleParse(item['$taPrefix.I_2']).toStringAsFixed(2),
//       '$taPrefix.V_3': safeDoubleParse(item['$taPrefix.V_3']).toStringAsFixed(2),
//       '$taPrefix.I_3': safeDoubleParse(item['$taPrefix.I_3']).toStringAsFixed(2),
//       '$taPrefix.Alarm1': safeIntParse(item['$taPrefix.Alarm1']),
//       '$taPrefix.Alarm2': safeIntParse(item['$taPrefix.Alarm2']),
//       '$taPrefix.T1_Imp_Act_Index': safeDoubleParse(item['$taPrefix.T1_Imp_Act_Index']).toStringAsFixed(2),
//     };
//   }

//   // Utilidades para parseo seguro de datos
//   int safeIntParse(dynamic value) {
//     if (value == null) return 0;
//     try {
//       return int.parse(value.toString());
//     } catch (e) {
//       return 0;
//     }
//   }

//   double safeDoubleParse(dynamic value) {
//     if (value == null) return 0.0;
//     try {
//       return double.parse(value.toString());
//     } catch (e) {
//       return 0.0;
//     }
//   }

//   // Métodos específicos para compatibilidad con el código existente
//   void subscribePC20() => subscribe('PC20', taName: 'TA_20_01', antena: 'TA20');
//   void subscribePC101() => subscribe('PC101', taName: 'TA_101_01', antena: 'TA101');
//   void subscribePC102() => subscribe('PC102', taName: 'TA_102_01', antena: 'TA102');
//   void subscribePC103() => subscribe('PC103', taName: 'TA_103_01', antena: 'TA103');
//   void subscribePC107() => subscribe('PC107', taName: 'TA_107_01', antena: 'TA107');
//   void subscribePC108() => subscribe('PC108', taName: 'TA_108_01', antena: 'TA108');
//   void subscribePC111() => subscribe('PC111', taName: 'TA_111_01', antena: 'TA111');
//   void subscribePC113() => subscribe('PC113', taName: 'TA_113_01', antena: 'TA113');
//   void subscribePC114() => subscribe('PC114', taName: 'TA_114_01', antena: 'TA114');
//   void subscribePC115() => subscribe('PC115', taName: 'TA_115_01', antena: 'TA115');
//   void subscribePC116() => subscribe('PC116', taName: 'TA_116_01', antena: 'TA116');
//   void subscribePC117() => subscribe('PC117', taName: 'TA_117_01', antena: 'TA117');
//   void subscribePS01() => subscribe('PS01', ta01Name: 'TA_01_01', ta02Name: 'TA_01_02', antena: 'TA01');
//   void subscribePS02() => subscribe('PS02', ta01Name: 'TA_02_01', ta02Name: 'TA_02_02', antena: 'TA02');
//   void subscribePS03() => subscribe('PS03', taName: 'TA_03_01', antena: 'TA03');
//   void subscribePS04() => subscribe('PS04', taName: 'TA_04_01', antena: 'TA04');
//   // ... y así sucesivamente para las demás piscinas
// }