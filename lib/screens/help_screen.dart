import 'package:appnaturisa/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const phoneNumber = '+593987711549';
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('¿Qué necesitas?',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  iconSize: 30,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                OptionsHelp(
                    icono: const FaIcon(
                      FontAwesomeIcons.idBadge,
                      color: Colors.white,
                    ),
                    titulo: 'Identificador',
                    subtitulo: 'Consultar ID del dispositivo',
                    onPress: () async {
                      String? identifier = await UniqueIdentifier.serial;
                      // String? identifier = "1521";
                      // ignore: use_build_context_synchronously
                      alertDialog2(context, identifier!);
                    }),
                const SizedBox(
                  height: 10,
                ),
                OptionsHelp(
                  icono: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                  ),
                  titulo: 'WhatsApp',
                  subtitulo: 'Atención personalizada',
                  onPress: () async {
                    const message = 'Hola, necesito ayuda con...';

                    final encodedMessage = Uri.encodeComponent(message);

                    final whatsappUrl = Uri.parse(
                        'https://wa.me:/$phoneNumber?text=$encodedMessage');
                    await launchUrl(whatsappUrl);

                    // if (await canLaunchUrl(whatsappUrl)) {
                    //   await launchUrl(whatsappUrl);
                    // } else {
                    //   // Maneja el error si WhatsApp no está instalado
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text('WhatsApp no está instalado')),
                    //   );
                    // }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                OptionsHelp(
                  icono: const FaIcon(
                    FontAwesomeIcons.commentDots,
                    color: Colors.white,
                  ),
                  titulo: 'Dejar un comentario',
                  subtitulo: 'Experiencia con la app',
                  onPress: () async {
                    // https://forms.gle/9PDukGYueymSuF669
                    // https://xmif1tgfyco.typeform.com/to/YzBLW0Ig

                    final whatsappUrl = Uri.parse(
                        'https://xmif1tgfyco.typeform.com/to/YzBLW0Ig');
                    await launchUrl(whatsappUrl);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OptionsHelp extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final FaIcon icono;
  final Function() onPress;
  const OptionsHelp({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            CircleAvatar(backgroundColor: AppTheme.primaryBlue, child: icono),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(subtitulo)
              ],
            )
          ],
        ),
      ),
    );
  }
}

void alertDialog2(BuildContext context, String message) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        elevation: 5,
        title: const Text('Id del dispositivo'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Aceptar',
              style: TextStyle(
                  color: Color.fromRGBO(18, 34, 23, 0.859), fontSize: 15),
            ),
          )
        ],
      );
    },
  );
}
