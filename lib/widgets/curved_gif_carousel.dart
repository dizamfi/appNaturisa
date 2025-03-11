import 'package:appnaturisa/widgets/background_video_player.dart';
import 'package:flutter/material.dart';

class CurvedGifCarousel extends StatelessWidget {
  const CurvedGifCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: CurvedClipper(),
      child: Container(
        // height: 420,
        height: size.height * 0.557,
        width: size.width,
        decoration: const BoxDecoration(
            // color: Color(0xFF212121), // Negro
            // color: Color.fromRGBO(18, 34, 23, 0.859),
            // color: Color.fromRGBO(1, 39, 8, 0.9),
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28))),
        child: const GifCarousel(),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);

    // Curva profunda en la parte inferior
    path.quadraticBezierTo(
      size.width / 2, size.height - 30, // Control point
      size.width, size.height, // End point
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
