import 'package:flutter/foundation.dart';

import 'package:pet_adoption/src/utils/theme_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  ThemePreferences themePreferences = ThemePreferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    themePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
