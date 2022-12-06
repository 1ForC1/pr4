import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'click_state.dart';

bool isDark = false;

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());

  int count = 0;
  String theme = "";
  void onClick(int i) {
    if (isDark && i > 0) {
      count += i + 1;
    } else if (isDark && i < 0) {
      count = count + (i - 1);
    } else {
      count += i;
    }
    if (count < 0) {
      emit(ClickError("Счетчик не может быть меньше нуля"));
      count = 0;
      return;
    }
    switch (isDark) {
      case true:
        theme = "Dark";
        break;
      case false:
        theme = "Light";
        break;
      default:
    }
    emit(Click(count, theme));
  }
}

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(SwitchState(isDarkThemeOff: true));

  void toggleSwitch(bool? value, bool doReload) {
    if (doReload) {
      if (isDark) {
        isDark = false;
      } else {
        isDark = true;
      }
    } else {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(changeState: value));
  }
}
