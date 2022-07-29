import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'form_telematic_state.dart';

class FormTelematicCubit extends Cubit<FormTelematicState> {
  FormTelematicCubit() : super(FormTelematicState.initial());

  void setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password));
  }
}