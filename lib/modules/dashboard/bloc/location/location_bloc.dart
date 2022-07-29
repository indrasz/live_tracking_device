import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:live_tracking/repositories/location_repository.dart';
import 'package:live_tracking/helpers/flash_message_helper.dart';
import 'package:location/location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LoadedLocation>(_getLocation);
  }

  final _repo = LocationRepository();

  Future _getLocation(LoadedLocation event, Emitter emit) async {
    emit(LocationLoading());
    try {
      final value = await _repo.getCurrentLocation();
      print(value);
      emit(LocationLoadedSuccess(value));
    } catch (e) {
      GetIt.I<FlashMessageHelper>().showError(e.toString());
      emit(LocationError());
    }
  }
}
