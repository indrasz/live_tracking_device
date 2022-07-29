part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoadedSuccess extends LocationState {
  final LocationData location;

  LocationLoadedSuccess(this.location);

  @override
  List<Object> get props => [location];
}

class LocationError extends LocationState {}
