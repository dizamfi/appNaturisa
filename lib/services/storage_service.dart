import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveCredentials(String user, String password) async {
    await prefs.setString('user', user);
    await prefs.setString('password', password);
  }

  Future<void> saveUser(String name, String lastName, String phone,
      String cargo, String conexion) async {
    await prefs.setString('nombre', name);
    await prefs.setString('apellido', lastName);
    await prefs.setString('celular', phone);
    await prefs.setString('cargo', cargo);
    // await prefs.setString('profileImage', photo);
    await prefs.setString('ultconexion', conexion);
  }

  static Future<void> saveHuella(bool huella) async {
    await prefs.setBool('setHuella', huella);
  }

  static Future<void> saveFlag(bool flag, String name) async {
    await StorageService.prefs.setBool(name, flag);
  }

  static Future<void> saveFlagBombeoCali(
    bool flag,
  ) async {
    await StorageService.prefs.setBool('FlagBombeoCali', flag);
  }

  Future<void> authenticateWithHuella(bool value) async {
    await prefs.setBool('authHuella', value);
  }

  Future<void> clearCredentials() async {
    await prefs.remove('user');
    await prefs.remove('password');
  }
}
