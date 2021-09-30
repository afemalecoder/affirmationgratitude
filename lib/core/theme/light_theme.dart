part of theme;

final ThemeData lightThemeData = ThemeData(
  primarySwatch: Colors.indigo,
  primaryColorDark: const Color.fromRGBO(107, 119, 247, 1.0),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color.fromRGBO(255, 255, 255, 1.0),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(107, 119, 247, 1.0),
    primaryVariant: Color.fromRGBO(193, 200, 255, 1.0),
    secondary: Color.fromRGBO(107, 119, 247, 1),
    secondaryVariant: Color.fromRGBO(219, 222, 253, 1.0),
    background: Color.fromRGBO(255, 255, 255, 1.0),
    surface: Color.fromRGBO(138, 150, 246, 1.0),
    error: Color.fromRGBO(176, 0, 32, 1.0),
    onPrimary: Color.fromRGBO(255, 255, 255, 1.0),
    onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
    onBackground: Color.fromRGBO(135, 147, 250, 1.0),
    onSurface: Color.fromRGBO(255, 255, 255, 1.0),
    onError: Color.fromRGBO(255, 255, 255, 1.0),
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(107, 119, 247, 1.0),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 5.0,
    shadowColor: const Color(0xffffffff),
    margin: const EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 5.0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_defaultRadius),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_defaultRadius),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_defaultRadius),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    highlightElevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_defaultRadius),
    ),
    foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
    backgroundColor: const Color.fromRGBO(107, 119, 247, 1.0),
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Color.fromRGBO(37, 37, 37, 0.95),
    contentTextStyle: TextStyle(
      color: Color.fromRGBO(189, 189, 189, 1.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_defaultRadius),
        ),
      ),
    ),
  ),
);
