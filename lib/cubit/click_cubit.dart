import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pr3/themes/themes.dart';

import '../main.dart';

part 'click_state.dart';

bool DarkTheme = false;

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());

  int sum = newCount;
  String themeName = "";
  void onClick(int i) {
    sum = (DarkTheme && i > 0)
        ? sum += i + 1
        : sum = (DarkTheme && i < 0) ? sum = sum + (i - 1) : sum += i;
    if (sum < 0) {
      emit(ClickError("Счетчик не может быть меньше нуля"));
      sum = 0;
      return;
    }
    themeName = (DarkTheme == true) ? "Black" : "White";
    emit(Click(sum, themeName));
  }
}

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(SwitchState(darkOff: true));

  void onSwitch(bool? value, bool doReload) {
    if (doReload) {
      DarkTheme = (DarkTheme == true) ? false : true;
    } else {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(changeState: value));
  }
}
