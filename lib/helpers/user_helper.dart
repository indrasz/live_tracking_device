import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:live_tracking/helpers/flash_message_helper.dart';
import 'package:live_tracking/helpers/navigation_helper.dart';
import 'package:live_tracking/models/user.dart';
import 'package:live_tracking/services/hive_service.dart';

/// Service to manage the user so that it can be used in any class.
class UserHelper {
  // Is user logged in?
  bool get isLoggedIn => GetIt.I.get<HiveService>().getUser() != null;

  User? getUser() {
    return GetIt.I<HiveService>().getUser();
  }

  /// Handle logout
  Future logout() async {
    try {
      await GetIt.I<HiveService>().deleteUser();
      await GetIt.I<FlutterSecureStorage>().deleteAll();
      GetIt.I<NavigationHelper>().goToLogin();
    } catch (e) {
      GetIt.I<FlashMessageHelper>().showError(e.toString());
    }
  }
}
