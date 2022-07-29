part of 'geolocation_bloc.dart';

// abstract class GeolocationEvent extends Equatable {
//   const GeolocationEvent();

//   @override
//   List<Object> get props => [];
// }

@immutable
abstract class GeolocationEvent {}

// class RefreshPage extends GeolocationEvent {}

class LoadGeolocation extends GeolocationEvent {}

class UpdateGeolocation extends GeolocationEvent {
  UpdateGeolocation(this.position);
  final Position position;


  @override
  List<Object> get props => [position];
}
