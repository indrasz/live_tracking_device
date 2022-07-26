import 'package:live_tracking/models/base_response.dart';
import 'package:live_tracking/utils/enums.dart';
import 'package:live_tracking/utils/exceptions.dart';
import 'package:live_tracking/utils/typedefs.dart';

class ResponseWrapper {
  static T guard<T>(
    ResponseOfRequest response, {
    Function(Object e)? onError,
  }) {
    assert(T == MapString || T == List, 'T must be MapString or List');

    try {
      if (response.status == ResponseStatus.success) {
        final data = response.data! as MapString;
        final raw = data['data'] as T;

        return raw;
      }
      throw CustomExceptionString(response.message ?? 'Unknown error');
    } catch (e) {
      onError?.call(e);
      rethrow;
    }
  }
}
