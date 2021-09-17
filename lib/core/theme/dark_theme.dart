part of theme;

final ThemeData darkThemeData = ThemeData.dark().copyWith(
  primaryColor: const Color.fromRGBO(77, 182, 172, 1.0),
  primaryColorDark: const Color.fromRGBO(0, 121, 107, 1.0),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color.fromRGBO(77, 182, 172, 1.0),
  ),
  errorColor: const Color.fromRGBO(207, 102, 121, 1.0),
  indicatorColor: const Color.fromRGBO(77, 182, 172, 1.0),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(77, 182, 172, 1.0),
    primaryVariant: Color.fromRGBO(0, 121, 107, 1.0),
    secondary: Color.fromRGBO(176, 190, 197, 1.0),
    secondaryVariant: Color.fromRGBO(176, 190, 197, 1.0),
    background: Color.fromRGBO(18, 18, 18, 1.0),
    surface: Color.fromRGBO(18, 18, 18, 1.0),
    error: Color.fromRGBO(207, 102, 121, 1.0),
    onPrimary: Color.fromRGBO(0, 0, 0, 1.0),
    onSecondary: Color.fromRGBO(0, 0, 0, 1.0),
    onBackground: Color.fromRGBO(255, 255, 255, 1.0),
    onSurface: Color.fromRGBO(255, 255, 255, 1.0),
    onError: Color.fromRGBO(0, 0, 0, 1.0),
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(0, 150, 136, 1.0),
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
      borderRadius: BorderRadius.circular(10),
    ),
    foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
    backgroundColor: const Color.fromRGBO(77, 182, 172, 1.0),
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
