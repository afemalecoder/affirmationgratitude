part of theme;

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    _getThemeMood().then((bool value) async {
      if (!value) {
        _isDarkTheme = value;
        _currentTheme = lightThemeData;
      } else {
        _isDarkTheme = value;
        _currentTheme = darkThemeData;
      }
      notifyListeners();
    });
  }

  static ThemeProvider instance = ThemeProvider();

  static const isDarkThemeKey = 'is_dark_theme';

  static Future<SharedPreferences> preferences =
      SharedPreferences.getInstance();

  static Future<bool> _getThemeMood() async {
    final SharedPreferences prefs = await preferences;
    return prefs.getBool(isDarkThemeKey) ?? false;
  }

  Future<void> toggleAppTheme() async {
    final SharedPreferences prefs = await preferences;
    if (_currentTheme == darkThemeData) {
      _setToLightMode(prefs);
      return;
    }
    if (_currentTheme == lightThemeData) {
      _setToDarkMode(prefs);
      return;
    }
  }

  void _setToLightMode(SharedPreferences prefs) {
    _isDarkTheme = false;
    prefs.setBool(isDarkThemeKey, false);
    _currentTheme = lightThemeData;
    notifyListeners();
  }

  void _setToDarkMode(SharedPreferences prefs) {
    _isDarkTheme = true;
    prefs.setBool(isDarkThemeKey, true);
    _currentTheme = darkThemeData;
    notifyListeners();
  }

  bool? _isDarkTheme;

  ThemeData _currentTheme = lightThemeData;

  bool? get darkTheme => _isDarkTheme;

  ThemeData get affirmationTheme => _currentTheme;
}
