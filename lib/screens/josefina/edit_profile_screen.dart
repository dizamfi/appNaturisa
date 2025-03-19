import 'dart:io';

import 'package:appnaturisa/helpers/theme.dart';
import 'package:appnaturisa/providers/user_provider.dart';
import 'package:appnaturisa/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image; // Variable para almacenar la imagen seleccionada

  final ImagePicker _picker = ImagePicker();

  // Controladores de texto para cada campo
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Clave para el formulario

  @override
  void initState() {
    super.initState();
    _loadUserPreferences(); // Cargar preferencias al iniciar
  }

  // Cargar datos desde SharedPreferences
  Future<void> _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _nameController.text = prefs.getString('nombre') ?? '';
      _lastNameController.text = prefs.getString('apellido') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('celular') ?? '';
      _cargoController.text = prefs.getString('cargo') ?? '';
    });
    // Cargar la imagen desde las preferencias
    final imagePath = prefs.getString('profileImage');
    if (imagePath != null && File(imagePath).existsSync()) {
      _image = File(imagePath);
    }
  }

  Future<void> _saveUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', _nameController.text);
    await prefs.setString('apellido', _lastNameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('celular', _phoneController.text);
    await prefs.setString('cargo', _cargoController.text);

    // final bytes = await _image!.readAsBytes();
    // final base64Image = base64Encode(bytes);

    // await prefs.setString('profileImage', _image!.path);

    if (_image != null) {
      await prefs.setString('profileImage', _image!.path);
    }

    UserProvider.profileUpdated.value = true;

    UserProvider.updateUser(prefs.getString('user')!, {
      "nombre": _nameController.text,
      "apellido": _lastNameController.text,
      "email": _emailController.text,
      "celular": _phoneController.text,
      "cargo": _cargoController.text,
      // "foto": prefs.getString('profileImage')
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil guardado exitosamente')),
    );
  }

  // Método para seleccionar la imagen
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(
            pickedFile.path); // Actualiza el estado con la imagen seleccionada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
        canPop: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // Avatar con botón de edición

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        iconSize: 30,
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            const Color.fromRGBO(201, 202, 203, 0.5),
                        backgroundImage:
                            StorageService.prefs.getString('profileImage') !=
                                    null
                                ? FileImage(File(StorageService.prefs
                                    .getString('profileImage')!))
                                : null,
                        child: StorageService.prefs.getString('profileImage') ==
                                null
                            ? Text(
                                "${StorageService.prefs.getString('nombre')![0]}${StorageService.prefs.getString('apellido')![0]}",
                                style: GoogleFonts.roboto(fontSize: 24),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap:
                              _pickImage, // Llama al método para seleccionar imagen
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme
                                  .primaryBlue, // Color del botón de edición
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Nombre del usuario
                  const SizedBox(height: 20),
                  // Campo editable de Nombre
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Nombre",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Campo editable de Ubicación

                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: "Apellido",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La ubicación es requerida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El email es requerido';
                      }
                      // Expresión regular para validar el formato de email
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Ingrese un email válido (example@domain.com)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Campo editable de Teléfono
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Teléfono",
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El teléfono es requerido';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Ingresa un número de 10 dígitos';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _cargoController,
                    decoration: const InputDecoration(
                      labelText: "Cargo",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El cargo es requerido';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 60),
                  // Botón para guardar los cambios
                  ElevatedButton(
                    onPressed: () {
                      // Validar antes de guardar
                      if (_formKey.currentState!.validate()) {
                        _saveUserPreferences();
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      // disabledBackgroundColor: Colors.amber,
                      // elevation: 0,
                      foregroundColor: const Color.fromARGB(255, 141, 142, 143),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20.0,
                      ),
                      side: const BorderSide(color: Colors.black26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: const Text(
                      "Guardar cambios",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
