import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  ModeCubit() : super(ModeInitial());
  bool isLight=true;
  bool iconBool=true;

  IconData lightIcon= Icons.sunny;
  IconData darkIcon= Icons.nights_stay;

  changeMode(){
    isLight=!isLight;
    emit(ModeSuccess());
  }

  changeIcon(){
    iconBool=!iconBool;
    emit(IconSuccess());
  }

}
