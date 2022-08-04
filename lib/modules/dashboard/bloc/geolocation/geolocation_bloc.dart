import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:live_tracking/helpers/flash_message_helper.dart';
import 'package:live_tracking/repositories/geolocation_repository.dart';
import 'package:live_tracking/utils/wrappers/error_wrapper.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc() : super(GeolocationInitial()) {
    on<LoadGeolocation>(_getGeolocation);
    on<SendGeolocationEvent>(_sendTelematic);
  }

  final _repo = GeolocationRepository();

  Future _getGeolocation(LoadGeolocation event, Emitter emit) async {
    emit(GeolocationLoading());
    try {
      final value = await _repo.getCurrentLocation();
      emit(GeolocationLoadedSuccess(value));
    } catch (e) {
      GetIt.I<FlashMessageHelper>().showError(e.toString());
      emit(GeolocationError());
    }
  }

  Future _sendTelematic(SendGeolocationEvent event, Emitter emit) async {
    emit(GeolocationLoading());
    await ErrorWrapper.asyncGuard(
      () => _repo.sendTelematic(
        event.altitude,
        event.speed,
        event.lat,
        event.long,
        event.bearing,
      ),
      onError: (e) {
        emit(GeolocationInitial());
        GetIt.I<FlashMessageHelper>().showError("Failed Send Data");
      },
    );
  }
}
