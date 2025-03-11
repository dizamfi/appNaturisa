import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;
  const SlideShow(
      {super.key,
      required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.bulletPrimario = 12.0,
      this.bulletSecundario = 12.0});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(child: Builder(
          builder: (context) {
            Provider.of<_SlideshowModel>(context).colorPrimario = colorPrimario;
            Provider.of<_SlideshowModel>(context).colorSecundario =
                colorSecundario;

            Provider.of<_SlideshowModel>(context).bulletPrimario =
                bulletPrimario;
            Provider.of<_SlideshowModel>(context).bulletSecundario =
                bulletSecundario;

            return _CrearEstructuraSlideshow(
                puntosArriba: puntosArriba, slides: slides);
          },
        )),
      ),
    );
  }
}

class _CrearEstructuraSlideshow extends StatelessWidget {
  const _CrearEstructuraSlideshow({
    Key? key,
    required this.puntosArriba,
    required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (puntosArriba)
          _Dots(
            totalSlides: slides.length,
          ),
        Expanded(child: _Slides(slides)),
        if (!puntosArriba)
          _Dots(
            totalSlides: slides.length,
          )
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  // final Color colorPrimario;
  // final Color colorSecundario;

  const _Dots({
    Key? key,
    required this.totalSlides,
    // required this.colorPrimario,
    // required this.colorSecundario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: const [
        //   _Dot(
        //     index: 0,
        //   ),
        //   _Dot(index: 1),
        //   _Dot(index: 2),
        // ],
        children: List.generate(
            totalSlides,
            (i) => _Dot(
                  index: i,
                )),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  // final Color colorPrimario;
  // final Color colorSecundario;
  const _Dot({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final pageViewIndex = Provider.of<_SlideshowModel>(context).currentPage;
    final ssModel = Provider.of<_SlideshowModel>(context);
    double tamano;
    Color color;

    if (ssModel.currentPage >= index - 0.5 &&
        ssModel._currentPage < index + 0.5) {
      tamano = ssModel.bulletPrimario;
      color = ssModel.colorPrimario;
    } else {
      tamano = ssModel.bulletSecundario;
      color = ssModel.colorSecundario;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: tamano,
      height: tamano,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: color,
          // color : (ssModel.currentPage >= index - 0.5 &&
          //         ssModel._currentPage < index + 0.5)
          //     ? ssModel._colorPrimario
          //     : ssModel._colorSecundario,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget>? slides;
  const _Slides(
    this.slides,
  );

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      // print('Página actuañ: ${pageViewController.page}');

      // Actualizar el provider, SliderModel
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: pageViewController,
        // children: const [
        //   _Slide(svg: 'assets/svgs/1.svg'),
        //   _Slide(svg: 'assets/svgs/2.svg'),
        //   _Slide(svg: 'assets/svgs/3.svg')
        // ],

        children: widget.slides!
            .map((slide) => _Slide(
                  slide: slide,
                ))
            .toList());
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide({
    Key? key,
    required this.slide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 100,
        // padding: const EdgeInsets.only(top: 70),
        child: slide);
  }
}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color colorPrimario = Colors.blue;
  Color colorSecundario = Colors.grey;
  double bulletPrimario = 12.0;
  double bulletSecundario = 12.0;

  double get currentPage => _currentPage;

  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }
}
