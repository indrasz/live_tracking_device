part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class LoadedLocation extends LocationEvent{}

class UpdateLocation extends LocationEvent{
  UpdateLocation(this.location);

  final LocationData location;

  @override
  List<Object> get props => [location];
}
