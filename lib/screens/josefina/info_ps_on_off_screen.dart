import 'package:appnaturisa/providers/ps_josefina_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPSOnOffScreen extends StatefulWidget {
  const InfoPSOnOffScreen({super.key});

  @override
  State<InfoPSOnOffScreen> createState() => _InfoPSOnOffScreenState();
}

class _InfoPSOnOffScreenState extends State<InfoPSOnOffScreen>
    with WidgetsBindingObserver {
  List<Map<String, dynamic>> filteredData = [];
  bool firstLoad = true;

  List<Map<String, dynamic>> processAndFilterData(List<dynamic> data) {
    if (data.isEmpty) {
      return [];
    }

    // Mapa temporal para contar los circuitos por piscina
    Map<String, int> circuitCounts = {};

    for (var item in data[0]) {
      // print(item);
      item.forEach((key, value) {
        // Comprobar si la clave contiene ".Num_Air_On"

        if (key.contains(".Num_Air_On")) {
          if (value != 0) {
            // print('aquiiiiiii');
            // Extraer la piscina del nombre de la clave
            String piscina = key.split(".")[0];
            // print(piscina);
            // Inicializar el conteo de circuitos si no existe

            circuitCounts[piscina] = (circuitCounts[piscina] ?? 0);
            // print(value);
            // Convertir el valor a entero (ya que es un número como string)
            // int activeCircuits = int.parse(value);
            // print('iiiiiiiiii');
            // Acumular el número de circuitos activos

            if (value != 0) {
              circuitCounts[piscina] = value;
            }
          }
        }
      });
    }

    // Convertir el mapa a la estructura final con "name" y "activeCircuits"
    List<Map<String, dynamic>> result = circuitCounts.entries.map((entry) {
      return {
        "name": entry.key,
        "activeCircuits": entry.value.toString(),
      };
    }).toList();

    // print(result);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white, // Color de fondo suave
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    color: Colors.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Piscinas encendidas',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
        body: Consumer<PiscinasJosefinaProvider>(
            builder: (context, psProvider, child) {
          filteredData =
              processAndFilterData(psProvider.apiDataListInfoGeneralPis);
          // print(psProvider.apiDataListInfoGeneralPis);
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
            padding: const EdgeInsets.all(16.0),
            child: filteredData.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final pool = filteredData[index];
                      return Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(38, 158, 158, 158),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.air,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            pool["name"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Circuitos encendidos: ${pool['activeCircuits']}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(23, 223, 106, 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Activo",
                              style: TextStyle(
                                  color: Color.fromRGBO(23, 223, 106, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/camaron_sleep.png', // Cambia a la ruta de tu imagen
                          width: 250,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'No hay piscinas encendidas',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
          );
        }));
  }
}
