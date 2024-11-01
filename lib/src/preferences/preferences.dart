import 'package:shared_preferences/shared_preferences.dart';

final preferences = Preferences();

class Preferences {
  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  late SharedPreferences _prefs;

  Future<void> initPrefs() async =>
      _prefs = await SharedPreferences.getInstance();

  void delPrefs() {
    token = '';
  }

  String get uToken => _prefs.getString('uToken') ?? "";

  set token(String value) => _prefs.setString('uToken', value);
}
