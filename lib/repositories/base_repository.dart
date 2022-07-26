import 'package:live_tracking/models/base_response.dart';
import 'package:live_tracking/services/api_services.dart';
import 'package:live_tracking/utils/enums.dart';
import 'package:live_tracking/utils/exceptions.dart';
import 'package:live_tracking/utils/typedefs.dart';
import 'package:live_tracking/utils/wrappers/response_wrapper.dart';

abstract class DataTableRepository<M> extends BaseRepository {
  Future<BaseResponse<List<M>>> getDatatable(
    String key,
    String filter,
    MapStringValue sorts,
    int perPage,
    int page,
  );

  Future<BaseResponse<MapString>> deleteDatatable(String id);
}

abstract class BaseRepository extends ApiServices {
  T responseWrapper<T>(
    ResponseOfRequest response, {
    Function(Object e)? onError,
  }) =>
      ResponseWrapper.guard(response, onError: onError);
}
