import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:live_tracking/models/base_response.dart';
import 'package:live_tracking/models/device.dart';
import 'package:live_tracking/repositories/base_geolocation_repository.dart';
import 'package:live_tracking/helpers/flash_message_helper.dart';
import 'package:live_tracking/repositories/base_repository.dart';
import 'package:live_tracking/utils/constants.dart';
import 'package:live_tracking/utils/enums.dart';
import 'package:live_tracking/utils/exceptions.dart';
import 'package:live_tracking/utils/typedefs.dart';

class GeolocationRepository extends BaseRepository {
  
  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        GetIt.I<FlashMessageHelper>()
            .showError('location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      GetIt.I<FlashMessageHelper>().showError(
          'Location permission are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<BaseResponse<Device>> sendTelematic(
    double altitude,
    double speed,
    double lat,
    double long,
    double bearing
  ) async {
    final response = await post(
      ApiEndPoint.kApiSendTelematic,
      data: {
        'altitude': altitude,
        'speed': speed,
        'lat' : lat,
        'long' : long,
        'bearing' : bearing
      },
    );

    if (response.status == ResponseStatus.success) {
      final data = response.data! as MapString;
      final rawData = data as MapString;
      final device = Device.fromJson(rawData);

      return BaseResponse.success(device);
    }
    throw CustomExceptionString(response.message ?? 'Unknown error');
  }
}
