import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  ModeCubit() : super(ModeInitial());

  bool isLight=true;

  changeMode(){
    isLight=!isLight;
    emit(ModeSuccess());
  }

}
