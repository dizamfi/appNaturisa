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

  // Paleta de colores premium
  final Color primaryBlue = const Color.fromRGBO(9, 31, 72, 1);
  final Color accentBlue = const Color.fromRGBO(0, 102, 204, 1);
  final Color lightGray = const Color.fromRGBO(248, 249, 252, 1);
  final Color mediumGray = const Color.fromRGBO(232, 234, 240, 1);
  final Color textDark = const Color.fromRGBO(25, 30, 40, 1);

  @override
  void initState() {
    super.initState();
    loadCredentials();
    if (StorageService.prefs.containsKey('setHuella')) {
      UserProvider.setHuella(StorageService.prefs.getBool('setHuella')!);
    } else {
      StorageService.saveHuella(UserProvider.huella);
    }

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
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
      storageService.saveCredentials(user, password);

      final data = dataUser["user"];
      await storageService.saveUser(
        data["nombre"],
        data["apellido"],
        data["celular"],
        data["cargo"],
        data["ultconexion"],
        data["email"],
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Elementos decorativos sutiles
            _buildBackgroundElements(size),

            // Contenido principal - Optimizado para evitar scroll
            SafeArea(
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Form(
                          key: myFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: size.height * 0.03),

                              // Logo y encabezado - Logo más grande
                              _buildHeader(size),

                              SizedBox(height: size.height * 0.02),

                              // Tarjeta de login - Optimizada
                              Flexible(
                                child: _buildLoginForm(size, authService),
                              ),

                              SizedBox(height: size.height * 0.02),

                              // Pie de página - Compacto
                              _buildFooter(size),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundElements(Size size) {
    return Stack(
      children: [
        // Rectángulo decorativo superior
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: size.width * 0.45,
            height: 8,
            decoration: BoxDecoration(
              color: accentBlue.withOpacity(0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
        ),

        // Línea decorativa izquierda
        Positioned(
          top: size.height * 0.25,
          left: 0,
          child: Container(
            width: size.width * 0.1,
            height: 2.5,
            decoration: BoxDecoration(
              color: accentBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        // Rectángulo decorativo inferior
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width * 0.35,
            height: 6,
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(Size size) {
    return Column(
      children: [
        // Logo circular con efecto de difuminado
        Container(
          width: size.width * 0.45,
          height: size.width * 0.45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: primaryBlue.withOpacity(0.08),
                blurRadius: 15,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: accentBlue.withOpacity(0.05),
                blurRadius: 30,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              )
            ],
            gradient: RadialGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.9),
              ],
              center: Alignment.center,
              radius: 0.8,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12), // Reducido el padding de 24 a 12
            child: Image.asset(
              'assets/logo_naturisa.png',
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Reemplazar el texto simple con un diseño premium con gradiente
        SizedBox(height: size.height * 0.015),

// Título con gradiente de lujo
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Color(0xFF2C4680), // Azul profundo
              Color(0xFF152F69), // Azul intermedio
              primaryBlue,
              Color(0xFF2C4680), // Azul profundo
              Color(0xFF152F69), // Azul oscuro
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
          ).createShader(bounds),
          child: Text(
            'NATURISA',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: 3.5,
              height: 1,
              shadows: [
                Shadow(
                  color: primaryBlue.withOpacity(0.3),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),

// Efecto de resplandor sutil bajo el título
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            width: 100,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  accentBlue.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        const SizedBox(height: 8),

        const SizedBox(height: 4),

        Text(
          'Sistema de Monitoreo',
          style: TextStyle(
            fontSize: 14,
            color: textDark.withOpacity(0.7),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(Size size, AuthService authService) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.05), // Reducido de 0.06 a 0.05
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: mediumGray.withOpacity(0.6),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título del formulario
          Text(
            'Iniciar sesión',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: primaryBlue,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Ingrese sus credenciales para continuar',
            style: TextStyle(
              fontSize: 13,
              color: textDark.withOpacity(0.6),
            ),
          ),

          SizedBox(height: size.height * 0.02),

          // Campos optimizados
          _buildCompactInputField(
            controller: userController,
            labelText: 'Usuario',
            prefixIcon: Icons.person_rounded,
            onChanged: (value) {
              UserProvider.formValues['user'] = value;
            },
          ),

          SizedBox(height: size.height * 0.015),

          _buildCompactInputField(
            controller: passwordController,
            labelText: 'Contraseña',
            prefixIcon: Icons.lock_rounded,
            obscureText: _obscureText,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {
              UserProvider.formValues['password'] = value;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_outlined : Icons.visibility,
                color: textDark.withOpacity(0.5),
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),

          SizedBox(height: size.height * 0.025),

          // Botón de inicio de sesión
          if (isLoading)
            Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: primaryBlue,
                  strokeWidth: 3,
                ),
              ),
            )
          else
            _buildPrimaryButton(
              onPressed: () async {
                if (userController.text.trim().isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Complete todos los campos'),
                      backgroundColor: primaryBlue,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  return;
                }
                await login(
                  userController.text.trim(),
                  passwordController.text,
                );
              },
              label: 'INICIAR SESIÓN',
            ),

          SizedBox(height: size.height * 0.02),

          // Sección de huella digital optimizada
          StorageService.prefs.getBool('setHuella')!
              ? _buildBiometricLoginSection(authService, size)
              : _buildEnableBiometricSection(size),
        ],
      ),
    );
  }

  // Campo de texto más compacto
  Widget _buildCompactInputField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 52, // Altura fija para optimizar espacio
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: mediumGray,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: textDark,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: textDark.withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              prefixIcon,
              color: primaryBlue,
              size: 18,
            ),
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        ),
        cursorColor: accentBlue,
      ),
    );
  }

  Widget _buildPrimaryButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48, // Reducido de 54 a 48
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryBlue,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildBiometricLoginSection(AuthService authService, Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: mediumGray,
                thickness: 1.5,
                height: 16, // Reducido de 20 a 16
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'o',
                style: TextStyle(
                  color: textDark.withOpacity(0.6),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: mediumGray,
                thickness: 1.5,
                height: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.01),
        InkWell(
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
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            padding:
                const EdgeInsets.symmetric(vertical: 10), // Reducido de 14 a 10
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: accentBlue.withOpacity(0.4), width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fingerprint,
                  size: 22,
                  color: accentBlue,
                ),
                const SizedBox(width: 8),
                Text(
                  'Usar huella digital',
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnableBiometricSection(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12), // Reducido de 16 a 12
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: mediumGray,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accentBlue.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              Icons.fingerprint,
              color: accentBlue,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activar huella digital',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Para acceso rápido y seguro',
                  style: TextStyle(
                    color: textDark.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch.adaptive(
              value: UserProvider.huella,
              onChanged: (value) {
                setState(() {
                  UserProvider.setHuella(value);
                });
              },
              activeColor: accentBlue,
              activeTrackColor: primaryBlue.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Botón de ayuda
        TextButton(
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
            foregroundColor: textDark.withOpacity(0.7),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: mediumGray),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help_outline_rounded,
                size: 14,
                color: accentBlue,
              ),
              const SizedBox(width: 6),
              Text(
                '¿Ayuda?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Logos de la empresa
        Row(
          children: [
            _buildCompanyLogo('assets/melacorp.png', size),
            SizedBox(width: size.width * 0.03),
            _buildCompanyLogo('assets/iconoGps.png', size),
          ],
        ),
      ],
    );
  }

  Widget _buildCompanyLogo(String assetPath, Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: mediumGray.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Image.asset(
        assetPath,
        height: 22,
      ),
    );
  }
}

void alertDialog(BuildContext context, String message) {
  final Color primaryBlue = const Color.fromRGBO(9, 31, 72, 1);
  final Color textDark = const Color.fromRGBO(25, 30, 40, 1);

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Error de autenticación',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 15,
            color: textDark.withOpacity(0.8),
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: primaryBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'ACEPTAR',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      );
    },
  );
}
