import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:appnaturisa/widgets/contador.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelecHorarioScreen extends StatelessWidget {
  const SelecHorarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> apiDataList = [];
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<PiscinasJosefinaProvider>(
            builder: (context, psProvider, child) {
          apiDataList = psProvider.apiDataListInfoGeneralPis;
          // print(apiDataList);
          if (!PiscinasJosefinaProvider.isLoading2) {
            // Mostrar indicador de carga
            // return ShimmerLoading();
            // flag = false;

            // StorageService.saveFlag(false, 'FlagAireCali');

            // loadApiDataList();
          } else if (psProvider.hasError) {
            // Mostrar mensaje de error
            return Center(child: Text('Error: ${psProvider.errorMessage}'));
          }
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      // const Text('Horario Global',
                      //     style:
                      //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        iconSize: 30,
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Horario Global',
                          style: GoogleFonts.anton(
                            fontSize: 25,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Hora Inicio',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _CardReloj(
                        height: 210,
                        dataList: apiDataList,
                        name: 'UDT_DATA_GLOB_Hora_Ini_1_GLOB',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Hora Fin',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _CardReloj(
                        height: 210,
                        dataList: apiDataList,
                        name: 'UDT_DATA_GLOB_Hora_Fin_2_GLOB',
                      ),
                    ],
                  )
                ],
              ));
        }));
  }
}

class _CardReloj extends StatelessWidget {
  final double height;
  final List<dynamic> dataList;
  final String name;

  const _CardReloj({
    required this.height,
    required this.dataList,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
            )
          ]),
      child: Contador(
        hora: dataList[0][0][name],
      ),
    );
  }
}
