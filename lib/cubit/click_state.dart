part of 'click_cubit.dart';

@immutable
abstract class ClickState {}

class ClickInitial extends ClickState {}

class ClickError extends ClickState {
  final String message;

  ClickError(this.message);
}

class Click extends ClickState {
  int count;
  String theme;

  Click(this.count, this.theme);
}

class SwitchState {
  bool isDarkThemeOff = false;
  ThemeData theme = ThemeData(brightness: Brightness.dark);
  SwitchState({required this.isDarkThemeOff}) {
    if (isDarkThemeOff) {
      theme = ThemeData(brightness: Brightness.light);
    } else {
      theme = ThemeData(brightness: Brightness.dark);
    }
  }

  SwitchState copyWith({bool? changeState}) {
    return SwitchState(isDarkThemeOff: changeState ?? isDarkThemeOff);
  }
}
