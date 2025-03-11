import 'package:appnaturisa/providers/user_provider.dart';
import 'package:appnaturisa/screens/help_screen.dart';
import 'package:appnaturisa/services/auth_service.dart';
import 'package:appnaturisa/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

class InicioSesionScreen extends StatefulWidget {
  const InicioSesionScreen({super.key});

  @override
  _InicioSesionScreenState createState() => _InicioSesionScreenState();
}

class _InicioSesionScreenState extends State<InicioSesionScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    loadCredentials();
    if (StorageService.prefs.containsKey('setHuella')) {
      UserProvider.setHuella(StorageService.prefs.getBool('setHuella')!);
    } else {
      StorageService.saveHuella(UserProvider.huella);
    }

    // Animación para entrada de elementos
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> loadCredentials() async {
    String? user = StorageService.prefs.getString('user');
    String? password = StorageService.prefs.getString('password');

    setState(() {
      userController.text = '';
      passwordController.text = '';
      UserProvider.setFormValues({'user': user, 'password': password});
    });
  }

  Future<void> login(String user, String password) async {
    final authService = AuthService();
    final storageService = StorageService();

    setState(() {
      isLoading = true;
    });

    FocusScope.of(context).requestFocus(FocusNode());

    final obj = await UserProvider.getUserByName({
      'user': user,
      'password': password,
    });

    String? identifier = await UniqueIdentifier.serial;

    if (obj["ok"] && (obj["id"] == identifier)) {
      // ignore: use_build_context_synchronously
      final dataUser = await UserProvider.getUser(user);

      UserProvider.updateUser(user, {
        "estado": "conectado",
      });
      // Guardar credenciales aquí
      storageService.saveCredentials(user, password);

      final data = dataUser["user"];

      await storageService.saveUser(
        data["nombre"],
        data["apellido"],
        data["celular"],
        data["cargo"],
        data["ultconexion"],
      );

      Navigator.pushNamed(context, 'inicio_camaroneras');
      StorageService.saveHuella(UserProvider.huella);
      if (StorageService.prefs.getBool('setHuella')! &&
          !StorageService.prefs.containsKey('authHuella')) {
        authService.authenticateWithBiometrics();
      }

      if (StorageService.prefs.getBool('setHuella')!) {
        storageService.authenticateWithHuella(true);
      }
    } else if (obj["ok"] && obj["id"] != identifier) {
      // ignore: use_build_context_synchronously
      alertDialog(context,
          'No tienes permiso para ingresar con este usuario en este dispositivo');
    } else {
      // ignore: use_build_context_synchronously
      alertDialog(context, obj['message']);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final size = MediaQuery.of(context).size;
    final primaryColor = const Color.fromRGBO(9, 31, 72, 1);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Form(
                  key: myFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.06),

                      // Logo
                      Image.asset(
                        'assets/logo_naturisa.png',
                        width: size.width * 0.5,
                      ),

                      SizedBox(height: size.height * 0.06),

                      // Título
                      const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(9, 31, 72, 1),
                          letterSpacing: 0.5,
                        ),
                      ),

                      SizedBox(height: size.height * 0.015),

                      // Subtítulo
                      Text(
                        'Ingresa tus credenciales para continuar',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: size.height * 0.05),

                      // Campo de usuario
                      _buildTextField(
                        controller: userController,
                        labelText: 'Usuario',
                        prefixIcon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          UserProvider.formValues['user'] = value;
                        },
                      ),

                      SizedBox(height: size.height * 0.025),

                      // Campo de contraseña
                      _buildTextField(
                        controller: passwordController,
                        labelText: 'Contraseña',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          UserProvider.formValues['password'] = value;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),

                      // Botón de inicio de sesión
                      if (isLoading)
                        const CircularProgressIndicator(
                          color: Color.fromRGBO(9, 31, 72, 1),
                          strokeWidth: 3,
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (userController.text.trim().isEmpty ||
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        const Text('Complete todos los campos'),
                                    backgroundColor: primaryColor,
                                  ),
                                );
                                return;
                              }
                              await login(
                                userController.text.trim(),
                                passwordController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: size.height * 0.04),

                      // Sección de huella digital
                      StorageService.prefs.getBool('setHuella')!
                          ? _buildBiometricLoginSection(
                              authService, size, primaryColor)
                          : _buildEnableBiometricSection(size, primaryColor),

                      SizedBox(height: size.height * 0.04),

                      // Botón de ayuda
                      _buildHelpButton(context, primaryColor),

                      SizedBox(height: size.height * 0.04),

                      // Logos de pie de página con diseño más sutil
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildFooterLogo(
                              'assets/melacorp.png', size.width * 0.24),
                          SizedBox(width: size.width * 0.05),
                          _buildFooterLogo(
                              'assets/iconoGps.png', size.width * 0.23),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
        prefixIcon: Icon(prefixIcon,
            color: const Color.fromRGBO(9, 31, 72, 0.7), size: 20),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color.fromRGBO(9, 31, 72, 0.7)),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }

  Widget _buildBiometricLoginSection(
      AuthService authService, Size size, Color primaryColor) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[300], height: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'o',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[300], height: 1)),
          ],
        ),
        SizedBox(height: size.height * 0.025),
        GestureDetector(
          onTap: () async {
            if (await authService.authenticateWithBiometrics()) {
              passwordController.text =
                  StorageService.prefs.getString('password')!;
              userController.text = StorageService.prefs.getString('user')!;
              await login(
                StorageService.prefs.getString('user')!,
                StorageService.prefs.getString('password')!,
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fingerprint_rounded,
                  size: 24,
                  color: primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Usar huella digital',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnableBiometricSection(Size size, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.fingerprint_rounded,
            color: primaryColor,
            size: 24,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activar huella digital',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Para futuras sesiones',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: UserProvider.huella,
            onChanged: (value) {
              setState(() {
                UserProvider.setHuella(value);
              });
            },
            activeColor: primaryColor,
            activeTrackColor: primaryColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpButton(BuildContext context, Color primaryColor) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HelpScreen(),
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
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey[600],
      ),
      child: Text(
        '¿Necesitas ayuda?',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildFooterLogo(String assetPath, double width) {
    return Opacity(
      opacity: 0.8,
      child: Image.asset(
        assetPath,
        width: width,
        height: 26,
      ),
    );
  }
}

void alertDialog(BuildContext context, String message) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Error de autenticación',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(9, 31, 72, 1),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey[800]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromRGBO(9, 31, 72, 1),
            ),
            child: const Text(
              'Aceptar',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      );
    },
  );
}

// import 'dart:ui';

// import 'package:appnaturisa/providers/user_provider.dart';
// import 'package:appnaturisa/screens/help_screen.dart';
// import 'package:appnaturisa/services/auth_service.dart';
// import 'package:appnaturisa/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:unique_identifier/unique_identifier.dart';

// class InicioSesionScreen extends StatefulWidget {
//   const InicioSesionScreen({super.key});

//   @override
//   _InicioSesionScreenState createState() => _InicioSesionScreenState();
// }

// class _InicioSesionScreenState extends State<InicioSesionScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   final TextEditingController userController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _obscureText = true;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   // Define the color scheme for the app
//   final Color spaceDarkBlue = const Color.fromRGBO(9, 31, 72, 1);
//   final Color spaceBlue = const Color.fromRGBO(23, 58, 130, 1);
//   final Color highlightBlue = const Color.fromRGBO(0, 136, 255, 1);
//   final Color starWhite = Colors.white;
//   final Color cosmicGrey = const Color.fromRGBO(240, 240, 245, 1);
//   final Color darkMatter = const Color.fromRGBO(30, 30, 35, 1);

//   @override
//   void initState() {
//     super.initState();
//     loadCredentials();
//     if (StorageService.prefs.containsKey('setHuella')) {
//       UserProvider.setHuella(StorageService.prefs.getBool('setHuella')!);
//     } else {
//       StorageService.saveHuella(UserProvider.huella);
//     }

//     // Enhanced animations
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOutQuart,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> loadCredentials() async {
//     String? user = StorageService.prefs.getString('user');
//     String? password = StorageService.prefs.getString('password');

//     setState(() {
//       userController.text = '';
//       passwordController.text = '';
//       UserProvider.setFormValues({'user': user, 'password': password});
//     });
//   }

//   Future<void> login(String user, String password) async {
//     final authService = AuthService();
//     final storageService = StorageService();

//     setState(() {
//       isLoading = true;
//     });

//     FocusScope.of(context).requestFocus(FocusNode());

//     final obj = await UserProvider.getUserByName({
//       'user': user,
//       'password': password,
//     });

//     String? identifier = await UniqueIdentifier.serial;

//     if (obj["ok"] && (obj["id"] == identifier)) {
//       // ignore: use_build_context_synchronously
//       final dataUser = await UserProvider.getUser(user);

//       UserProvider.updateUser(user, {
//         "estado": "conectado",
//       });
//       // Guardar credenciales aquí
//       storageService.saveCredentials(user, password);

//       final data = dataUser["user"];

//       await storageService.saveUser(
//         data["nombre"],
//         data["apellido"],
//         data["celular"],
//         data["cargo"],
//         data["ultconexion"],
//       );

//       Navigator.pushNamed(context, 'inicio_camaroneras');
//       StorageService.saveHuella(UserProvider.huella);
//       if (StorageService.prefs.getBool('setHuella')! &&
//           !StorageService.prefs.containsKey('authHuella')) {
//         authService.authenticateWithBiometrics();
//       }

//       if (StorageService.prefs.getBool('setHuella')!) {
//         storageService.authenticateWithHuella(true);
//       }
//     } else if (obj["ok"] && obj["id"] != identifier) {
//       // ignore: use_build_context_synchronously
//       alertDialog(context,
//           'No tienes permiso para ingresar con este usuario en este dispositivo');
//     } else {
//       // ignore: use_build_context_synchronously
//       alertDialog(context, obj['message']);
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authService = AuthService();
//     final size = MediaQuery.of(context).size;

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, Object? result) async {
//         SystemNavigator.pop();
//       },
//       child: Scaffold(
//         backgroundColor: darkMatter,
//         body: Stack(
//           children: [
//             // Background design with subtle gradient and effects
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       darkMatter,
//                       spaceDarkBlue,
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Subtle light effect top
//             Positioned(
//               top: -size.height * 0.2,
//               left: -size.width * 0.1,
//               child: Container(
//                 width: size.width * 1.2,
//                 height: size.height * 0.4,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: spaceBlue.withOpacity(0.12),
//                       blurRadius: 100,
//                       spreadRadius: 70,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Glowing orb at bottom
//             Positioned(
//               bottom: -size.height * 0.05,
//               right: -size.width * 0.15,
//               child: Container(
//                 width: size.width * 0.7,
//                 height: size.width * 0.7,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: highlightBlue.withOpacity(0.05),
//                       blurRadius: 80,
//                       spreadRadius: 30,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SafeArea(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: size.width * 0.08,
//                   ),
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Form(
//                       key: myFormKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(height: size.height * 0.06),

//                           // Logo with futuristic glow
//                           _buildAnimatedLogo(size),

//                           // Welcome text content
//                           _buildWelcomeText(size),

//                           // Main login card
//                           _buildLoginCard(size, authService),

//                           SizedBox(height: size.height * 0.04),

//                           // Footer content
//                           _buildFooterContent(size),

//                           SizedBox(height: size.height * 0.02),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedLogo(Size size) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween<double>(begin: 0.95, end: 1.0),
//       duration: const Duration(milliseconds: 2000),
//       curve: Curves.easeInOutBack,
//       builder: (context, value, child) {
//         return Transform.scale(
//           scale: value,
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: highlightBlue.withOpacity(0.15),
//                   blurRadius: 30,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Hero(
//               tag: 'app_logo',
//               child: Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: darkMatter.withOpacity(0.5),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: Image.asset(
//                     'assets/logo_naturisa.png',
//                     width: size.width * 0.32,
//                     height: size.width * 0.32,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildWelcomeText(Size size) {
//     return Column(
//       children: [
//         SizedBox(height: size.height * 0.04),
//         // Title with futuristic font
//         Text(
//           'NATURISA',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.w800,
//             color: starWhite,
//             letterSpacing: 4,
//             shadows: [
//               Shadow(
//                 color: highlightBlue.withOpacity(0.5),
//                 blurRadius: 8,
//                 offset: const Offset(0, 0),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: size.height * 0.01),
//         Text(
//           'SISTEMA DE CONTROL',
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//             color: starWhite.withOpacity(0.7),
//             letterSpacing: 2,
//           ),
//         ),
//         SizedBox(height: size.height * 0.04),
//       ],
//     );
//   }

//   Widget _buildLoginCard(Size size, AuthService authService) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.03),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.1),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 15,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Padding(
//             padding: EdgeInsets.all(size.width * 0.06),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Login title
//                 Text(
//                   'Iniciar Sesión',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                     color: starWhite,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Text(
//                   'Ingresa tus credenciales',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: starWhite.withOpacity(0.7),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.035),

//                 // Username field
//                 _buildTextField(
//                   controller: userController,
//                   labelText: 'Usuario',
//                   prefixIcon: Icons.person_rounded,
//                   onChanged: (value) {
//                     UserProvider.formValues['user'] = value;
//                   },
//                 ),
//                 SizedBox(height: size.height * 0.025),

//                 // Password field
//                 _buildTextField(
//                   controller: passwordController,
//                   labelText: 'Contraseña',
//                   prefixIcon: Icons.lock_rounded,
//                   obscureText: _obscureText,
//                   keyboardType: TextInputType.visiblePassword,
//                   onChanged: (value) {
//                     UserProvider.formValues['password'] = value;
//                   },
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscureText
//                           ? Icons.visibility_outlined
//                           : Icons.visibility,
//                       color: starWhite.withOpacity(0.6),
//                       size: 20,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscureText = !_obscureText;
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.035),

//                 // Login button with special design
//                 if (isLoading)
//                   Center(
//                     child: SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: _buildLoadingIndicator(),
//                     ),
//                   )
//                 else
//                   _buildLoginButton(),

//                 SizedBox(height: size.height * 0.03),

//                 // Fingerprint section
//                 StorageService.prefs.getBool('setHuella')!
//                     ? _buildBiometricLoginSection(authService, size)
//                     : _buildEnableBiometricSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return CircularProgressIndicator(
//       valueColor: AlwaysStoppedAnimation<Color>(highlightBlue),
//       strokeWidth: 3,
//       backgroundColor: spaceDarkBlue.withOpacity(0.3),
//     );
//   }

//   Widget _buildLoginButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: () async {
//           if (userController.text.trim().isEmpty ||
//               passwordController.text.isEmpty) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: const Text('Complete todos los campos'),
//                 backgroundColor: spaceDarkBlue,
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 margin: const EdgeInsets.all(10),
//               ),
//             );
//             return;
//           }
//           await login(
//             userController.text.trim(),
//             passwordController.text,
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: highlightBlue,
//           foregroundColor: starWhite,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 16),
//         ),
//         child: const Text(
//           'INGRESAR',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.5,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String labelText,
//     required IconData prefixIcon,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     required Function(String) onChanged,
//     Widget? suffixIcon,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: starWhite.withOpacity(0.1)),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         style: TextStyle(
//           color: starWhite,
//           fontSize: 16,
//         ),
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: TextStyle(
//             color: starWhite.withOpacity(0.7),
//             fontSize: 15,
//           ),
//           prefixIcon: Icon(
//             prefixIcon,
//             color: starWhite.withOpacity(0.7),
//             size: 20,
//           ),
//           suffixIcon: suffixIcon,
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//         ),
//         cursorColor: highlightBlue,
//       ),
//     );
//   }

//   Widget _buildBiometricLoginSection(AuthService authService, Size size) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Divider(
//                 color: starWhite.withOpacity(0.2),
//                 thickness: 1,
//                 height: 20,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'O',
//                 style: TextStyle(
//                   color: starWhite.withOpacity(0.7),
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Divider(
//                 color: starWhite.withOpacity(0.2),
//                 thickness: 1,
//                 height: 20,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: size.height * 0.02),
//         GestureDetector(
//           onTap: () async {
//             if (await authService.authenticateWithBiometrics()) {
//               passwordController.text =
//                   StorageService.prefs.getString('password')!;
//               userController.text = StorageService.prefs.getString('user')!;
//               await login(
//                 StorageService.prefs.getString('user')!,
//                 StorageService.prefs.getString('password')!,
//               );
//             }
//           },
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             decoration: BoxDecoration(
//               color: spaceDarkBlue.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: starWhite.withOpacity(0.1)),
//               boxShadow: [
//                 BoxShadow(
//                   color: highlightBlue.withOpacity(0.1),
//                   blurRadius: 10,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.fingerprint,
//                   size: 24,
//                   color: highlightBlue.withOpacity(0.9),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   'Usar huella digital',
//                   style: TextStyle(
//                     color: starWhite,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEnableBiometricSection() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: spaceDarkBlue.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: starWhite.withOpacity(0.1)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: darkMatter.withOpacity(0.4),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.fingerprint,
//               color: highlightBlue.withOpacity(0.9),
//               size: 22,
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Activar huella digital',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                     color: starWhite,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Para inicios de sesión más rápidos',
//                   style: TextStyle(
//                     color: starWhite.withOpacity(0.7),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Switch(
//             value: UserProvider.huella,
//             onChanged: (value) {
//               setState(() {
//                 UserProvider.setHuella(value);
//               });
//             },
//             activeColor: highlightBlue,
//             activeTrackColor: spaceDarkBlue,
//             inactiveThumbColor: starWhite,
//             inactiveTrackColor: darkMatter,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFooterContent(Size size) {
//     return Column(
//       children: [
//         // Help button
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     const HelpScreen(),
//                 transitionsBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   return SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(0.0, 1.0),
//                       end: Offset.zero,
//                     ).animate(
//                       CurvedAnimation(
//                         parent: animation,
//                         curve: Curves.easeOutQuint,
//                       ),
//                     ),
//                     child: child,
//                   );
//                 },
//               ),
//             );
//           },
//           style: TextButton.styleFrom(
//             foregroundColor: starWhite.withOpacity(0.6),
//             padding: const EdgeInsets.all(10),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(
//                 color: starWhite.withOpacity(0.1),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.help_outline_rounded,
//                 size: 16,
//                 color: highlightBlue,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '¿Necesitas ayuda?',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: starWhite.withOpacity(0.8),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         SizedBox(height: size.height * 0.03),

//         // Footer logos
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildFooterLogo('assets/melacorp.png'),
//             SizedBox(width: size.width * 0.06),
//             _buildFooterLogo('assets/iconoGps.png'),
//           ],
//         ),

//         SizedBox(height: 15),

//         // Copyright
//         Text(
//           '© ${DateTime.now().year} Sistema Integrado',
//           style: TextStyle(
//             color: starWhite.withOpacity(0.5),
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFooterLogo(String assetPath) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
//       decoration: BoxDecoration(
//         color: starWhite.withOpacity(0.04),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Image.asset(
//         assetPath,
//         height: 24,
//         color: starWhite.withOpacity(0.9),
//         colorBlendMode: BlendMode.modulate,
//       ),
//     );
//   }
// }

// void alertDialog(BuildContext context, String message) {
//   final Color spaceDarkBlue = const Color.fromRGBO(9, 31, 72, 1);
//   final Color highlightBlue = const Color.fromRGBO(0, 136, 255, 1);
//   final Color starWhite = Colors.white;
//   final Color darkMatter = const Color.fromRGBO(30, 30, 35, 1);

//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) {
//       return Dialog(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: darkMatter,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: starWhite.withOpacity(0.1),
//               width: 1,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.5),
//                 blurRadius: 20,
//                 spreadRadius: 5,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Error icon
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: darkMatter,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.red.withOpacity(0.2),
//                       blurRadius: 15,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.error_outline_rounded,
//                   color: Colors.red[300],
//                   size: 40,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Error de Autenticación',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: starWhite,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: starWhite.withOpacity(0.9),
//                   height: 1.4,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: spaceDarkBlue,
//                     foregroundColor: starWhite,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     side: BorderSide(
//                       color: highlightBlue.withOpacity(0.3),
//                       width: 1,
//                     ),
//                   ),
//                   child: const Text(
//                     'ENTENDIDO',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// import 'package:appnaturisa/providers/user_provider.dart';
// import 'package:appnaturisa/screens/help_screen.dart';
// import 'package:appnaturisa/services/auth_service.dart';
// import 'package:appnaturisa/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:unique_identifier/unique_identifier.dart';

// class InicioSesionScreen extends StatefulWidget {
//   const InicioSesionScreen({super.key});

//   @override
//   _InicioSesionScreenState createState() => _InicioSesionScreenState();
// }

// class _InicioSesionScreenState extends State<InicioSesionScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   final TextEditingController userController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _obscureText = true;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   // Paleta empresarial premium
//   final Color primaryBlue =
//       const Color.fromRGBO(9, 31, 72, 1); // Azul corporativo
//   final Color accentBlue =
//       const Color.fromRGBO(0, 122, 255, 1); // Azul claro para acentos
//   final Color lightGray =
//       const Color.fromRGBO(244, 246, 250, 1); // Gris muy claro para fondos
//   final Color mediumGray =
//       const Color.fromRGBO(228, 230, 235, 1); // Para bordes y divisores
//   final Color textDark =
//       const Color.fromRGBO(30, 35, 44, 1); // Casi negro para textos

//   @override
//   void initState() {
//     super.initState();
//     loadCredentials();
//     if (StorageService.prefs.containsKey('setHuella')) {
//       UserProvider.setHuella(StorageService.prefs.getBool('setHuella')!);
//     } else {
//       StorageService.saveHuella(UserProvider.huella);
//     }

//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeOut,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> loadCredentials() async {
//     String? user = StorageService.prefs.getString('user');
//     String? password = StorageService.prefs.getString('password');

//     setState(() {
//       userController.text = '';
//       passwordController.text = '';
//       UserProvider.setFormValues({'user': user, 'password': password});
//     });
//   }

//   Future<void> login(String user, String password) async {
//     final authService = AuthService();
//     final storageService = StorageService();

//     setState(() {
//       isLoading = true;
//     });

//     FocusScope.of(context).requestFocus(FocusNode());

//     final obj = await UserProvider.getUserByName({
//       'user': user,
//       'password': password,
//     });

//     String? identifier = await UniqueIdentifier.serial;

//     if (obj["ok"] && (obj["id"] == identifier)) {
//       // ignore: use_build_context_synchronously
//       final dataUser = await UserProvider.getUser(user);

//       UserProvider.updateUser(user, {
//         "estado": "conectado",
//       });
//       storageService.saveCredentials(user, password);

//       final data = dataUser["user"];
//       await storageService.saveUser(
//         data["nombre"],
//         data["apellido"],
//         data["celular"],
//         data["cargo"],
//         data["ultconexion"],
//       );

//       Navigator.pushNamed(context, 'inicio_camaroneras');
//       StorageService.saveHuella(UserProvider.huella);
//       if (StorageService.prefs.getBool('setHuella')! &&
//           !StorageService.prefs.containsKey('authHuella')) {
//         authService.authenticateWithBiometrics();
//       }

//       if (StorageService.prefs.getBool('setHuella')!) {
//         storageService.authenticateWithHuella(true);
//       }
//     } else if (obj["ok"] && obj["id"] != identifier) {
//       // ignore: use_build_context_synchronously
//       alertDialog(context,
//           'No tienes permiso para ingresar con este usuario en este dispositivo');
//     } else {
//       // ignore: use_build_context_synchronously
//       alertDialog(context, obj['message']);
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authService = AuthService();
//     final size = MediaQuery.of(context).size;

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, Object? result) async {
//         SystemNavigator.pop();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             // Elementos decorativos sutiles
//             _buildBackgroundElements(size),

//             // Contenido principal
//             SafeArea(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Form(
//                       key: myFormKey,
//                       child: Column(
//                         children: [
//                           SizedBox(height: size.height * 0.05),

//                           // Logo y encabezado
//                           _buildHeader(size),

//                           SizedBox(height: size.height * 0.06),

//                           // Tarjeta de login
//                           _buildLoginForm(size, authService),

//                           SizedBox(height: size.height * 0.04),

//                           // Pie de página
//                           _buildFooter(size),

//                           SizedBox(height: size.height * 0.02),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackgroundElements(Size size) {
//     return Stack(
//       children: [
//         // Círculo decorativo superior
//         Positioned(
//           top: -size.height * 0.15,
//           right: -size.width * 0.15,
//           child: Container(
//             width: size.width * 0.55,
//             height: size.width * 0.55,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [
//                   primaryBlue.withOpacity(0.04),
//                   primaryBlue.withOpacity(0.01),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//         ),

//         // Línea decorativa izquierda
//         Positioned(
//           top: size.height * 0.2,
//           left: 0,
//           child: Container(
//             width: size.width * 0.1,
//             height: 3,
//             decoration: BoxDecoration(
//               color: accentBlue.withOpacity(0.25),
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ),

//         // Círculo decorativo inferior
//         Positioned(
//           bottom: -size.height * 0.05,
//           left: -size.width * 0.15,
//           child: Container(
//             width: size.width * 0.4,
//             height: size.width * 0.4,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [
//                   accentBlue.withOpacity(0.02),
//                   primaryBlue.withOpacity(0.05),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeader(Size size) {
//     return Column(
//       children: [
//         // Logo con efecto de sombra suave
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.12),
//                 blurRadius: 20,
//                 spreadRadius: 3,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: ClipOval(
//             child: Image.asset(
//               'assets/logo_naturisa.png',
//               width: size.width * 0.3,
//               height: size.width * 0.3,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),

//         SizedBox(height: size.height * 0.025),

//         // Títulos
//         Text(
//           'NATURISA',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: primaryBlue,
//             letterSpacing: 2,
//           ),
//         ),

//         const SizedBox(height: 6),

//         Text(
//           'Sistema de Gestión Empresarial',
//           style: TextStyle(
//             fontSize: 14,
//             color: textDark.withOpacity(0.7),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoginForm(Size size, AuthService authService) {
//     return Container(
//       padding: EdgeInsets.all(size.width * 0.06),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             blurRadius: 24,
//             spreadRadius: 0,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Título del formulario
//           Text(
//             'Iniciar sesión',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//               color: primaryBlue,
//             ),
//           ),

//           const SizedBox(height: 6),

//           Text(
//             'Ingrese sus credenciales para continuar',
//             style: TextStyle(
//               fontSize: 14,
//               color: textDark.withOpacity(0.6),
//             ),
//           ),

//           SizedBox(height: size.height * 0.03),

//           // Campo de usuario
//           _buildInputField(
//             controller: userController,
//             labelText: 'Usuario',
//             prefixIcon: Icons.person_rounded,
//             onChanged: (value) {
//               UserProvider.formValues['user'] = value;
//             },
//           ),

//           SizedBox(height: size.height * 0.02),

//           // Campo de contraseña
//           _buildInputField(
//             controller: passwordController,
//             labelText: 'Contraseña',
//             prefixIcon: Icons.lock_rounded,
//             obscureText: _obscureText,
//             keyboardType: TextInputType.visiblePassword,
//             onChanged: (value) {
//               UserProvider.formValues['password'] = value;
//             },
//             suffixIcon: IconButton(
//               icon: Icon(
//                 _obscureText ? Icons.visibility_outlined : Icons.visibility,
//                 color: textDark.withOpacity(0.5),
//                 size: 20,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _obscureText = !_obscureText;
//                 });
//               },
//             ),
//           ),

//           SizedBox(height: size.height * 0.035),

//           // Botón de inicio de sesión
//           if (isLoading)
//             Center(
//               child: SizedBox(
//                 width: 45,
//                 height: 45,
//                 child: CircularProgressIndicator(
//                   color: primaryBlue,
//                   strokeWidth: 3,
//                 ),
//               ),
//             )
//           else
//             _buildPrimaryButton(
//               onPressed: () async {
//                 if (userController.text.trim().isEmpty ||
//                     passwordController.text.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text('Complete todos los campos'),
//                       backgroundColor: primaryBlue,
//                       behavior: SnackBarBehavior.floating,
//                       margin: const EdgeInsets.all(10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                   return;
//                 }
//                 await login(
//                   userController.text.trim(),
//                   passwordController.text,
//                 );
//               },
//               label: 'INICIAR SESIÓN',
//             ),

//           SizedBox(height: size.height * 0.025),

//           // Sección de huella digital
//           StorageService.prefs.getBool('setHuella')!
//               ? _buildBiometricLoginSection(authService, size)
//               : _buildEnableBiometricSection(size),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String labelText,
//     required IconData prefixIcon,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     required Function(String) onChanged,
//     Widget? suffixIcon,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: lightGray,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         style: TextStyle(
//           color: textDark,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: TextStyle(
//             color: textDark.withOpacity(0.6),
//             fontSize: 15,
//             fontWeight: FontWeight.w400,
//           ),
//           prefixIcon: Icon(
//             prefixIcon,
//             color: primaryBlue,
//             size: 20,
//           ),
//           suffixIcon: suffixIcon,
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         ),
//         cursorColor: accentBlue,
//       ),
//     );
//   }

//   Widget _buildPrimaryButton({
//     required VoidCallback onPressed,
//     required String label,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.white,
//           backgroundColor: primaryBlue,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.5,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBiometricLoginSection(AuthService authService, Size size) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Divider(
//                 color: mediumGray,
//                 thickness: 1.5,
//                 height: 20,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'o',
//                 style: TextStyle(
//                   color: textDark.withOpacity(0.6),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Divider(
//                 color: mediumGray,
//                 thickness: 1.5,
//                 height: 20,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: size.height * 0.02),
//         InkWell(
//           onTap: () async {
//             if (await authService.authenticateWithBiometrics()) {
//               passwordController.text =
//                   StorageService.prefs.getString('password')!;
//               userController.text = StorageService.prefs.getString('user')!;
//               await login(
//                 StorageService.prefs.getString('user')!,
//                 StorageService.prefs.getString('password')!,
//               );
//             }
//           },
//           borderRadius: BorderRadius.circular(12),
//           child: Ink(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: primaryBlue.withOpacity(0.3)),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.fingerprint,
//                   size: 24,
//                   color: accentBlue,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   'Usar huella digital',
//                   style: TextStyle(
//                     color: primaryBlue,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEnableBiometricSection(Size size) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: lightGray,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: primaryBlue.withOpacity(0.1),
//                   blurRadius: 10,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             child: Icon(
//               Icons.fingerprint,
//               color: accentBlue,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Activar huella digital',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: primaryBlue,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Para inicios de sesión más rápidos',
//                   style: TextStyle(
//                     color: textDark.withOpacity(0.6),
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Switch.adaptive(
//             value: UserProvider.huella,
//             onChanged: (value) {
//               setState(() {
//                 UserProvider.setHuella(value);
//               });
//             },
//             activeColor: accentBlue,
//             activeTrackColor: primaryBlue.withOpacity(0.2),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFooter(Size size) {
//     return Column(
//       children: [
//         // Botón de ayuda
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     const HelpScreen(),
//                 transitionsBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   return SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(0.0, 1.0),
//                       end: Offset.zero,
//                     ).animate(animation),
//                     child: child,
//                   );
//                 },
//               ),
//             );
//           },
//           style: TextButton.styleFrom(
//             foregroundColor: textDark.withOpacity(0.7),
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//               side: BorderSide(color: mediumGray),
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.help_outline_rounded,
//                 size: 16,
//                 color: accentBlue,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '¿Necesitas ayuda?',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         SizedBox(height: size.height * 0.03),

//         // Logos de la empresa
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildCompanyLogo('assets/melacorp.png', size),
//             SizedBox(width: size.width * 0.04),
//             _buildCompanyLogo('assets/iconoGps.png', size),
//           ],
//         ),

//         SizedBox(height: size.height * 0.01),

//         // Texto de copyright
//         Text(
//           '© ${DateTime.now().year} Naturisa - Todos los derechos reservados',
//           style: TextStyle(
//             color: textDark.withOpacity(0.5),
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCompanyLogo(String assetPath, Size size) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             spreadRadius: 0,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Image.asset(
//         assetPath,
//         height: 28,
//       ),
//     );
//   }
// }

// void alertDialog(BuildContext context, String message) {
//   final Color primaryBlue = const Color.fromRGBO(9, 31, 72, 1);
//   final Color textDark = const Color.fromRGBO(30, 35, 44, 1);

//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.error_outline_rounded,
//                 color: Colors.red,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 'Error de autenticación',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: primaryBlue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
//         content: Text(
//           message,
//           style: TextStyle(
//             fontSize: 15,
//             color: textDark.withOpacity(0.8),
//             height: 1.4,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             style: TextButton.styleFrom(
//               foregroundColor: primaryBlue,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             ),
//             child: const Text(
//               'ACEPTAR',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

// import 'package:appnaturisa/providers/user_provider.dart';
// import 'package:appnaturisa/screens/help_screen.dart';
// import 'package:appnaturisa/services/auth_service.dart';
// import 'package:appnaturisa/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:unique_identifier/unique_identifier.dart';

// class InicioSesionScreen extends StatefulWidget {
//   const InicioSesionScreen({super.key});

//   @override
//   _InicioSesionScreenState createState() => _InicioSesionScreenState();
// }

// class _InicioSesionScreenState extends State<InicioSesionScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   final TextEditingController userController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _obscureText = true;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   // Paleta de colores premium
//   final Color primaryBlue =
//       const Color.fromRGBO(9, 31, 72, 1); // Azul corporativo principal
//   final Color accentBlue = const Color.fromRGBO(0, 102, 204, 1); // Azul acento
//   final Color lightGray =
//       const Color.fromRGBO(248, 249, 252, 1); // Gris para áreas de entrada
//   final Color mediumGray =
//       const Color.fromRGBO(232, 234, 240, 1); // Gris para bordes
//   final Color textDark =
//       const Color.fromRGBO(25, 30, 40, 1); // Color principal para textos

//   @override
//   void initState() {
//     super.initState();
//     loadCredentials();
//     if (StorageService.prefs.containsKey('setHuella')) {
//       UserProvider.setHuella(StorageService.prefs.getBool('setHuella')!);
//     } else {
//       StorageService.saveHuella(UserProvider.huella);
//     }

//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeOut,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> loadCredentials() async {
//     String? user = StorageService.prefs.getString('user');
//     String? password = StorageService.prefs.getString('password');

//     setState(() {
//       userController.text = '';
//       passwordController.text = '';
//       UserProvider.setFormValues({'user': user, 'password': password});
//     });
//   }

//   Future<void> login(String user, String password) async {
//     final authService = AuthService();
//     final storageService = StorageService();

//     setState(() {
//       isLoading = true;
//     });

//     FocusScope.of(context).requestFocus(FocusNode());

//     final obj = await UserProvider.getUserByName({
//       'user': user,
//       'password': password,
//     });

//     String? identifier = await UniqueIdentifier.serial;

//     if (obj["ok"] && (obj["id"] == identifier)) {
//       // ignore: use_build_context_synchronously
//       final dataUser = await UserProvider.getUser(user);

//       UserProvider.updateUser(user, {
//         "estado": "conectado",
//       });
//       storageService.saveCredentials(user, password);

//       final data = dataUser["user"];
//       await storageService.saveUser(
//         data["nombre"],
//         data["apellido"],
//         data["celular"],
//         data["cargo"],
//         data["ultconexion"],
//       );

//       Navigator.pushNamed(context, 'inicio_camaroneras');
//       StorageService.saveHuella(UserProvider.huella);
//       if (StorageService.prefs.getBool('setHuella')! &&
//           !StorageService.prefs.containsKey('authHuella')) {
//         authService.authenticateWithBiometrics();
//       }

//       if (StorageService.prefs.getBool('setHuella')!) {
//         storageService.authenticateWithHuella(true);
//       }
//     } else if (obj["ok"] && obj["id"] != identifier) {
//       // ignore: use_build_context_synchronously
//       alertDialog(context,
//           'No tienes permiso para ingresar con este usuario en este dispositivo');
//     } else {
//       // ignore: use_build_context_synchronously
//       alertDialog(context, obj['message']);
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authService = AuthService();
//     final size = MediaQuery.of(context).size;

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, Object? result) async {
//         SystemNavigator.pop();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             // Elementos decorativos sutiles
//             _buildBackgroundElements(size),

//             // Contenido principal
//             SafeArea(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Form(
//                       key: myFormKey,
//                       child: Column(
//                         children: [
//                           SizedBox(height: size.height * 0.05),

//                           // Logo y encabezado
//                           _buildHeader(size),

//                           SizedBox(height: size.height * 0.045),

//                           // Tarjeta de login
//                           _buildLoginForm(size, authService),

//                           SizedBox(height: size.height * 0.035),

//                           // Pie de página
//                           _buildFooter(size),

//                           SizedBox(height: size.height * 0.02),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackgroundElements(Size size) {
//     return Stack(
//       children: [
//         // Rectángulo decorativo superior
//         Positioned(
//           top: 0,
//           right: 0,
//           child: Container(
//             width: size.width * 0.45,
//             height: 8,
//             decoration: BoxDecoration(
//               color: accentBlue.withOpacity(0.15),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//               ),
//             ),
//           ),
//         ),

//         // Línea decorativa izquierda
//         Positioned(
//           top: size.height * 0.25,
//           left: 0,
//           child: Container(
//             width: size.width * 0.1,
//             height: 2.5,
//             decoration: BoxDecoration(
//               color: accentBlue.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ),

//         // Rectángulo decorativo inferior
//         Positioned(
//           bottom: 0,
//           left: 0,
//           child: Container(
//             width: size.width * 0.35,
//             height: 6,
//             decoration: BoxDecoration(
//               color: primaryBlue.withOpacity(0.08),
//               borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(20),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeader(Size size) {
//     return Column(
//       children: [
//         // Logo con mejor visualización
//         Container(
//           width: size.width * 0.4,
//           height: size.width * 0.4,
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.08),
//                 blurRadius: 20,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Image.asset(
//             'assets/logo_naturisa.png',
//             fit: BoxFit.contain,
//           ),
//         ),

//         SizedBox(height: size.height * 0.025),

//         // Títulos
//         Text(
//           'NATURISA',
//           style: TextStyle(
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             color: primaryBlue,
//             letterSpacing: 2,
//           ),
//         ),

//         const SizedBox(height: 6),

//         Text(
//           'Sistema de Monitoreo',
//           style: TextStyle(
//             fontSize: 15,
//             color: textDark.withOpacity(0.7),
//             fontWeight: FontWeight.w500,
//             letterSpacing: 0.5,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoginForm(Size size, AuthService authService) {
//     return Container(
//       padding: EdgeInsets.all(size.width * 0.06),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.07),
//             blurRadius: 25,
//             spreadRadius: 0,
//             offset: const Offset(0, 8),
//           ),
//         ],
//         border: Border.all(
//           color: mediumGray.withOpacity(0.6),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Título del formulario
//           Text(
//             'Iniciar sesión',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//               color: primaryBlue,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             'Ingrese sus credenciales para continuar',
//             style: TextStyle(
//               fontSize: 14,
//               color: textDark.withOpacity(0.6),
//             ),
//           ),

//           SizedBox(height: size.height * 0.03),

//           // Campo de usuario
//           _buildInputField(
//             controller: userController,
//             labelText: 'Usuario',
//             prefixIcon: Icons.person_rounded,
//             onChanged: (value) {
//               UserProvider.formValues['user'] = value;
//             },
//           ),

//           SizedBox(height: size.height * 0.02),

//           // Campo de contraseña
//           _buildInputField(
//             controller: passwordController,
//             labelText: 'Contraseña',
//             prefixIcon: Icons.lock_rounded,
//             obscureText: _obscureText,
//             keyboardType: TextInputType.visiblePassword,
//             onChanged: (value) {
//               UserProvider.formValues['password'] = value;
//             },
//             suffixIcon: IconButton(
//               icon: Icon(
//                 _obscureText ? Icons.visibility_outlined : Icons.visibility,
//                 color: textDark.withOpacity(0.5),
//                 size: 20,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _obscureText = !_obscureText;
//                 });
//               },
//             ),
//           ),

//           SizedBox(height: size.height * 0.035),

//           // Botón de inicio de sesión
//           if (isLoading)
//             Center(
//               child: SizedBox(
//                 width: 45,
//                 height: 45,
//                 child: CircularProgressIndicator(
//                   color: primaryBlue,
//                   strokeWidth: 3,
//                 ),
//               ),
//             )
//           else
//             _buildPrimaryButton(
//               onPressed: () async {
//                 if (userController.text.trim().isEmpty ||
//                     passwordController.text.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text('Complete todos los campos'),
//                       backgroundColor: primaryBlue,
//                       behavior: SnackBarBehavior.floating,
//                       margin: const EdgeInsets.all(10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                   return;
//                 }
//                 await login(
//                   userController.text.trim(),
//                   passwordController.text,
//                 );
//               },
//               label: 'INICIAR SESIÓN',
//             ),

//           SizedBox(height: size.height * 0.025),

//           // Sección de huella digital
//           StorageService.prefs.getBool('setHuella')!
//               ? _buildBiometricLoginSection(authService, size)
//               : _buildEnableBiometricSection(size),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String labelText,
//     required IconData prefixIcon,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     required Function(String) onChanged,
//     Widget? suffixIcon,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: lightGray,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: mediumGray,
//           width: 1,
//         ),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         style: TextStyle(
//           color: textDark,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: TextStyle(
//             color: textDark.withOpacity(0.6),
//             fontSize: 15,
//             fontWeight: FontWeight.w400,
//           ),
//           prefixIcon: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Icon(
//               prefixIcon,
//               color: primaryBlue,
//               size: 20,
//             ),
//           ),
//           suffixIcon: suffixIcon,
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
//         ),
//         cursorColor: accentBlue,
//       ),
//     );
//   }

//   Widget _buildPrimaryButton({
//     required VoidCallback onPressed,
//     required String label,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.white,
//           backgroundColor: primaryBlue,
//           elevation: 1,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.8,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBiometricLoginSection(AuthService authService, Size size) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Divider(
//                 color: mediumGray,
//                 thickness: 1.5,
//                 height: 20,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'o',
//                 style: TextStyle(
//                   color: textDark.withOpacity(0.6),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Divider(
//                 color: mediumGray,
//                 thickness: 1.5,
//                 height: 20,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: size.height * 0.02),
//         InkWell(
//           onTap: () async {
//             if (await authService.authenticateWithBiometrics()) {
//               passwordController.text =
//                   StorageService.prefs.getString('password')!;
//               userController.text = StorageService.prefs.getString('user')!;
//               await login(
//                 StorageService.prefs.getString('user')!,
//                 StorageService.prefs.getString('password')!,
//               );
//             }
//           },
//           borderRadius: BorderRadius.circular(12),
//           child: Ink(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border:
//                   Border.all(color: accentBlue.withOpacity(0.4), width: 1.5),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.fingerprint,
//                   size: 24,
//                   color: accentBlue,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   'Usar huella digital',
//                   style: TextStyle(
//                     color: primaryBlue,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEnableBiometricSection(Size size) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: lightGray,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: mediumGray,
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: accentBlue.withOpacity(0.1),
//                   blurRadius: 10,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             child: Icon(
//               Icons.fingerprint,
//               color: accentBlue,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Activar huella digital',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: primaryBlue,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Para acceso rápido y seguro',
//                   style: TextStyle(
//                     color: textDark.withOpacity(0.6),
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Switch.adaptive(
//             value: UserProvider.huella,
//             onChanged: (value) {
//               setState(() {
//                 UserProvider.setHuella(value);
//               });
//             },
//             activeColor: accentBlue,
//             activeTrackColor: primaryBlue.withOpacity(0.2),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFooter(Size size) {
//     return Column(
//       children: [
//         // Botón de ayuda
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     const HelpScreen(),
//                 transitionsBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   return SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(0.0, 1.0),
//                       end: Offset.zero,
//                     ).animate(animation),
//                     child: child,
//                   );
//                 },
//               ),
//             );
//           },
//           style: TextButton.styleFrom(
//             foregroundColor: textDark.withOpacity(0.7),
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//               side: BorderSide(color: mediumGray),
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.help_outline_rounded,
//                 size: 16,
//                 color: accentBlue,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '¿Necesitas ayuda?',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         SizedBox(height: size.height * 0.025),

//         // Logos de la empresa
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildCompanyLogo('assets/melacorp.png', size),
//             SizedBox(width: size.width * 0.04),
//             _buildCompanyLogo('assets/iconoGps.png', size),
//           ],
//         ),

//         SizedBox(height: size.height * 0.012),

//         // Texto de copyright
//         Text(
//           '© ${DateTime.now().year} Naturisa • Tecnología Avanzada',
//           style: TextStyle(
//             color: textDark.withOpacity(0.5),
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCompanyLogo(String assetPath, Size size) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 8,
//             spreadRadius: 0,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         border: Border.all(
//           color: mediumGray.withOpacity(0.5),
//           width: 1,
//         ),
//       ),
//       child: Image.asset(
//         assetPath,
//         height: 26,
//       ),
//     );
//   }
// }

// void alertDialog(BuildContext context, String message) {
//   final Color primaryBlue = const Color.fromRGBO(9, 31, 72, 1);
//   final Color textDark = const Color.fromRGBO(25, 30, 40, 1);

//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.error_outline_rounded,
//                 color: Colors.red,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 'Error de autenticación',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: primaryBlue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
//         content: Text(
//           message,
//           style: TextStyle(
//             fontSize: 15,
//             color: textDark.withOpacity(0.8),
//             height: 1.4,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             style: TextButton.styleFrom(
//               foregroundColor: primaryBlue,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             ),
//             child: const Text(
//               'ACEPTAR',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }













// import 'package:appnaturisa/providers/user_provider.dart';
// import 'package:appnaturisa/screens/help_screen.dart';
// import 'package:appnaturisa/services/auth_service.dart';
// import 'package:appnaturisa/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:unique_identifier/unique_identifier.dart';

// class InicioSesionScreen extends StatefulWidget {
//   const InicioSesionScreen({super.key});

//   @override
//   _InicioSesionScreenState createState() => _InicioSesionScreenState();
// }

// class _InicioSesionScreenState extends State<InicioSesionScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   final TextEditingController userController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _obscureText = true;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   // Paleta de colores premium
//   final Color primaryBlue = const Color.fromRGBO(9, 31, 72, 1);
//   final Color accentBlue = const Color.fromRGBO(0, 102, 204, 1);
//   final Color lightGray = const Color.fromRGBO(248, 249, 252, 1);
//   final Color mediumGray = const Color.fromRGBO(232, 234, 240, 1);
//   final Color textDark = const Color.fromRGBO(25, 30, 40, 1);

//   @override
//   void initState() {
//     super.initState();
//     loadCredentials();
//     if (StorageService.prefs.containsKey('setHuella')) {
//       UserProvider.setHuella(StorageService.prefs.getBool('setHuella')!);
//     } else {
//       StorageService.saveHuella(UserProvider.huella);
//     }

//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeOut,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> loadCredentials() async {
//     String? user = StorageService.prefs.getString('user');
//     String? password = StorageService.prefs.getString('password');

//     setState(() {
//       userController.text = '';
//       passwordController.text = '';
//       UserProvider.setFormValues({'user': user, 'password': password});
//     });
//   }

//   Future<void> login(String user, String password) async {
//     final authService = AuthService();
//     final storageService = StorageService();

//     setState(() {
//       isLoading = true;
//     });

//     FocusScope.of(context).requestFocus(FocusNode());

//     final obj = await UserProvider.getUserByName({
//       'user': user,
//       'password': password,
//     });

//     String? identifier = await UniqueIdentifier.serial;

//     if (obj["ok"] && (obj["id"] == identifier)) {
//       // ignore: use_build_context_synchronously
//       final dataUser = await UserProvider.getUser(user);

//       UserProvider.updateUser(user, {
//         "estado": "conectado",
//       });
//       storageService.saveCredentials(user, password);

//       final data = dataUser["user"];
//       await storageService.saveUser(
//         data["nombre"],
//         data["apellido"],
//         data["celular"],
//         data["cargo"],
//         data["ultconexion"],
//       );

//       Navigator.pushNamed(context, 'inicio_camaroneras');
//       StorageService.saveHuella(UserProvider.huella);
//       if (StorageService.prefs.getBool('setHuella')! &&
//           !StorageService.prefs.containsKey('authHuella')) {
//         authService.authenticateWithBiometrics();
//       }

//       if (StorageService.prefs.getBool('setHuella')!) {
//         storageService.authenticateWithHuella(true);
//       }
//     } else if (obj["ok"] && obj["id"] != identifier) {
//       // ignore: use_build_context_synchronously
//       alertDialog(context,
//           'No tienes permiso para ingresar con este usuario en este dispositivo');
//     } else {
//       // ignore: use_build_context_synchronously
//       alertDialog(context, obj['message']);
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authService = AuthService();
//     final size = MediaQuery.of(context).size;

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, Object? result) async {
//         SystemNavigator.pop();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             // Elementos decorativos sutiles
//             _buildBackgroundElements(size),

//             // Contenido principal - Optimizado para evitar scroll
//             SafeArea(
//               child: LayoutBuilder(builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight,
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: size.width * 0.06),
//                       child: FadeTransition(
//                         opacity: _fadeAnimation,
//                         child: Form(
//                           key: myFormKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SizedBox(height: size.height * 0.03),

//                               // Logo y encabezado - Logo más grande
//                               _buildHeader(size),

//                               SizedBox(height: size.height * 0.02),

//                               // Tarjeta de login - Optimizada
//                               Flexible(
//                                 child: _buildLoginForm(size, authService),
//                               ),

//                               SizedBox(height: size.height * 0.02),

//                               // Pie de página - Compacto
//                               _buildFooter(size),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackgroundElements(Size size) {
//     return Stack(
//       children: [
//         // Rectángulo decorativo superior
//         Positioned(
//           top: 0,
//           right: 0,
//           child: Container(
//             width: size.width * 0.45,
//             height: 8,
//             decoration: BoxDecoration(
//               color: accentBlue.withOpacity(0.15),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//               ),
//             ),
//           ),
//         ),

//         // Línea decorativa izquierda
//         Positioned(
//           top: size.height * 0.25,
//           left: 0,
//           child: Container(
//             width: size.width * 0.1,
//             height: 2.5,
//             decoration: BoxDecoration(
//               color: accentBlue.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ),

//         // Rectángulo decorativo inferior
//         Positioned(
//           bottom: 0,
//           left: 0,
//           child: Container(
//             width: size.width * 0.35,
//             height: 6,
//             decoration: BoxDecoration(
//               color: primaryBlue.withOpacity(0.08),
//               borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(20),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeader(Size size) {
//     return Column(
//       children: [
//         // Logo más grande y con un contenedor más grande
//         Container(
//           width: size.width * 0.5, // Aumentado de 0.4 a 0.5
//           height: size.width * 0.5, // Aumentado de 0.4 a 0.5
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.08),
//                 blurRadius: 20,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Image.asset(
//             'assets/logo_naturisa.png',
//             fit: BoxFit.contain,
//           ),
//         ),

//         SizedBox(height: size.height * 0.015),

//         // Títulos
//         Text(
//           'NATURISA',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: primaryBlue,
//             letterSpacing: 2,
//           ),
//         ),

//         const SizedBox(height: 4),

//         Text(
//           'Sistema de Monitoreo',
//           style: TextStyle(
//             fontSize: 14,
//             color: textDark.withOpacity(0.7),
//             fontWeight: FontWeight.w500,
//             letterSpacing: 0.5,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoginForm(Size size, AuthService authService) {
//     return Container(
//       padding: EdgeInsets.all(size.width * 0.05), // Reducido de 0.06 a 0.05
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.07),
//             blurRadius: 20,
//             spreadRadius: 0,
//             offset: const Offset(0, 8),
//           ),
//         ],
//         border: Border.all(
//           color: mediumGray.withOpacity(0.6),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Título del formulario
//           Text(
//             'Iniciar sesión',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: primaryBlue,
//             ),
//           ),

//           const SizedBox(height: 4),

//           Text(
//             'Ingrese sus credenciales para continuar',
//             style: TextStyle(
//               fontSize: 13,
//               color: textDark.withOpacity(0.6),
//             ),
//           ),

//           SizedBox(height: size.height * 0.02),

//           // Campos optimizados
//           _buildCompactInputField(
//             controller: userController,
//             labelText: 'Usuario',
//             prefixIcon: Icons.person_rounded,
//             onChanged: (value) {
//               UserProvider.formValues['user'] = value;
//             },
//           ),

//           SizedBox(height: size.height * 0.015),

//           _buildCompactInputField(
//             controller: passwordController,
//             labelText: 'Contraseña',
//             prefixIcon: Icons.lock_rounded,
//             obscureText: _obscureText,
//             keyboardType: TextInputType.visiblePassword,
//             onChanged: (value) {
//               UserProvider.formValues['password'] = value;
//             },
//             suffixIcon: IconButton(
//               icon: Icon(
//                 _obscureText ? Icons.visibility_outlined : Icons.visibility,
//                 color: textDark.withOpacity(0.5),
//                 size: 18,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _obscureText = !_obscureText;
//                 });
//               },
//             ),
//           ),

//           SizedBox(height: size.height * 0.025),

//           // Botón de inicio de sesión
//           if (isLoading)
//             Center(
//               child: SizedBox(
//                 width: 40,
//                 height: 40,
//                 child: CircularProgressIndicator(
//                   color: primaryBlue,
//                   strokeWidth: 3,
//                 ),
//               ),
//             )
//           else
//             _buildPrimaryButton(
//               onPressed: () async {
//                 if (userController.text.trim().isEmpty ||
//                     passwordController.text.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text('Complete todos los campos'),
//                       backgroundColor: primaryBlue,
//                       behavior: SnackBarBehavior.floating,
//                       margin: const EdgeInsets.all(10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                   return;
//                 }
//                 await login(
//                   userController.text.trim(),
//                   passwordController.text,
//                 );
//               },
//               label: 'INICIAR SESIÓN',
//             ),

//           SizedBox(height: size.height * 0.02),

//           // Sección de huella digital optimizada
//           StorageService.prefs.getBool('setHuella')!
//               ? _buildBiometricLoginSection(authService, size)
//               : _buildEnableBiometricSection(size),
//         ],
//       ),
//     );
//   }

//   // Campo de texto más compacto
//   Widget _buildCompactInputField({
//     required TextEditingController controller,
//     required String labelText,
//     required IconData prefixIcon,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     required Function(String) onChanged,
//     Widget? suffixIcon,
//   }) {
//     return Container(
//       height: 52, // Altura fija para optimizar espacio
//       decoration: BoxDecoration(
//         color: lightGray,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: mediumGray,
//           width: 1,
//         ),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         style: TextStyle(
//           color: textDark,
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//         ),
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: TextStyle(
//             color: textDark.withOpacity(0.6),
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//           ),
//           prefixIcon: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Icon(
//               prefixIcon,
//               color: primaryBlue,
//               size: 18,
//             ),
//           ),
//           suffixIcon: suffixIcon,
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//         ),
//         cursorColor: accentBlue,
//       ),
//     );
//   }

//   Widget _buildPrimaryButton({
//     required VoidCallback onPressed,
//     required String label,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 48, // Reducido de 54 a 48
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.white,
//           backgroundColor: primaryBlue,
//           elevation: 1,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.8,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBiometricLoginSection(AuthService authService, Size size) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Divider(
//                 color: mediumGray,
//                 thickness: 1.5,
//                 height: 16, // Reducido de 20 a 16
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Text(
//                 'o',
//                 style: TextStyle(
//                   color: textDark.withOpacity(0.6),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Divider(
//                 color: mediumGray,
//                 thickness: 1.5,
//                 height: 16,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: size.height * 0.01),
//         InkWell(
//           onTap: () async {
//             if (await authService.authenticateWithBiometrics()) {
//               passwordController.text =
//                   StorageService.prefs.getString('password')!;
//               userController.text = StorageService.prefs.getString('user')!;
//               await login(
//                 StorageService.prefs.getString('user')!,
//                 StorageService.prefs.getString('password')!,
//               );
//             }
//           },
//           borderRadius: BorderRadius.circular(10),
//           child: Ink(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 10), // Reducido de 14 a 10
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border:
//                   Border.all(color: accentBlue.withOpacity(0.4), width: 1.5),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.fingerprint,
//                   size: 22,
//                   color: accentBlue,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Usar huella digital',
//                   style: TextStyle(
//                     color: primaryBlue,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEnableBiometricSection(Size size) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12), // Reducido de 16 a 12
//       decoration: BoxDecoration(
//         color: lightGray,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: mediumGray,
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: accentBlue.withOpacity(0.1),
//                   blurRadius: 8,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             child: Icon(
//               Icons.fingerprint,
//               color: accentBlue,
//               size: 22,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Activar huella digital',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: primaryBlue,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Para acceso rápido y seguro',
//                   style: TextStyle(
//                     color: textDark.withOpacity(0.6),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Transform.scale(
//             scale: 0.8,
//             child: Switch.adaptive(
//               value: UserProvider.huella,
//               onChanged: (value) {
//                 setState(() {
//                   UserProvider.setHuella(value);
//                 });
//               },
//               activeColor: accentBlue,
//               activeTrackColor: primaryBlue.withOpacity(0.2),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFooter(Size size) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Botón de ayuda
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     const HelpScreen(),
//                 transitionsBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   return SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(0.0, 1.0),
//                       end: Offset.zero,
//                     ).animate(animation),
//                     child: child,
//                   );
//                 },
//               ),
//             );
//           },
//           style: TextButton.styleFrom(
//             foregroundColor: textDark.withOpacity(0.7),
//             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//               side: BorderSide(color: mediumGray),
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.help_outline_rounded,
//                 size: 14,
//                 color: accentBlue,
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 '¿Ayuda?',
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Logos de la empresa
//         Row(
//           children: [
//             _buildCompanyLogo('assets/melacorp.png', size),
//             SizedBox(width: size.width * 0.03),
//             _buildCompanyLogo('assets/iconoGps.png', size),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildCompanyLogo(String assetPath, Size size) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 6,
//             spreadRadius: 0,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         border: Border.all(
//           color: mediumGray.withOpacity(0.5),
//           width: 1,
//         ),
//       ),
//       child: Image.asset(
//         assetPath,
//         height: 22,
//       ),
//     );
//   }
// }

// void alertDialog(BuildContext context, String message) {
//   final Color primaryBlue = const Color.fromRGBO(9, 31, 72, 1);
//   final Color textDark = const Color.fromRGBO(25, 30, 40, 1);

//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.error_outline_rounded,
//                 color: Colors.red,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 'Error de autenticación',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: primaryBlue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
//         content: Text(
//           message,
//           style: TextStyle(
//             fontSize: 15,
//             color: textDark.withOpacity(0.8),
//             height: 1.4,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             style: TextButton.styleFrom(
//               foregroundColor: primaryBlue,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             ),
//             child: const Text(
//               'ACEPTAR',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }













