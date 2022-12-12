part of 'click_cubit.dart';

@immutable
abstract class ClickState {}

class ClickInitial extends ClickState {}

class ClickError extends ClickState {
  final String message;

  ClickError(this.message);
}

class Click extends ClickState {
  int sum;
  String themeName;

  Click(this.sum, this.themeName);
}

class SwitchState {
  bool darkOff = false;
  ThemeData theme = ThemeData();
  ThemesChange themesChange = ThemesChange();
  SwitchState({required this.darkOff}) {
    theme = themesChange.change(darkOff);
  }

  SwitchState copyWith({bool? changeState}) {
    return SwitchState(darkOff: changeState ?? darkOff);
  }
}
