import 'package:flutter_test/flutter_test.dart';
// import 'package:pocket_tasks/model/state_mgt/theme_mode/theme_provider.dart';
import 'package:pocket_tasks/model/theme_mode/theme_Provider.dart';

void main() {
  group('ThemeProvider', () {
    test('should toggle theme mode', () {
      final themeProvider = ThemeProvider();
      final initialMode = themeProvider.isDarkMode;
      themeProvider.toggleTheme();
      expect(themeProvider.isDarkMode, !initialMode);
    });
  });
}
