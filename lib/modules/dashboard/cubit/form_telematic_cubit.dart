import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'form_telematic_state.dart';

// class FormTelematicCubit extends Cubit<FormTelematicState> {
//   FormTelematicCubit() : super(FormTelematicState.initial());

//   void setAltitude(double altitude) {
//     emit(state.copyWith(altitude: altitude));
//   }

//   void setSpeed(double speed) {
//     emit(state.copyWith(speed: speed));
//   }

//   void setLat(double lat) {
//     emit(state.copyWith(lat: lat));
//   }

//   void setLong(double long) {
//     emit(state.copyWith(long: long));
//   }

//   void setTimestamp(DateTime timestamp) {
//     emit(state.copyWith(timestamp: timestamp));
//   }
// }