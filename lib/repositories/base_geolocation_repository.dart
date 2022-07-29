
import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocationRepository{
  Future<Position?> getCurrentLocation();

  // example() {
  //     Position position;
  //     position.altitude;
  // }

}