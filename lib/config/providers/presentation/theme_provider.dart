
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/theme/app_theme.dart';


// Un simple boolean - usando NotifierProvider en lugar de StateProvider
final isDarkmodeProvider = NotifierProvider<IsDarkmodeNotifier, bool>(
  IsDarkmodeNotifier.new,
);

// Un simple int - usando NotifierProvider en lugar de StateProvider
final selectedColorProvider = NotifierProvider<SelectedColorNotifier, int>(
  SelectedColorNotifier.new,
);

// Un objeto de tipo AppTheme (custom)
final themeNotifierProvider = NotifierProvider<ThemeNotifier, AppTheme>(
  ThemeNotifier.new,
);

// Notifier para dark mode
class IsDarkmodeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}

// Notifier para color seleccionado
class SelectedColorNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void changeColorIndex(int colorIndex) {
    state = colorIndex;
  }
}

// Controller o Notifier principal para AppTheme
class ThemeNotifier extends Notifier<AppTheme> {
  
  // build method es requerido y retorna el estado inicial
  @override
  AppTheme build() => AppTheme();

  void toggleDarkmode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}