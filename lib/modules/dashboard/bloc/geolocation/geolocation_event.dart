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
  // UpdateGeolocation(this.position);
  // final Position position;

  // @override
  // List<Object> get props => [position];

}

class SendGeolocationEvent extends GeolocationEvent {
  SendGeolocationEvent({
    required this.altitude,
    required this.speed,
    required this.lat,
    required this.long,
    required this.bearing,
  });

  final double altitude;
  final double speed;
  final double lat;
  final double long;
  final double bearing;

  @override
  List<Object> get props => [altitude, speed, lat, long, bearing];
}
