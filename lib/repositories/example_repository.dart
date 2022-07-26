import 'package:live_tracking/models/base_response.dart';
import 'package:live_tracking/repositories/base_repository.dart';
import 'package:live_tracking/utils/constants.dart';

class ExampleRepository extends BaseRepository {
  Future<BaseResponse<List>> getExamples(String key) async {
    final response = await get(
      ApiEndPoint.kApiLogin,
      queryParameters: <String, String>{
        'search_columns': 'name',
        'search_key': key,
        'page': '-1',
      },
    );

    final result = responseWrapper<List>(response);
   
    return BaseResponse.success(result);
  }
}
